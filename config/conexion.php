<?php

$host = "franquicias-db.cxws6c248yfi.us-east-2.rds.amazonaws.com";
$dbname = "sigiv";
$username = "root";
$password = "Atencio20";



$conn = mysqli_connect($host, $username, $password, $dbname);

if (!$conn) {
    die("Conexión fallida: ". mysqli_connect_error());
}

?>