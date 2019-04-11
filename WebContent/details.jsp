<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="main.StudySpace" %>
<!DOCTYPE html>
<html>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		function user(){
			$.ajax({
				url: "hack",
				data: {
					action: "checkStatus"
				},
				success: function(result) {
					if(result == "true"){
						document.getElementById("login").style.display = "none";
						document.getElementById("register").style.display = "none";
						document.getElementById("profile").style.display = "inline-block";
						document.getElementById("signOut").style.display = "inline-block";
					}
				}
			})
		}
		function signOut() {
			$.ajax({
				url: "hack",
				data: {
					action: "signOut"
				},
				success: function(result) {
					if(result == "false"){
						document.getElementById("login").style.display = "inline-block";
						document.getElementById("register").style.display = "inline-block";
						document.getElementById("profile").style.display = "none";
						document.getElementById("signOut").style.display = "none";
					}
				}
			})
		}
		function favorite(){
			$.ajax({
				url: "hack",
				data: {
					action: "favorite"
				},
				success: function(result) {

				}
			})	
		}
		window.onload = user();
	</script>
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
				<form action="profile" style="display:inline-block;"><button id="profile" type="submit" style="text-decoration: none; color: white; display: none; font-size:40px;">Profile</button></form>
				<a id="signOut" href="javascript:signOut();" style="text-decoration: none; color: white; display: none;">Sign Out</a>
			</div>
		</div>
		
		<!-- Details -->
		<div class="locationImage"><img src=<%= currentSearch.getPhotoURL() %> alt="Study Space Image"></div>
		<div class="name">
			<div class="n">Name</div>
				<div class="b">
		<!-- add on click functionality -->
		<% 	if(session.getAttribute("loggedIn")){ %>
					<button id="favorite" onclick="favorite()" style="font-size: 20px; background-color: rgb(140, 140, 140, .6); border-radius: 10px;">Favorite</button>
					<button id="review" style="font-size: 20px; background-color: rgb(140, 140, 140, .6); border-radius: 10px;">Write a Review</button>
		<%	}  %>
				</div>
		</div>
		<div class="overallRatings">
			<table class="ratingTable">
				<% 
				StudySpace currentSearch = session.getAttribute("currentStudySpot");
				%>
				<tr>
					<th> Overall Rating:</th>
					<th><%= currentSearch.getRating() %></th>
				</tr>
				<tr>
					<th> Hours:</th>
					<th><%= currentSearch.getHourOpen() %> to <%= currentSearch.getHourClose() %></th>
				</tr>
				<tr>
					<th> Outlet Availability:</th>
					<th><%= currentSearch.getOutlet() %></th>
				</tr>
				<tr>
					<th> Seating Type:</th>
					<th><%= currentSearch.getSeats() %></th>
				</tr>
				<tr>
					<th> Light Source:</th>
					<th><%= currentSearch.getLights() %></th>
				</tr>
				<tr>
					<th> Noise Level:</th>
					<th><%= currentSearch.getNoise() %></th>
				</tr>
				<tr>
					<th> Cafe Availability:</th>
					<th><%= currentSearch.getCafe() %></th>
				</tr>
				<tr>
					<th> Indoor/Outdoor:</th>
					<th><%= currentSearch.getOutside() %></th>
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