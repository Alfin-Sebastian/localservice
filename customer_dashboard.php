<?php
session_start();
if ($_SESSION['user']['role'] !== 'customer') {
    header("Location: login.php");
    exit;
}
echo "<h2>Customer Dashboard</h2>";
echo "<p>Welcome, " . $_SESSION['user']['name'] . "</p>";
?>
<a href="logout.php">Logout</a>
