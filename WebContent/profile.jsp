<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "main.StudySpace" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Boolean logged = (Boolean) session.getAttribute("loggedIn");%>
<%
/* 	StudySpace space1 = new StudySpace("Space 1", -118.282968, 34.022100, "bovard.jpg", "Sparse", "Couch", "LED", 2,
			true, false, "8:00am", "5:00pm", "(925) 587-3144", "1800 Your Butt St", "WPH 209", 3.65, 5); */
	Vector<StudySpace> spaces = new Vector<StudySpace>();
	// spaces.add(space1);
	spaces = (Vector<StudySpace>) session.getAttribute("favorites");  
	int size;
	if (spaces == null || spaces.size() == 0){
		size = 0;
	}
	else{
		size = spaces.size();
	}
	
	String username = "Username";
	if (session.getAttribute("loggedIn") != null) {
		username = (String) session.getAttribute("username");
	}
	String about = (String) session.getAttribute("about");
	if(about == null)
		about = "";
%>
<html>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="profile.css" />
<meta charset="UTF-8">
<title><%=username %>'s Profile</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body background="background.jpg">
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
					<a href="profile.jsp" id = "login" >
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
		</div>
	<div id="prof">Profile Summary</div>
	<div id="sidebar">
		<div id="piccontainer">
			<img id="profilepic" src="bovard.jpg">
		</div>
		<div id="infocontainer">
			<div id="name"><%=username%></div>
			<div id="location">Los Angeles</div>
			<div id="about">
				About: <%=about %>
			</div>
		</div>
	</div>
	<div id="Favorite">Favorites</div>	
	<div id="resultscontainer">
 		<div id="mapcontainer">
		  <div id="map"></div>
		</div>
		<div id="list">
			<table>
				<tbody id="thatbod">
				<%
					int i;
					for(i = 0; i < size; i++) {
						StudySpace space = spaces.get(i);
						String ref = "DetailsServlet?index=" + Integer.toString(i);
						int rating = (int) Math.round(space.getRating());
						
						String c;
						if(space.getCafe())
							c = "Yes";
						else
							c= "No";
						
						String o;
						if(space.getOutside())
							o = "Outdoors";
						else
							o = "Indoors";
				%>
					<tr>
						<td>
							<div class="picture">
								<img src=<%=space.getPhotoURL() %>>
							</div>
							<a class="title" href=<%=ref %>> <%= space.getName() %> </a>
							<div class="review">
								<%
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
							<div class="address">
								<p><%=space.getPhone() %> </p>
								<p><%=space.getAddress() %></p>
								<p><%=space.getBuilding() %> </p>
							</div>
							<div class="params1">
								<p class="params"> Hour Open: <%=space.getHourOpen() %> </p>
								<p class="params"> Hour Close: <%=space.getHourClose() %> </p>
								<p class="params"> Cafe: <%=c %> </p>
								<p class="params"> In/Out: <%=o %> </p>
							</div>
							<div class="params2">
								<p class="params"> Noise Level: <%=space.getNoise()%> </p>
								<p class="params"> Light Source: <%=space.getLights() %> </p>
								<p class="params"> Seating Type: <%=space.getSeats() %> </p>
								<p class="params"> Outlet Availability: <%=space.getOutlet() %> </p>
							</div>
							
						</td>
					</tr>
				<%
						} 
				%>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		var val = <%= size%>;
		if(val == 0) {
			document.getElementById("Result").innerHTML = "No Results Found.";
			document.getElementById("toggle").style.display = "none";
			document.getElementById("resultscontainer").style.display = "none";
		}
		else {
			document.getElementById("Result").innerHTML = "Results";
		}
	</script>
</body>
</html>
