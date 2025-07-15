<?php
include 'db.php';
session_start();
if ($_SESSION['user']['role'] !== 'admin') {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $cat  = $_POST['category'];
    $desc = $_POST['description'];

    $stmt = $conn->prepare("INSERT INTO services (name, category, description) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $name, $cat, $desc);
    $stmt->execute();
    echo "Service added!";
}
?>

<form method="POST">
    <h2>Add Service</h2>
    Name: <input type="text" name="name" required><br>
    Category: <input type="text" name="category" required><br>
    Description:<br>
    <textarea name="description" required></textarea><br>
    <button type="submit">Add</button>
</form>
