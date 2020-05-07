<?php
    $con = new PDO("pgsql:host=localhost;dbname=DBAdmin", "postgres", "123");
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
?>