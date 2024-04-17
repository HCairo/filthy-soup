<?php
namespace forum;

use PDO;
use PDOException;

class ForumList {
    private $cnx;

    public function __construct(PDO $cnx) {
        $this->cnx = $cnx;
    }

    public function getForums() {
        $query = $this->cnx->query("SELECT * FROM forum_theme");
        $themes = $query->fetchAll(PDO::FETCH_ASSOC);
        foreach ($themes as $theme) {
            echo "<a href='index.php?action=sujets&themeId={$theme['id']}'>Thème : {$theme['nom']}</a><br>";
        }
    }

    public function getSujets($themeId) {
        $query = $this->cnx->prepare("SELECT * FROM forum_topic WHERE theme_id = ?");
        $query->execute([$themeId]);
        $sujets = $query->fetchAll(PDO::FETCH_ASSOC);
        foreach ($sujets as $sujet) {
            echo "<a href='index.php?action=posts&topicId={$sujet['id']}'>Sujet : {$sujet['title']}</a><br>";
        }
    }

    public function getReponses($sujetId) {
        $query = $this->cnx->prepare("SELECT * FROM forum_post WHERE topic_id = ?");
        $query->execute([$sujetId]);
        $reponses = $query->fetchAll(PDO::FETCH_ASSOC);
        foreach ($reponses as $reponse) {
            echo "Réponse : {$reponse['msg']}<br>";
        }
    }
}