<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="main.StudySpace" %>
<% Boolean logged = (Boolean) session.getAttribute("loggedIn");%>
<% 
	StudySpace currentSearch = (StudySpace) session.getAttribute("currentStudySpot");
	StudySpace space = new StudySpace("Space 1", -118.282968, 34.022100, "bovard.jpg", "Sparse", "Couch", "LED", 2,
		true, false, "8:00am", "5:00pm", "(925) 587-3144", "1800 Your Butt St", "WPH 209", 3.65, 5);
	
	if(currentSearch == null)
		currentSearch = space;
	
	Boolean favorited = (Boolean) request.getAttribute("favorited");
	String favorite = "";
	if(favorited == null || !favorited) {
		favorite = "Favorite";
	}
	else {
		favorite = "Unfavorite";
	}
%>
<!DOCTYPE html>
<html>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD3d8Oblehwi3ISiykxRtGtqD0btZkWjIs&callback=initialize"></script>
	<script>
		
	// Get the button that opens the modal
	var btn = document.getElementById("review");
	// Get the <span> element that closes the modal

	// When the user clicks the button, open the modal 
	 function show() {
			var modal = document.getElementById('myModal');
			var span = document.getElementsByClassName("close")[0];
	 		 modal.style.display = "block";
	}

	// When the user clicks on <span> (x), close the modal
	 function close1() {
			var modal = document.getElementById('myModal');
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
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
					action: document.getElementById("favorite").innerHTML
				},
				success: function(result) {
					document.getElementById("favorite").innerHTML = result;
				}
			})	
		}
		window.onload = user();
	</script>
	<script>
		function initialize() {
			var latitude = <%= currentSearch.getLatitude()%>;
			var longitude = <%= currentSearch.getLongitude()%>;
			var pos = {lat: latitude, lng: longitude};
			var mapOptions = {
					center: pos,
					zoom: 16
			};
			var map = new google.maps.Map(document.getElementById('map'), mapOptions); //make map
			
			var i;
			<% String refs = currentSearch.getName(); %>
			var t = '<%= refs%>';
			var marker = new google.maps.Marker({
				position: pos,
				map: map,
				title: t,
			});
			
			if (navigator.geolocation) { //puts marker at current position
	          navigator.geolocation.getCurrentPosition(function(position) {
	            var pos = {
	              lat: position.coords.latitude,
	              lng: position.coords.longitude
	            };

	            var marker = new google.maps.Marker({
					position: pos,
					map: map,
					title: "Your Location",
					icon: {
						url: 'http://maps.google.com/mapfiles/ms/icons/arrow.png'
					}
				});
	          }, function() {
	            handleLocationError(true, infoWindow, map.getCenter());
	          });
	        } else {
	          // Browser doesn't support Geolocation
	          handleLocationError(false, infoWindow, map.getCenter());
	        }
		 	function handleLocationError(browserHasGeolocation, infoWindow, pos) {   	
		    }
		}
	</script>

	<head>
		<meta charset="UTF-8">
		<title>Study Spot</title>
		<link rel="stylesheet" type="text/css" href="details.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body background="background.jpg">
		<div id="myModal" class="modal">
		  <!-- Modal content -->
		  <div class="modal-content">
		    <span class="close" onclick ="close1()">&times;</span>
		    <p>Submit a review</p>
		    <form id = "rev"method="GET" action = "review">
			    <textarea id = "reviewT" name = "reviewT" type = "text" style="height: 250px;" value = ""></textarea>
			    <input type = "submit">
			    <input id = "ratingT" name = "ratingT" type = "text" style = "display: none" value = <%=currentSearch.getRating()%>>
			    <input id = "spaceID" name = "spaceID" type = "text" style = "display: none"value = <%=currentSearch.getLocationID() %>>
			    Rating
			    <select id = "rating" name = "rating">
				  <option value="1">1</option>
				  <option value="2">2</option>
				  <option value="3">3</option>
				  <option value="4">4</option>
				  <option value="5">5</option>
				</select>
		    </form>
		  </div>
		</div>
		<!-- Persistent top bar -->
		<div id = "header">
			<a href="index.jsp" id = "logo">
				Sctudy
			</a>
			<div id="out">
				<div class ="upper" id = "login">
					<a href="login.jsp" id = "login" >
						Login
					</a>
				</div>
				<div class ="upper"id = "register">
					<a href="register.jsp" id = "register" >
						Register
					</a>
				</div>
			</div>
			<div id="in">
				<div class ="upper" id = "profile">
					<a href="profile" id = "login" >
						Profile
					</a>
				</div>
				<div class ="upper" id = "logout">
					<a href="login?loggedout=true" id = "register">
						Log Out
					</a>
				</div>
			</div>
			<script>
				var logged = <%= logged%>;
				if(logged == null) {
					$("#in").hide();
					$("#out").show();
				}	
				else if(logged) {
					$("#out").hide();
					$("#in").show();
				}
				else if(!logged) {
					$("#in").hide();
					$("#out").show();
				}
			</script>
		<!-- Details -->
		<div class="locationImage"><img src=<%= currentSearch.getPhotoURL() %> alt="Study Space Image"></div>
		<div class="name">
			<div class="n">Name</div>
				<div class="b" id="b">
					<button id="favorite" onclick="favorite()" style="font-size: 20px; background-color: rgb(140, 140, 140, .6); border-radius: 10px;"><%=favorite %></button>
					<button id="review" onclick="show()" style="font-size: 20px; background-color: rgb(140, 140, 140, .6); border-radius: 10px;">Write a Review</button>
				</div>
				<script>
					if(logged == null) 
						$("#b").hide();
					else if(logged) 
						$("#b").show();
					else if(!logged) 
						$("#b").hide();
				</script>
		</div>
		<div class="overallRatings">
			<table class="ratingTable">
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
		<div id="resultscontainer">
			<div id="mapcontainer">
		  		<div id="map"></div>
			</div>
		</div>
		<script>
			initialize();
		</script>
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
