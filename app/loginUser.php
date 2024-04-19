<?php
const APP = 'app';
const INC = 'include';
const JS = 'js';
const CSS = 'css';
const ASSETS = 'assets';

require_once(INC . '/top.php');
require_once(INC . '/menu.php');
require_once(APP . '/database.php');

use forum\Database;

try {
    $database = new Database();

    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'login') {
        // Form submission, handle login process
        $email = filter_var($_POST['email'], FILTER_VALIDATE_EMAIL);
        $password = $_POST['mdp'];

        $table ='user'; // Assuming this is your user table name

        if (!$database->getCnx()) {
            echo "Erreur de connexion à la base de données";
            exit;
        }

        $s = $database->getCnx()->prepare("SELECT * FROM $table WHERE email = ?");
        $s->execute([$email]);
        $r = $s->fetch();

        if ($r && password_verify($password, $r['password'])) {
            // Authentication successful, start session and store user data
            session_start();
            $_SESSION['id'] = $r['id'];
            $_SESSION['pseudo'] = $r['username'];
            $_SESSION['email'] = $r['email'];
            $_SESSION['niveau'] = $r['level_id'];

            // Handle remember me functionality
            if (isset($_POST['remember'])) {
                $token = password_hash(random_bytes(32), PASSWORD_DEFAULT);
                $ins = $database->getCnx()->prepare("UPDATE $table SET token = ? WHERE id = ?");
                $ins->execute([$token, $_SESSION['id']]);
                setcookie('forum_user_token', $token, time() + (60 * 60 * 24 * 30), "/");
            }

            // Redirect to home page or desired location after successful login
            header('Location: index.php');
            exit;
        } else {
            // Authentication failed, redirect to login page with error flag
            header('Location: index.php?action=login&error=1');
            exit;
        }
    }

    // Handle other actions or display default page
    // ...
} catch (PDOException $e) {
    echo "Erreur : " . $e->getMessage();
}

require_once(INC . '/bottom.php');
?>

<section>
    <form method="post">
        <h2>Connectez-vous</h2>
        <label for="email">Email</label><input type="text" name="email" id="email">
        <label for="mdp">Mot de passe</label><input type="password" name="mdp" id="mdp"> <!-- Change type to password -->
        <input type="hidden" name="action" value="login">
        <div class="form-check">
            <input type="checkbox" id="remember" name="remember"> 
            <label for="remember">
                RESTER CONNECTÉ
            </label>
        </div>
        <button type="submit">Se connecter</button> <!-- Change to submit button -->
    </form>
</section>