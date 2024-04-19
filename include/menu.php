<!-- Boutons pour afficher les thèmes -->
<nav>
    <a href="index.php">Accueil</a>
    <?php
    // Start session if not already started
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    // Display Themes link only if user is logged in
    if (isset($_SESSION['id'])) {
        echo '<a href="index.php?action=themes">Themes</a>';
    }
    // Check if user is logged in
    if (isset($_SESSION['id'])) {
        // User is logged in, display logout link
        echo '<a href="index.php?action=logout">Déconnexion</a>';
    } else {
        // User is not logged in, display login link
        echo '<a href="index.php?action=user">Creer un compte</a>';
        echo '<a href="index.php?action=login">Se connecter</a>';
    }
    ?>
</nav>
