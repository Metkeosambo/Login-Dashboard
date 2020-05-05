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
                }else {
                    echo '<script type="text/javascript">';
                    echo ' alert("លេខសំងាត់ មិនត្រឹមត្រូវ!");';
                      //not showing an alert box.
                    echo '</script>';
                }
            }else {
                echo '<script type="text/javascript">';
                echo ' alert("Please input the correct ID !")';  //not showing an alert box.
                echo '</script>';  
            } 
    }
    catch (PDOException $e) {
        $Imessage = "Error: " . $e->getMessage();
    }
    echo $Imessage;
?>