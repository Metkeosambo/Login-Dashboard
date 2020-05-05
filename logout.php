<?php
	session_start();
	$_SESSION["username"] = "username";
	$_SESSION["logout"] = "logout";
	header("Location: login_form.php");
?>