<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		function validate2() {
			$.ajax({
				url: "login",
				data: {
					username: document.getElementById("username").value,
					password: document.getElementById("password").value
				},
				success: function(result) {
					if(result == "0"){
						//username is taken
						document.getElementById("errorMessage").innerHTML = "Invalid Username.";
						return;
					}
					else if (result == "2"){
						document.getElementById("errorMessage").innerHTML = "Password/Username do not match.";
						return;
					}
					else if (result == "1"){
						window.location.href="index.jsp";
					}else {
						console.log(result);
						alert(result);
					}
				}
			})
		}
	</script>
	<head>
		<meta charset="UTF-8">
		<title>Login</title>
		<link rel="stylesheet" type="text/css" href="login.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body background="background.jpg">
		<div class="logo"><a id="logo" href="index.jsp" style="text-decoration: none; color: black; display: inline-block; font-family: Courier">SCtudy</a></div>
		<div class="form">
			<form action="login" method="GET">
				<div class="username">
					Username<br/><input class="userinput" id="username" type="text" name="username">
					<br/>
				</div>
				<div class="password">
					Password<br/><input class="passinput" id="password" type="text" name="password">
					<br/>
					<strong><div id="errorMessage"></div></strong>
				</div>
				<br/>
				<div class="login">
					<button type="button" name="login" onclick="validate2()">Login</button>
				</div>
			</form>
		</div>
	</body>
</html>