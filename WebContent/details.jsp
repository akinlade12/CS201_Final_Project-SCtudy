<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="main.StudySpace" %>
<%@ page import="java.util.ArrayList" %>
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
	ArrayList<String> users = (ArrayList<String>) request.getAttribute("usernames");
	ArrayList<Integer> ratings = (ArrayList<Integer>) request.getAttribute("ratings");
	ArrayList<String> reviews = (ArrayList<String>) request.getAttribute("reviews");
	int size;
	if(users == null)
		size = 0;
	else
		size = users.size();
	
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
	 		 modal.style.display = "flex";
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
			var map = new google.maps.Map(document.getElementById('map'), mapOptions);//make map
			
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
		<title><%=currentSearch.getName() %></title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="details.css" />
	</head>
	<body background="background.jpg">
		<!-- Persistent top bar -->
		<div id = "header">
			<a href="index.jsp"  id = "logo">
				Sctudy
			</a>
			<div id="out">
				<div class ="upper" id = "login">
					<a href="login.jsp"  id = "login" >
						Login
					</a>
				</div>
				<div class ="upper"id = "register">
					<a href="register.jsp"  id = "register" >
						Register
					</a>
				</div>
			</div>
			<div id="in">
				<div class ="upper" id = "profile">
					<a href="profile"  id = "login" >
						Profile
					</a>
				</div>
				<div class ="upper" id = "logout">
					<a href="login?loggedout=true"  id = "register">
						Log Out
					</a>
				</div>
			</div>
		</div>
		<div id="myModal" class="modal">
		  <!-- Modal content -->
		  <div class="modal-content" >
		    <span class="close" onclick ="close1()">&times;</span>
		    <p id="stuff" style = "font-size:50px;">Submit a review</p>
		    <form id = "rev">
			    <textarea id="reviewT" name = "reviewT" type = "text" value = ""></textarea>
			    <input id = "ratingT" name = "ratingT" type = "text" style = "display: none" value = <%=currentSearch.getRating()%>>
			    <input id = "spaceID" name = "spaceID" type = "text" style = "display: none"value = <%=currentSearch.getLocationID() %>>
			    <div id="ratingblock">
			    <p id="ratingname">Rating</p>
			    <select id = "rating" name = "rating" style = "width: 3vw" >
				  <option value="1">1</option>
				  <option value="2">2</option>
				  <option value="3">3</option>
				  <option value="4">4</option>
				  <option value="5">5</option>
				</select>
				</div>
				<input id="sub" type = "submit">
		    </form>
		    <script>
		    $("#rev").submit(function(e) {

		        e.preventDefault(); // avoid to execute the actual submit of the form.

		        var form = $(this);

		        $.ajax({
		               type: "POST",
		               url: 'review',
		               data: form.serialize(), // serializes the form's elements.
		               success: function(data) {
		            	   close1();
		               }
		             });
		    	});
		    	
		    </script>
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
			<div class="n"><%= currentSearch.getName() %></div>
			<div class="reviewstars">
				<%
					int rating = (int) Math.round(currentSearch.getRating());
					System.out.println(rating + " " + currentSearch.getRating());
					int j;
					for(j = 0; j < rating; j++) { 
				%>
				<span class="fa fa-star checked"></span>
				<%	}
					while(j < 5) {
				%>
				<span class="fa fa-star"></span>
				<%
						j++;
					}
				%>
				
			</div>
			<div id="lastone">
				<div class="a"><%= currentSearch.getAddress() %></div>
				<div class="a"><%= currentSearch.getPhone() %></div>
				<div class="a"><%= currentSearch.getBuilding() %></div>
			</div>
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
					<th>Overall Rating:</th>
					<th class="value"><%= currentSearch.getRating() %></th>
				</tr>
				<tr>
					<th> Hours:</th>
					<th class="value"><%= currentSearch.getHourOpen() %> to <%= currentSearch.getHourClose() %></th>
				</tr>
				<tr>
					<th> Outlet Availability:</th>
					<th class="value"><%= currentSearch.getOutlet() %></th>
				</tr>
				<tr>
					<th> Seating Type:</th>
					<th class="value"><%= currentSearch.getSeats() %></th>
				</tr>
				<tr>
					<th> Light Source:</th>
					<th class="value"><%= currentSearch.getLights() %></th>
				</tr>
				<tr>
					<th> Noise Level:</th>
					<th class="value"><%= currentSearch.getNoise() %></th>
				</tr>
				<tr>
					<th> Cafe Available:</th>
					<%	String c;
						if (currentSearch.getCafe())
							c = "Yes";
						else
							c = "No";
					%>
					<th class="value"><%= c %></th>
				</tr>
				<tr>
					<th> Indoor/Outdoor:</th>
					<%	String o;
						if (currentSearch.getOutside())
							o = "Outdoors";
						else
							o = "Indoors";
					%>
					<th class="value"><%= o%></th>
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
			<table class = "reviewTable" id="reviewTable">
			<%
				int i;
				for(i = 0; i < size; i++) {
			%>
			<tbody class="revBody">
			
				<tr>
						<td class="poop"><b id="nam"><%=users.get(i)%></b> &nbsp; &nbsp; &nbsp; <b>Rating:</b> <%=ratings.get(i)%>/5</td> 
						<td></td>
				</tr>
				<tr>
					<td class="poop"><b>Review:</b> <%=reviews.get(i) %></td>
				</tr>
			
			</tbody> 
			<%
				}
			%>
			<script>
			function handleData(result) {
				var res = result.split("|");
				res[2] = res[2] + '/5';
				res[2] = res[2].replace(/\s+/g, '');
				$('<tbody class="revBody">').html(
						'<tr>' +
						'<td class="poop"><b id="nam">' + res[1] + '</b> &nbsp; &nbsp; &nbsp; <b>Rating: </b>' + res[2] + '</td>' + 
						'<td></td>' + 
						'</tr>' +
						'<tr>' + 
						'<td class="poop" id="rebs"><b>Review: </b>' + res[0] +  '</td>' +
						'</tr>'
				).appendTo('#reviewTable')
				
				test();
				
				
				
				
				
				//document.write('<tbody class="revBody">');
				//document.write('<tr>');
				//document.write('<td class="poop"><b id="namesy"></b> &nbsp; &nbsp; &nbsp; <b>Rating:</b> <ins id="insert"></ins></td>');
				//document.write('<td></td>');
				//document.write('</tr>');
				//document.write('<tr>');
				//document.write('<td class="poop" id="rebs"><b>Review:</b> </td>');
				//document.write('</tr>');
				//document.write('</tbody>');
				//document.getElementById("namesy").innerHTML = res[0];
				//document.getElementById("insert").innerHTML = res[1];
				//document.getElementById("rebs").innerHTML = res[2];
			}
			function test() {
				$.ajax({
					url: "hack",
					data: {
						action: "test"
					},
					success: function(result) {
						if(result != null && result != "") {
							handleData(result);
						}
					}
				});
				
			}
			</script>
			</table>
		</div>
		<script>
		window.onload=test;
		window.onbeforeunload=logout;
		function logout(){
			$.ajax({
				url: "hack",
				data: {
					action: "leaving"
				},
				async: true,
				success: function(result) {	
				}
			});
			return null;
		}
		</script>
	</body>
</html>

