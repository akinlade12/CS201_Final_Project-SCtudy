<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Study Spot</title>
		<link rel="stylesheet" type="text/css" href="details.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body background="background.jpg">
		
		<!-- Persistent top bar -->
		<div class="topBar">
			<a class="logo" id="logo" href="index.jsp" style="text-decoration: none; color: black; display: inline-block; font-family: Courier">SCtudy</a>
			<div class="barRight" style="display: inline-block;">
				<a id="login" href="login.jsp" style="text-decoration: none; color: black; display: inline-block;">Login</a>
				<a id="register" href="register.jsp" style="text-decoration: none; color: black; display: inline-block; padding-left: 10px;">Register</a>
			</div>
		</div>
		
		<!-- Details -->
		<div class="locationImage"><img src="placeholder-image.jpeg" alt="Study Space Image"></div>
		<div class="name">
			<div class="n">Name</div>
			<div class="b">
				<button id="favorite" style="font-size: 20px; background-color: rgb(140, 140, 140, .6); border-radius: 10px;">Favorite</button>
				<button id="review" style="font-size: 20px; background-color: rgb(140, 140, 140, .6); border-radius: 10px;">Write a Review</button>
			</div>
		</div>
		<div class="overallRatings">
			<table class="ratingTable">
				<tr>
					<th> Overall Rating:</th>
					<th></th>
				</tr>
				<tr>
					<th> Hours:</th>
					<th></th>
				</tr>
				<tr>
					<th> Outlet Availability:</th>
					<th></th>
				</tr>
				<tr>
					<th> Seating Type:</th>
					<th></th>
				</tr>
				<tr>
					<th> Light Source:</th>
					<th></th>
				</tr>
				<tr>
					<th> Noise Level:</th>
					<th></th>
				</tr>
				<tr>
					<th> Cafe Availability:</th>
					<th></th>
				</tr>
				<tr>
					<th> Indoor/Outdoor:</th>
					<th></th>
				</tr>
			</table>
		</div>
		
		<!-- Review Table: will ultimately put this in a for loop to list the proper amount of reviews -->
		<div class="reviews">
			<table class = "reviewTable">
				<tr>
					<td><i>Username</i></td>
				</tr>
				<tr>
					<td>Overall Rating: </td>
					<td></td>
				</tr>
				<tr>
					<td>Written Review: </td>
				</tr>
			</table>
		</div>
		
	</body>
</html>