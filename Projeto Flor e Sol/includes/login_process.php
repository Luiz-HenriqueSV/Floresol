<?php
session_start();
$usuarioC = "admin";
$senhaC = "12345";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $usuario = $_POST["usuario"];
    $senha = $_POST["senha"];

    if ($usuario === $usuarioC && $senha === $senhaC) {
        $_SESSION["logado"] = true;
        $_SESSION["usuario"] = $usuario;
        header("Location: dashboard.php");
        exit();
    } else {
        echo "<p style='color:red; text-align: center;'>Usuário ou senha inválidos!</p>";
        echo "<p style='text-align:center;'><a href='index.html'>Voltar</a></p>";
        }
} else {
    header("location: index.html");
    exit();
}