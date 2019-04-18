<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "main.StudySpace" %>
<!DOCTYPE html>
<%
	Boolean logged = (Boolean) session.getAttribute("loggedIn");
	StudySpace space1 = new StudySpace("Space 1", 0, 0, "bovard.jpg", "Sparse", "Couch", "LED", 2,
		true, false, "8:00am", "5:00pm", "(925) 587-3144", "1800 Your Butt St", "WPH 209", 3.65, 6);
	//ArrayList<StudySpace> spaces = new ArrayList<StudySpace>();
	//spaces.add(space1);
	Vector<StudySpace> spaces = (Vector<StudySpace>) session.getAttribute("studySpaces");  
	int size;
	if(spaces == null || spaces.size() == 0){
		size = 0;
		Vector<StudySpace> spaces2 = new Vector<StudySpace>(); //just to deal with nullpointerexceptions
		spaces2.add(space1);
		spaces = spaces2;
	}
	else{
		size = spaces.size();
	}
	ArrayList<Double> latArray = new ArrayList<Double>();
	ArrayList<Double> longArray = new ArrayList<Double>();
	ArrayList<String> refArray = new ArrayList<String>();
	for(int i = 0; i < size; i++) {
		latArray.add(spaces.get(i).getLatitude());
		longArray.add(spaces.get(i).getLongitude());
		refArray.add(spaces.get(i).getName());
	}
%>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Results</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD3d8Oblehwi3ISiykxRtGtqD0btZkWjIs"></script>
	<script>
		var size = Number(<%=size%>);
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
			var j;
			if(size > 0) {
				var latArray = [<% for (int i = 0; i < latArray.size(); i++) { %><%= latArray.get(i) %> <%= i + 1 < latArray.size() ? ",":"" %><% } %>];
				var longArray = [<% for (int i = 0; i < longArray.size(); i++) { %><%= longArray.get(i) %><%= i + 1 < longArray.size() ? ",":"" %><% } %>];
				var refArray = [<% for (int i = 0; i < refArray.size(); i++) { %>"<%= refArray.get(i) %>"<%= i + 1 < refArray.size() ? ",":"" %><% } %>];
				var i;
				for(i = 0; i < size; i++) { 
					var latitude = latArray[i];
					var longitude = longArray[i];
					var pos = {lat: latitude, lng: longitude};	
					var t = refArray[i];
					var marker = new google.maps.Marker({
						position: pos,
						map: map,
						title: t,
						label: labels[labelIndex++ % labels.length],
					});
					markerArray.push(marker);
					var contentString = '<a href="hack?index=' + i + '">' + t + '</a>';
					var infowindow = new google.maps.InfoWindow({
						content: contentString
					});
					
					infoArray.push(infowindow);
			
				}
				if (navigator.geolocation) { //puts marker at current position
		          navigator.geolocation.getCurrentPosition(function(position) {
		            var pos = {
		             // lat: position.coords.latitude,
		              //lng: position.coords.longitude
		              lat: 34.021550,
		              lng: -118.283847
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
					 
				function makeListener(index) {
				    return function() {
				        infoArray[index].disableAutoPan=true;
				        infoArray[index].open(map,markerArray[index]);
				    }
				}
				
				for (var u=0; u<size; u++){ 
				    google.maps.event.addListener(markerArray[u], 'click', makeListener(u));
				}
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
		<form action="Index" method="POST" id="searchbar" class="form-inline mr-auto">
			<input type="hidden" id="outletsForm" name="outletsForm" value="">
			<input type="hidden" id="seatsForm" name="seatsForm" value="">
			<input type="hidden" id="lightsForm" name="lightsForm" value="">
			<input type="hidden" id="noiseForm" name="noiseForm" value="">
			<input type="hidden" id="inOrOutForm" name="inOrOutForm" value="">
			<input type="hidden" id="cafeForm" name="cafeForm" value="">
			<input type="hidden" id="hourOpenForm" name="hourOpenForm" value="">
			<input type="hidden" id="hourCloseForm" name="hourCloseForm" value="">
			
			<input type="hidden" id="outletsBoxForm" name="outletsBoxForm" value="">
			<input type="hidden" id="seatsBoxForm" name="seatsBoxForm" value="">
			<input type="hidden" id="lightsBoxForm" name="lightsBoxForm" value="">
			<input type="hidden" id="noiseBoxForm" name="noiseBoxForm" value="">
			<input type="hidden" id="inOrOutBoxForm" name="inOrOutBoxForm" value="">
			<input type="hidden" id="cafeBoxForm" name="cafeBoxForm" value="">
			<input type="hidden" id="hoursOpenBoxForm" name="hoursOpenBoxForm" value="">
			<input type="hidden" id="hoursCloseBoxForm" name="hoursCloseBoxForm" value="">
			<input class="form-control mr-sm-2" id="submitField" name="submitField"type="text" placeholder="Leavey Library" aria-label="Search">
			<button class="btn btn-danger" id="submitButton" onclick="submitValues()">Search</button>
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
		 				<select class="custom-select" id="outletAvailability">
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
		 				<select class="custom-select" id="seatingTypes">
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
						<select class="custom-select" id="lightingTypes">
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
						<select class="custom-select" id="noiseLevel">
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
						<select class="custom-select" id="indoorOutdoor">
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
							<select class="custom-select" id="cafeAvailability">
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
							<select class="custom-select" id="hourOpen">
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
							<select class="custom-select" id="hourClose">
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
				<input type="checkbox" id="outlets" name="outlet">
				<input type="checkbox" id="seats" name="seating">
				<input type="checkbox" id="lights" name="light">
				<input type="checkbox" id="noise" name="noise">
				<input type="checkbox" id="inOrOut" name="indoor">
				<input type="checkbox" id="cafe" name="cafe">
				<input type="checkbox" id="hoursOpen" name="open">
				<input type="checkbox" id="hoursClose" name="close">
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
						String ref = "hack?index=" + Integer.toString(i);
						int rating = (int) Math.round(space.getRating());
						System.out.println(space.getName() + " " + rating);
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
								<div><%=space.getPhone() %> </div>
								<div><%=space.getAddress() %></div>
								<div><%=space.getBuilding() %> </div>
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
	<script>
		document.getElementById("submitButton").addEventListener("click", function submitValues() {
			var form = document.getElementById("searchbar");
			
			document.getElementById("outletsForm").value = document.getElementById("outletAvailability").value;
			document.getElementById("seatsForm").value = document.getElementById("seatingTypes").value;
			document.getElementById("lightsForm").value = document.getElementById("lightingTypes").value;
			document.getElementById("noiseForm").value = document.getElementById("noiseLevel").value;
			document.getElementById("inOrOutForm").value = document.getElementById("indoorOutdoor").value;
			document.getElementById("cafeForm").value = document.getElementById("cafeAvailability").value;
			document.getElementById("hourOpenForm").value = document.getElementById("hourOpen").value;
			document.getElementById("hourCloseForm").value = document.getElementById("hourClose").value;
			
			document.getElementById("outletsBoxForm").value = document.getElementById("outlets").checked;
			document.getElementById("seatsBoxForm").value = document.getElementById("seats").checked;
			document.getElementById("lightsBoxForm").value = document.getElementById("lights").checked;
			document.getElementById("noiseBoxForm").value = document.getElementById("noise").checked;
			document.getElementById("inOrOutBoxForm").value = document.getElementById("inOrOut").checked;
			document.getElementById("cafeBoxForm").value = document.getElementById("cafe").checked;
			document.getElementById("hoursOpenBoxForm").value = document.getElementById("hoursOpen").checked;
			document.getElementById("hoursCloseBoxForm").value = document.getElementById("hoursClose").checked;
			
			console.log("YOU HAVE REACHED HERE ! ");
			
			form.submit(); 		
		});
	</script>
</body>
</html>