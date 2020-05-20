<?php
session_start();
  if(isset($_POST['username']) && isset($_POST['pass'])&&!empty($_POST['pass'])&&!empty($_POST['username'])){
        include ("../connection/connect.php");
        include ("../controller/util.php");
        $connection=new Database();
        $conn=$connection->dbConnection();
        $uname=$_POST['username'];
        $pass=$_POST['pass'];
        $stmt = $conn->prepare("select company_dept_id from staff where id_number='$uname'");
			$stmt->execute(); 
				while($row=$stmt->fetch()){  
						$depart = $row['company_dept_id'];
				}
                $sql="select exec_check_password_main_app('".$uname."','".en($pass)."')";
                $q=$conn->prepare($sql);
                $q->execute();
                $r=$q->fetch(PDO::FETCH_ASSOC);
                $userid=$r['exec_check_password_main_app'];
        if($userid==0){
            echo 0;
        }elseif($userid>0){
            $_SESSION["depart_id"]=$depart;
            $_SESSION["userid"]=$userid;
            // header("location:../Dashboard.php");
            // header("location:../dashboard.php");
            echo "dashboard.php";
        }else{
            echo "no have";
        }
    }else{
        echo "null";
    }
?>