<?php
    $tbId = '';
    $tbPassword = '';
    $Imessage ='';
    if(isset($_POST['btnLogin'])){
        $txtid = $_POST['txtid'];
        $txtpass = $_POST['txtpassword'];
    }
    try {
        $conn = new PDO("pgsql:host=localhost;dbname=DBAdmin", "postgres", "123");
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);    
        $stmt = $conn->prepare("SELECT * From tbl_admin WHERE id='$txtid'");
        $stmt->execute(); 
            while($row=$stmt->fetch()){  
                    $tbId=$row['id'];
                    $tbPassword=$row['password'];
            }
            if ($txtid == $tbId){
                if($txtpass == $tbPassword){
                    include "Dashboard.php";
                    session_start();
                    // echo " <a href='http://www.youtube.com'>Click here </a> ";
                }else 
                    echo "Incorrect Password";
            }else echo "Incorrect Your ID";    
    }
    catch (PDOException $e) {
        $Imessage = "Error: " . $e->getMessage();
    }
    echo $Imessage;
?>