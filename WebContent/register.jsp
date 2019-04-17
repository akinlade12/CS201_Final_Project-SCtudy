<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>

		function validate2() {
			if(document.getElementById("password").value != document.getElementById("recPassword").value){
				document.getElementById("errorMessage").innerHTML = "Your passwords do not match.";
				return false;
			}
			$.ajax({
				url: "register",
				data: {
					username: document.getElementById("username").value,
					password: document.getElementById("password").value,
					recPassword: document.getElementById("recPassword").value,
					about: document.getElementById("about").value
				},
				success: function(result) {
					if(result == "0"){
						//username is taken
						document.getElementById("errorMessage").innerHTML = "This username is already taken.";
						return;
					}
					else if (result == "1"){
						window.location.href="index.jsp";
					} else {
						console.log(result);
						
					}
				}
			})
		}
	</script>
	<head>
		<meta charset="UTF-8">
		<title>Register</title>
		<link rel="stylesheet" type="text/css" href="register.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body background="background.jpg">
		<div class="logo"><a id="logo" href="index.jsp" style="text-decoration: none; color: black; display: inline-block; font-family: Courier">SCtudy</a></div>
		<div class="form" id="container">
			<form action="register" method="GET">
				<div class="username">
					Username<br/><input class="userinput" id="username" type="text" name="username">
					<br/>
				</div>
				
				<div class="password">
					Password<br/><input class="passinput" id="password" type="password" name="password">
					<br/>
					<div class="passCheck">
					Confirm Password<br/><input class="passinput" id="recPassword" type="password" name="recPassword">
					</div>
					<br/>
					<strong><div id="errorMessage"></div></strong>
				</div>
				<div class="description">
					About<br/><textarea id="about" name="about" /></textarea>
				</div>
				<br/>
				<button class="register" type="button" name="register" onclick="validate2()" id="button">Register</button>
			</form>
		</div>
	</body>
</html>
