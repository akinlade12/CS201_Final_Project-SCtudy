<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "main.StudySpace" %>
<!DOCTYPE html>
<%
	StudySpace space1 = new StudySpace("Space 1", -118.282968, 34.022100, "bovard.jpg", "Sparse", "Couch", "LED", 2,
			true, false, "8:00am", "5:00pm", "(925) 587-3144", "1800 Your Butt St", "WPH 209", 3.65, 5);
	ArrayList<StudySpace> spaces = new ArrayList<StudySpace>();
	spaces.add(space1);
	//ArrayList<StudySpace> spaces = (ArrayList<StudySpace>) session.getAttribute("results");  to be added once Toyosi's got search working
	int size;
	if(spaces == null || spaces.size() == 0){
		size = 0;
	}
	else{
		size = spaces.size();
	}
%>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Results</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD3d8Oblehwi3ISiykxRtGtqD0btZkWjIs"></script>
	<script>
		function initialize() {
			var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
			var labelIndex = 0;
			var mapOptions = {
					center: {lat: 34.023, lng: -118.286},
					zoom: 16
			};
			var map = new google.maps.Map(document.getElementById('map'), mapOptions); //make map
			var markerArray = [];
			var infoArray = [];
			var size = <%=size %>;
			var i;
			<% int k = 0; %>
			for(i = 0; i < size; i++) { //will change based on search results
				var latitude = <%= spaces.get(k).getLatitude()%>;
				var longitude = <%= spaces.get(k).getLongitude()%>;
				var pos = {lat: latitude, lng: longitude};
				<% String refs = spaces.get(k).getName(); %>
				var t = '<%= refs%>';
				var marker = new google.maps.Marker({
					position: pos,
					map: map,
					title: t,
					label: labels[labelIndex++ % labels.length],
				});
				markerArray.push(marker);
				var contentString = '<a href="DetailsServlet?index=' + <%= k%> + '">' + t + '</a>';
				var infowindow = new google.maps.InfoWindow({
					content: contentString
				});
				
				infoArray.push(infowindow);
				
				<% k++; %>
			}
			
			function makeListener(index) {
			    return function() {
			        infoArray[index].disableAutoPan=true;
			        infoArray[index].open(map,markerArray[index]);
			    }
			}
			
			for (var u=0; u<size; u++){ 
			    google.maps.event.addListener(markerArray[u], 'click', makeListener(u));
			}
			document.getElementById("mapcontainer").style.background = 'flex';
		}
	</script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="results.css" />
</head>
<body background="background.jpg">
	<div id = "header">
		<a href="login.jsp" id = "logo">
			Sctudy
		</a>
		<a href="login.jsp" id = "login">
			Login
		</a>
		<a href="register.jsp" id = "register">
			Register
		</a>
	</div>
	<div id="Result">
	</div>
	<div id="toggle">
		<label for="listbutton" class="buttonfont">
	  	   <input class="with-gap" type="radio" name="searchType" id="listbutton" onclick="switchSearch()">List View
	  	</label>
	    <label for="mapbutton" class="buttonfont">
	  	   <input class="with-gap" type="radio" name="searchType" id="mapbutton" onclick="switchSearch()">Map View
	  	</label>
	</div>
	<div id="sidebar">
		Search
		<form id="searchbar" class="form-inline mr-auto">
			<input class="form-control mr-sm-2" type="text" placeholder="Leavey Library" aria-label="Search">
			<button class="btn btn-danger" type="submit">Search</button>
		</form>
		<div id="rqd">
		Required
		</div>
		<div id="params">
			<div id="filters">
				<div>
					<div class="input-group mb-3">
		  				<div class="input-group-prepend" >
		   					 <label class="input-group-text" for="inputGroupSelect01">Outlet Availability</label>
		  				</div>
		 				<select class="custom-select" id="inputGroupSelect01">
		   					<option selected>Choose...</option>
		   					<option value="Sparse">Sparse</option>
		    			 	<option value="Available">Available</option>
		    				<option value="Abundant">Abundant</option>
		  				</select>
					</div>
				</div>
				
				<div>
					<div  class="input-group mb-3">
		  				<div class="input-group-prepend">
		   					 <label class="input-group-text" for="inputGroupSelect01">Seating Types</label>
		  				</div>
		 				<select class="custom-select" id="inputGroupSelect01">
		   					<option selected>Choose...</option>
		   					<option value="Couch">Couch</option>
		    			 	<option value="Chair">Chair</option>
		    				<option value="Table">Table</option>
		  				</select>
					</div>
				</div>
		
				<div>
					<div class="input-group mb-3">
						<div class="input-group-prepend" >
						 		<label class="input-group-text" for="inputGroupSelect01">Light Source</label>
						</div>
						<select class="custom-select" id="inputGroupSelect01">
		 					<option selected>Choose...</option>
		 					<option value="LED">LED</option>
		  			 		<option value="Windows">Windows</option>
		  					<option value="Combo">Combo</option>
						</select>
					</div>
				</div>
				<div>
					<div  class="input-group mb-3">
						<div class="input-group-prepend">
							 <label class="input-group-text" for="inputGroupSelect01">Noise Scale</label>
						</div>
						<select class="custom-select" id="inputGroupSelect01">
		  					<option selected>Choose...</option>
		  					<option value="1">1</option>
		   			 		<option value="2">2</option>
		   					<option value="3">3</option>
		   					<option value="4">4</option>
		   					<option value="5">5</option>
		 				</select>
					</div>
				</div>
				<div>
					<div  class="input-group mb-3">
		 				<div class="input-group-prepend">
		  					 <label class="input-group-text" for="inputGroupSelect01">Indoor/Outdoor</label>
		 				</div>
						<select class="custom-select" id="inputGroupSelect01">
		  					<option selected>Choose...</option>
		  					<option value="Indoor">Indoor</option>
		   			 	<option value="Outdoor">Outdoor</option>
		 				</select>
					</div>
				</div>
				<div>
					<div class="input-group mb-3">
			 				<div class="input-group-prepend" >
			  					 <label class="input-group-text" for="inputGroupSelect01">Cafe Availability</label>
			 				</div>
							<select class="custom-select" id="inputGroupSelect01">
			  					<option selected>Choose...</option>
			  					<option value="Yes">Yes</option>
			   			 	<option value="No">No</option>
			 				</select>
					</div>
				</div >
				<div >
					<div  class="input-group mb-3">
			 				<div class="input-group-prepend">
			  					 <label class="input-group-text" for="inputGroupSelect01">Hours(Open)</label>
			 				</div>
							<select class="custom-select" id="inputGroupSelect01">
			  					<option selected>Choose...</option>
			  					<option value="12am">12am</option>
			   			 	<option value="1am">1am</option>
			   			 	<option value="2am">2am</option>
			   			 	<option value="2am">3am</option>
			   			 	<option value="4am">4am</option>
			   			 	<option value="5am">5am</option>
			   			 	<option value="6am">6am</option>
			   			 	<option value="7am">7am</option>
			   			 	<option value="8am">8am</option>
			   			 	<option value="9am">9am</option>
			   			 	<option value="10am">10am</option>
			   			 	<option value="11am">11am</option>
			   			 	<option value="12am">12pm</option>
			   			 	<option value="1am">1pm</option>
			   			 	<option value="2am">2pm</option>
			   			 	<option value="2am">3pm</option>
			   			 	<option value="4am">4pm</option>
			   			 	<option value="5am">5pm</option>
			   			 	<option value="6am">6pm</option>
			   			 	<option value="7am">7pm</option>
			   			 	<option value="8am">8pm</option>
			   			 	<option value="9am">9pm</option>
			   			 	<option value="10am">10pm</option>
			   			 	<option value="11am">11pm</option>
			 				</select>
					</div>
				</div>
				<div >
					<div class="input-group mb-3">
			 				<div class="input-group-prepend" >
			  					 <label class="input-group-text" for="inputGroupSelect01">Hours(Close)</label>
			 				</div>
							<select class="custom-select" id="inputGroupSelect01">
			  					<option selected>Choose...</option>
			  					<option value="12am">12am</option>
			   			 	<option value="1am">1am</option>
			   			 	<option value="2am">2am</option>
			   			 	<option value="2am">3am</option>
			   			 	<option value="4am">4am</option>
			   			 	<option value="5am">5am</option>
			   			 	<option value="6am">6am</option>
			   			 	<option value="7am">7am</option>
			   			 	<option value="8am">8am</option>
			   			 	<option value="9am">9am</option>
			   			 	<option value="10am">10am</option>
			   			 	<option value="11am">11am</option>
			   			 	<option value="12am">12pm</option>
			   			 	<option value="1am">1pm</option>
			   			 	<option value="2am">2pm</option>
			   			 	<option value="2am">3pm</option>
			   			 	<option value="4am">4pm</option>
			   			 	<option value="5am">5pm</option>
			   			 	<option value="6am">6pm</option>
			   			 	<option value="7am">7pm</option>
			   			 	<option value="8am">8pm</option>
			   			 	<option value="9am">9pm</option>
			   			 	<option value="10am">10pm</option>
			   			 	<option value="11am">11pm</option>
			 				</select>
					</div>
				</div>
			</div>
			<div id="required">
				<input type="checkbox" name="outlet">
				<input type="checkbox" name="seating">
				<input type="checkbox" name="light">
				<input type="checkbox" name="noise">
				<input type="checkbox" name="indoor">
				<input type="checkbox" name="cafe">
				<input type="checkbox" name="open">
				<input type="checkbox" name="close">
			</div>
		</div>
	</div>
	
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
							<% String ch = String.valueOf(Character.toChars(65+i));%>
							<div id="circlecontainer">
								<div class="circle">
									<%=ch %>
								</div>
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
	<script>
	  	var list = document.getElementById("listbutton");
	  	var map = document.getElementById("mapbutton");
	  	var listdiv = document.getElementById("list");
	  	var mapdiv = document.getElementById("mapcontainer");
	  	if (!list.checked && !map.checked) 
	  		list.checked = true;
	  	if(list.checked) {
	  		listdiv.style.visibility = null;
	  		mapdiv.style.display = "none";
	  	}
	  	else {
	  		listdiv.style.display = "none";
	  		mapdiv.style.display=null;
	  	}
	  	
	  	function switchSearch() {
	  		var list = document.getElementById("listbutton");
		  	var map = document.getElementById("mapbutton");
		  	var listdiv = document.getElementById("list");
		  	var mapdiv = document.getElementById("mapcontainer");
		  	if(list.checked) {
		  		listdiv.style.display = null;
		  		mapdiv.style.display = "none";
		  	}
		  	else {
		  		listdiv.style.display = "none";
		  		mapdiv.style.display = null;
		  		initialize();
		  	}
	  	}
	</script>
</body>
</html>