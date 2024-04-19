<?php
const APP = 'app';
const INC = 'include';
const JS = 'js';
const CSS = 'css';
const ASSETS = 'assets';

require_once(INC . '/top.php');
require_once(INC . '/menu.php');
require_once(APP . '/database.php');
require_once(APP . '/createFSP.php');
require_once(APP . '/showFSP.php');

use forum\Database;
use forum\ForumList;

try {
    $database = new Database();

    $action = isset($_GET['action']) ? $_GET['action'] : "";
    switch ($action) {
        default:
            // Page par défaut
            break;
        case 'themes':
            $forumList = new ForumList($database->getCnx());
            $forumList->getForums();
            require_once(APP . '/createForm.php');
            break;
        case 'sujets':
            // Afficher les sujets du thème spécifié
            $idTheme = isset($_GET['themeId']) ? $_GET['themeId'] : null;
            if ($idTheme) {
                $forumList = new ForumList($database->getCnx());
                $forumList->getSujets($idTheme);
            } else {
                echo "Erreur : Thème non spécifié.";
            }
            require_once(APP . '/createForm.php');
            break;
        case 'posts':
            // Afficher les posts du sujet spécifié
            $idSujet = isset($_GET['topicId']) ? $_GET['topicId'] : null;
            if ($idSujet) {
                $forumList = new ForumList($database->getCnx());
                $forumList->getReponses($idSujet);
            } else {
                echo "Erreur : Sujet non spécifié.";
            }
            require_once(APP . '/createForm.php');
            break;
    }
} catch (PDOException $e) {
    echo "Erreur : " . $e->getMessage();
}

require_once(INC . '/bottom.php');
?>