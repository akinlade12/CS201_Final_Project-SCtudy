<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Boolean logged = (Boolean) session.getAttribute("loggedIn");%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Submit</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="submit.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
	<div class="submit">
			<div class = "submit-div">
				<form class="submitForm" action="submit" method="POST">
	  				 <input id="submitField" class="submitField" name="submitField" type="text" placeholder="Study Spot Name" aria-label="Submit" required><br><br>
	  				 <input id="latitude" type="text" placeholder="Latitude" name="latitude" required>
	  				 <input id="longitude" type="text" placeholder="Longitude" name="longitude" required><br><br>
	  				 <input id="photoURL" type="text" placeholder="Link to Photo" name="photoURL" required><br><br>
	  				 <input id="address" type="text" placeholder="Address" name="address" required><br><br>
	  				 <input id="buildingCode" type="text" placeholder="Building Code" name="buildingCode" required><br><br>
	  				 <input id="phoneNumber" type="text" placeholder="Phone Number" name="phoneNumber" required><br><br>
	  				 <input type="hidden" id="outletsForm" name="outletsForm" value="" required>
	  				 <input type="hidden" id="seatsForm" name="seatsForm" value="" required>
	  				 <input type="hidden" id="lightsForm" name="lightsForm" value="" required>
	  				 <input type="hidden" id="noiseForm" name="noiseForm" value="">
	  				 <input type="hidden" id="inOrOutForm" name="inOrOutForm" value="" required>
	  				 <input type="hidden" id="cafeForm" name="cafeForm" value="" required>
	  				 <input type="hidden" id="hourOpenForm" name="hourOpenForm" value="" required>
	  				 <input type="hidden" id="hourCloseForm" name="hourCloseForm" value="" required>
	  				 
	  				 
	 				<button class="btn btn-danger" onclick="submitForm()" id="submitButton">Submit</button>
					
					<div class = "params">
						<div style = " float:left;" id = "1">
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
						
						<div  style=" float:left; margin-left: 40px;">
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
		
						<div style = " float:left; margin-right: 40px; margin-left: 40px;" id = "1">
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
						</div >
					<div  style=" float:left;">
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
					<div style = " float:left; margin-right: 40px;" id = "1" >
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
					<div style=" float:left;">
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
					<div style = " float:left; margin-right: 40px; margin-left: 40px;" id = "1" >
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
					<div style=" float:left;">
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
					</div >
				</div>
			</form>
		</div>				
	</div>
	
</body>
<script>
	document.getElementById("submitButton").addEventListener("click", function submitValues() {
		var form = document.getElementById("submitForm");
		
		document.getElementById("outletsForm").value = document.getElementById("outletAvailability").value;
		document.getElementById("seatsForm").value = document.getElementById("seatingTypes").value;
		document.getElementById("lightsForm").value = document.getElementById("lightingTypes").value;
		document.getElementById("noiseForm").value = document.getElementById("noiseLevel").value;
		document.getElementById("inOrOutForm").value = document.getElementById("indoorOutdoor").value;
		document.getElementById("cafeForm").value = document.getElementById("cafeAvailability").value;
		document.getElementById("hourOpenForm").value = document.getElementById("hourOpen").value;
		document.getElementById("hourCloseForm").value = document.getElementById("hourClose").value;
		
		console.log("YOU HAVE REACHED HERE ! ");
		
		form.submit(); 		
	});
</script>
</html>
