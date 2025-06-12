<?php

$host = "localhost";
$dbname = "sigiv";
$username = "root";
$password = "";



$conn = mysqli_connect($host, $username, $password, $dbname);

if (!$conn) {
    die("Conexión fallida: ". mysqli_connect_error());
}

?>