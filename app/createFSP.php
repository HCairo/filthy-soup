<?php
namespace forum;

use PDO;
use PDOException;

class ForumCreate {
    private $cnx;

    public function __construct(PDO $cnx) {
        $this->cnx = $cnx;
    }

    public function createUser($username, $email, $password) {
        try {
            // Hash the password
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
            
            // Prepare the SQL query
            $query = $this->cnx->prepare("INSERT INTO user (username, email, password) VALUES (?, ?, ?)");
        
            // Execute the query with parameters
            $query->execute([$username, $email, $hashedPassword]);
        
            // Return the last inserted ID
            return $this->cnx->lastInsertId();
        } catch (PDOException $e) {
            // Throw an exception with the error message
            throw new PDOException("Error creating account: " . $e->getMessage());
        }
    }    

    public function createTheme($nom) {
        try {
            // Prepare the SQL query
            $query = $this->cnx->prepare("INSERT INTO forum_theme (nom, theme_img_url) VALUES (?, 0)");
    
            // Execute the query with parameters
            $query->execute([$nom]);
    
            // Return the last inserted ID
            return $this->cnx->lastInsertId();
        } catch (PDOException $e) {
            // Throw an exception with the error message
            throw new PDOException("Erreur lors de la création du theme : " . $e->getMessage());
        }
    }

    public function createSujet($themeId, $title) {
        try {
            // Get the user's IP address
            $userIp = $_SERVER['REMOTE_ADDR'];
    
            // Prepare the SQL query
            $query = $this->cnx->prepare("INSERT INTO forum_topic (theme_id, title, user_id, user_ip) VALUES (?, ?, 28, ?)");
    
            // Execute the query with parameters
            $query->execute([$themeId, $title, $userIp]);
    
            // Return the last inserted ID
            return $this->cnx->lastInsertId();
        } catch (PDOException $e) {
            // Throw an exception with the error message
            throw new PDOException("Erreur lors de la création du sujet : " . $e->getMessage());
        }
    }
    

    public function addPost($topicId, $message) {
        try {
            // Get the user's IP address
            $userIp = $_SERVER['REMOTE_ADDR'];
    
            // Prepare the SQL query
            $query = $this->cnx->prepare("INSERT INTO forum_post (topic_id, user_id, msg, user_ip, edited_by_id) VALUES (?, 28, ?, ?, 0)");
    
            // Execute the query with parameters
            $query->execute([$topicId, $message, $userIp]);
    
            // Return the last inserted ID
            return $this->cnx->lastInsertId();
        } catch (PDOException $e) {
            // Throw an exception with the error message
            throw new PDOException("Erreur lors de l'ajout du message : " . $e->getMessage());
        }
    }
}