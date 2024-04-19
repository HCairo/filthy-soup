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
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'user') {
        $hashOptions = [
            'memory_cost' => 1<<17, // 128MB
            'time_cost'   => 4,
            'threads'     => 2,
        ];
        $pseudo = htmlspecialchars($_POST['pseudo']);
        $email = filter_var($_POST['email'], FILTER_VALIDATE_EMAIL);
        $mdp = password_hash($_POST['mdp'], PASSWORD_ARGON2ID, $hashOptions);
        $birth = htmlspecialchars($_POST['birth']);
        $ip = $_SERVER['REMOTE_ADDR'];
        
        // Use prepared statements to prevent SQL injection
        $ins = $database->getCnx()->prepare("INSERT INTO user SET username = :pseudo, email= :email, password= :mdp, registration_ip = :ip");
        $ins->bindParam(':pseudo', $pseudo);
        $ins->bindParam(':email', $email);
        $ins->bindParam(':mdp', $mdp);
        $ins->bindParam(':ip', $ip);
        $ins->execute();

        // Prepare response
        $response = [
            'success' => true,
            'msg' => 'Utilisateur créé avec succès'
        ];
    }
} catch (Exception $e) {
    $response = ['success' => false, 'msg' => 'Erreur lors du traitement : ' . $e->getMessage()];
}

require_once(INC . '/bottom.php');
?>

<section>
    <form method="post" action="index.php?action=login">
        <h2>Créer un compte</h2>
        <label for="pseudo">Pseudo</label><input type="text" name="pseudo" id="pseudo">
        <label for="email">Email</label><input type="text" name="email" id="email">
        <label for="mdp">Mot de passe</label><input type="text" name="mdp" id="mdp">
        <input type="hidden" name="action" value="user"> <!-- Hidden field for action -->
        <button type="submit">Créer l'utilisateur</button>
    </form>
</section>