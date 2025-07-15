<?php
include 'db.php';
session_start();
$result = $conn->query("SELECT * FROM services");
?>

<h2>Browse Services</h2>
<ul>
<?php while ($row = $result->fetch_assoc()): ?>
    <li><strong><?= $row['name'] ?></strong> - <?= $row['category'] ?> <br><?= $row['description'] ?></li>
<?php endwhile; ?>
</ul>

<a href="index.php">Back to Home</a>
