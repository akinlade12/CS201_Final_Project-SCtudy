<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Register</title>
		<link rel="stylesheet" type="text/css" href="register.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body background="background.jpg">
		<div class="logo"><a id="logo" href="index.jsp" style="text-decoration: none; color: black; display: inline-block; font-family: Courier">SCtudy</a></div>
		<div class="form">
			<form action="register" method="GET">
				<div class="username">
					Username<br/><input class="userinput" id="username" type="text" name="username">
					<br/>
				</div>
				<div class="password">
					Password<br/><input class="passinput" id="password" type="text" name="password">
					<br/>
					Confirm Password<br/><input class="passinput" id="recPassword" type="text" name="recPassword">
					<br/>
					<strong><div id="errorMessage"></div></strong>
				</div>
				<br/>
				<button class="register" type="button" name="register" onclick="validate2()">Register</button>
			</form>
		</div>
	</body>
</html>