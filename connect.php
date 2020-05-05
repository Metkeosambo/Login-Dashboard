<?php
    $con = new PDO("pgsql:host=localhost;dbname=turbotech_test", "postgres", "sambo_123!!");
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
?>