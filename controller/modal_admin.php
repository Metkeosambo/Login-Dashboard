<?php
$id = $_POST['id'];
include_once ("../connection/connect.php");
include_once ("../controller/util.php");
$connection=new Database();
$conn=$connection->dbConnection();
session_start();

     $output = '';   
     $statement = $conn->prepare("SELECT * FROM hr_suggestion_submited WHERE id=$id"); 
     $statement->execute(); 
     $output .= '  
     <div class="table-responsive">  
          <table class="table table-bordered">';  
     while($row=$statement->fetch(PDO::FETCH_ASSOC))  
     {  
          $output .= '  
               <tr>  
                    <td width="30%"><label>Name</label></td>  
                    <td width="70%">'.$row["id"].'</td>  
               </tr>  
               <tr>  
                    <td width="30%"><label>Address</label></td>  
                    <td width="70%">'.$row["create_date"].'</td>  
               </tr>  
               <tr>  
                    <td width="30%"><label>Gender</label></td>  
                    <td width="70%">'.$row["status"].'</td>  
               </tr>  
               ';  
     }  
     $output .= "</table></div>";  
     echo $output;  

?>