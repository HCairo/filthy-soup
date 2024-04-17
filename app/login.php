<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-type: application/json'); 

// Connexion à la base de données
require_once(APP . '/database.php');

class userLogin {
    $table ='user';
    $response = ['success' => false, 'message' => 'Une erreur est survenue'];

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Lecture des données JSON postées
    $data = json_decode(file_get_contents('php://input'), true);

    $email = filter_var($data['email'], FILTER_VALIDATE_EMAIL);
    $password = $data['mdp'];

    if (!$cnx) {
        $response['message'] = "Erreur de connexion à la base de données";
    } else {
        $s = $cnx->prepare("SELECT * FROM $table WHERE email = ?");
        $s->execute([$email]);
        $r = $s->fetch();

        if ($r && password_verify($password, $r['password'])) {
            // Démarrage de la session et stockage des données
            session_start();
            $_SESSION['id'] = $r['id'];
            $_SESSION['pseudo'] = $r['username'];
            $_SESSION['email'] = $r['email'];
            $_SESSION['niveau'] = $r['level_id'];

            if (isset($data['remember'])) {
                $token = password_hash(random_bytes(32), PASSWORD_DEFAULT); // Génération d'un jeton aléatoire pour se souvenir de l'utilisateur

                $ins = $cnx->prepare("UPDATE user SET token = ? WHERE id = ?"); // Préparation de la requête SQL pour mettre à jour le jeton dans la base de données
                $ins->execute([$token, $_SESSION['id']]); // Exécution de la requête de mise à jour du jeton

                // Création d'un cookie avec le jeton et définition de sa durée de validité (par exemple, un mois)
                setcookie('forum_user_token', $token, time() + (60 * 60 * 24 * 30), "/");            }

            $response = ['success' => true, 'message' => 'Connexion réussie'];
        } else {
            $response['message'] = "Adresse e-mail invalide ou mot de passe incorrect";
        }
    }

    echo json_encode($response);
    exit;
    }
}