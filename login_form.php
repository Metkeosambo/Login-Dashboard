<script>
	<?php
	session_start();
	$_SESSION["logout"]=="logout";
    ?> 
</script>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Form Staff Login</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<style>
		.logo_img {
			width: 120px;
			  height: 120px;
			  border-radius: 100%;
		}
	</style>
</head>
<body>
	<div class="limiter">
		<!-- <div class="container-login100" style="background-image: url('images/angkor_wat_wall.jpg');"> -->
			<div class="container-login100"> 
				<div class="wrap-login100">
				<form class="login100-form validate-form" action="" method="POST">
						<!-- <span class="login100-form-logo">
							<img src="../Staff_loginV2/images/Turbotech_logo.png" alt="">
						</span> -->
					<div class="login100-form-logo">
						<img class="logo_img" src="images/Turbotech_logo.png" alt="">
					</div>
					<span class="login100-form-title p-b-34 p-t-27">
						Log in
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Enter ID">
						<input class="input100" type="text" name="txtid" required="required" placeholder="Your ID">
						<span class="focus-input100" data-placeholder="&#xf207;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<input class="input100" type="password" name="txtpassword" required="required" placeholder="Your Password">
						<span class="focus-input100" data-placeholder= "&#xf191;"></span>
					</div>

					<div class="contact100-form-checkbox">
						<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
						<label class="label-checkbox100" for="ckb1">
							Remember me
						</label>
					</div>
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" name="btnLogin" onclick="">
							Login
						</button>
						<!-- <input class="login100-form-btn" type="submit" name="btnLogin" value="Login"> -->
					</div>
					<div class="text-center pt-3">
						<a class="txt1" href="#">
							Forgot Password?
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html> 
<?php

	$Imessage = '';
	$tbId = '';
    if(isset($_POST['btnLogin'])){
        $txtid = $_POST['txtid'];
		$txtpass = $_POST['txtpassword'];
		try {
			$conn = new PDO("pgsql:host=localhost;dbname=DBAdmin", "postgres", "123");
			$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);    
			$stmt = $conn->prepare("SELECT * From tbl_admin2 WHERE id='$txtid'");
			$stmt->execute(); 
				while($row=$stmt->fetch()){  
						$tbId=$row['id'];
						$tbPassword=$row['password'];
						$tbrow = $row['department'];
				}
				if ($txtid == $tbId){
					if($txtpass == $tbPassword){
						echo $_SESSION['department'] = $tbrow;
						header("Location: Dashboard.php");
					}else {
						echo '<script type="text/javascript">';
						echo ' alert("លេខសំងាត់ មិនត្រឹមត្រូវ!");';//not showing an alert box.
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
	}
?>

	<div id="dropDownSelect1"></div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<!-- <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>	
	<script src="vendor/countdowntime/countdowntime.js"></script>	
	<script src="js/main.js"></script> -->
</body>
</html>