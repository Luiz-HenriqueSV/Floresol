<?php
session_start();

if (!isset($_SESSION["logado"]) || !== true) {
    header("Location: index.html");
    exit();
}