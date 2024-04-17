<?php
const APP = 'app';
const INC = 'include';

require_once(INC . '/top.php');
require_once(INC . '/menu.php');
require_once(APP . '/database.php');
require_once(APP . '/createFSP.php');
require_once(APP . '/showFSP.php');

use forum\Database;
use forum\ForumCreate;
use forum\ForumList;

try {
    $database = new Database();

    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        var_dump($_POST);

        $action = isset($_POST['action']) ? $_POST['action'] : "";
        switch ($action) {
            case 'user':
                $username = isset($_POST['username']) ? htmlspecialchars($_POST['username']) : null;
                $email = isset($_POST['email']) ? htmlspecialchars($_POST['email']) : null;
                $password = isset($_POST['password']) ? htmlspecialchars($_POST['password']) : null;
        
                // Validate input data
                if ($username && $email && $password) {
                    try {
                        $forumCreate = new ForumCreate($database->getCnx());
                        $userId = $forumCreate->createUser($username, $email, $password);
                        echo "Account created successfully with ID: $userId";
                    } catch (PDOException $e) {
                        echo "Error creating account: " . $e->getMessage();
                    }
                } else {
                    echo "Error: Missing parameters for account creation.";
                }
                break;
            }        
            case 'themes':
                // PROTECTION
                $nom = isset($_POST['nom']) ? htmlspecialchars($_POST['nom']) : null;
                if ($nom) {
                    $forumCreate = new ForumCreate($database->getCnx());
                    $forumCreate->createTheme($nom);
                    echo "Theme créé";
                } else {
                    echo "Erreur : paramètres manquants pour la création du theme.";
                }
                break;
            case 'sujets':
                // PROTECTION
                $title = isset($_POST['title']) ? htmlspecialchars($_POST['title']) : null;
                if ($title) {
                    // Recuperation de l'id du theme dans l'url
                    $themeId = isset($_GET['themeId']) ? $_GET['themeId'] : null;
                    $forumCreate = new ForumCreate($database->getCnx());
                    $sujetId = $forumCreate->createSujet($themeId, $title);
                    echo "Sujet créé avec l'ID : $sujetId";
                } else {
                    echo "Erreur : paramètres manquants pour la création du sujet.";
                }
                break;
            case 'posts':
                // PROTECTION
                $message = isset($_POST['message']) ? htmlspecialchars($_POST['message']) : null;
                if ($message) {
                    // Recuperation de l'id du sujet dans l'url
                    $topicId = isset($_GET['topicId']) ? $_GET['topicId'] : null; // Change sujetId to topicId
                    $forumCreate = new ForumCreate($database->getCnx());
                    $postId = $forumCreate->addPost($topicId, $message); // Change sujetId to topicId
                    echo "Message ajouté avec l'ID : $postId";
                } else {
                    echo "Erreur : paramètres manquants pour l'ajout du message.";
                }
                break;
        }
    }

    // On affiche le bon formulaire selon le cas
    $action = isset($_GET['action']) ? $_GET['action'] : "";
    switch ($action) {
        case 'user':
            // On affiche le formulaire de creation de compte
?>
            <form method="post" action="index.php?action=user">
                <input type="text" name="username" placeholder="Username" required><br>
                <input type="email" name="email" placeholder="Email" required><br>
                <input type="password" name="password" placeholder="Password" required><br>
                <button type="submit">Create Account</button>
            </form>
<?php
            break;
        case 'themes':
            // On affiche le formulaire de creation de theme
?>
            <form action="?action=themes" method="post">
                <input type="text" name="nom" placeholder="Nom">
                <button type="submit">Creation d'un theme</button>
                <input type="hidden" name="action" value="themes">
            </form>

<?php
            break;
        case 'sujets':
            // On affiche le formulaire de creation de sujet
?>
            <form action="?action=sujets&themeId=<?php echo isset($_GET['themeId']) ? $_GET['themeId'] : '';  ?>" method="post">
                <input type="hidden" name="themeId" value="<?php echo isset($_GET['themeId']) ? $_GET['themeId'] : ''; ?>">
                <input type="text" name="title" placeholder="Titre">
                <button type="submit">Creation d'un sujet</button>
                <input type="hidden" name="action" value="sujets">
            </form>

<?php
            break;
        case 'posts':
            // On affiche le formulaire de creation de post
?>
            <form action="?action=posts&topicId=<?php echo isset($_GET['topicId']) ? $_GET['topicId'] : ''; ?>" method="post">
                <input type="hidden" name="topicId" value="<?php echo isset($_GET['topicId']) ? $_GET['topicId'] : ''; ?>">
                <input type="text" name="message" placeholder="Message">
                <button type="submit">Creation d'un post</button>
                <input type="hidden" name="action" value="posts">
            </form>
<?php
            break;
        default:
            echo "Invalid action.";
            break;
    }
} catch (PDOException $e) {
    echo "Erreur : " . $e->getMessage();
}

require_once(INC . '/bottom.php');
?>