<?php
    if(isset($_GET['_session'])){
        session_start();
        if(isset($_SESSION['userid'])){
            if(empty($_SESSION['userid'])){
                echo '0';
            }
        }else{
            echo '0';
        }
    }
?>