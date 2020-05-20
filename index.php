<?php
	include("connection/connect.php");
	$connection=new Database();
	$conn=$connection->dbConnection();
	
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Form Staff Login</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="storage/images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="storage/css/bootstrap.min.css?ver=<?= rand() ?>">
	<link rel="stylesheet" type="text/css" href="storage/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="storage/fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="storage/vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="storage/vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="storage/vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="storage/vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="storage/vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="storage/css/util.css">
	<link rel="stylesheet" type="text/css" href="storage/css/main.css?ver=<?= rand() ?>">
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
				<form class="login100-form validate-form">
						<!-- <span class="login100-form-logo">
							<img src="../Staff_loginV2/images/Turbotech_logo.png" alt="">
						</span> -->
					<div class="login100-form-logo">
						<img class="logo_img" src="storage/images/Turbotech_logo.png" alt="">
					</div>
					<span class="login100-form-title p-b-34 p-t-27">
						Log in
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Enter ID">
						<input class="input100" type="text" name="username" id="uname" required="required" placeholder="Your ID">
						<!-- <select name="username" id="uname" class="input100 form-control">
							<?php
								foreach($r as $key=>$rr){
									echo ($key<=1)?'<option value="-1" selected disabled hidden></option>':'';
									echo '<option value="'.$rr['id'].'">'.$rr['id_number'].'</option>';
								}
							?>
						</select> -->
						<span class="focus-input100" data-placeholder="&#xf207;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<input class="input100" type="password" name="pass" id="pp" required="required" placeholder="Your Password">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div  style="margin-bottom:10px"><span id="HelpBlockMessage" style="color:white"></span></div>
					<div class="container-login100-form-btn">
						<button type="button" class="login100-form-btn" name="btnLogin" onclick='login("uname","pp")'>
							Login
						</button>
						<!-- <input class="login100-form-btn" type="submit" name="btnLogin" value="Login"> -->
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<div id="dropDownSelect1"></div>
	<script src="storage/js/jquery-3.4.1.min.js"></script>
<script src="storage/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<!-- <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>	
	<script src="vendor/countdowntime/countdowntime.js"></script>	
	 -->
	 <script src="storage/js/main.js"></script>
	<script type='text/javascript'>
	$('input').keydown( function( event ) {
    if ( event.which === 13 ) {
		event.preventDefault();
		login("uname","pp");
    }
});
</script>
</html>
