<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Boolean logged = (Boolean) session.getAttribute("loggedIn");%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Sctudy</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="index.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body background="background.jpg">
		<script>
			
		</script>
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
					<a href="profile" id = "profile" >
						Profile
					</a>
				</div>
				<div class ="upper" id = "logout">
					<a href="login?loggedout=true" id = "logout">
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
				} s
			</script>
		</div>
		<div id="motto">Find your space...</div>
		<div id="container"></div>
		<div id = "search-div">
			<form class="submitForm" action="Index" method="POST">
	  			<input id="submitField" class="submitField" name="submitField" type="text" placeholder="Study Spot Name" aria-label="Submit"><br><br>
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
 				
 				<button class="btn btn-danger" id="submitButton" onclick="submitValues()">Search</button>
			</form>
		</div>
		<div id="info">
			*Check boxes of your required parameters
		</div>
		
		<div id = "params">
			<div style = " float:left; margin-right: 40px;" id = "1">
				<div class="input-group mb-3">
					<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "outlets">
					</div>
	  				<div class="input-group-prepend" >
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Outlet Availability</label>
	  				</div>
	 				<select class="custom-select" id="outletAvailability" style="width: 6vw; height: 4vh;">
	   					<option selected>Choose...</option>
	   					<option value="Sparse">Sparse</option>
	    			 	<option value="Available">Available</option>
	    				<option value="Abundant">Abundant</option>
	  				</select>
				</div>
			</div >
			<div  style=" float:left;">
				<div  class="input-group mb-3">
				<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "seats">
					</div>
	  				<div class="input-group-prepend">
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Seating Types</label>
	  				</div>
	 				<select class="custom-select" id="seatingTypes" style="width: 6vw; height: 4vh;">
	   					<option selected>Choose...</option>
	   					<option value="Couch">Couch</option>
	    			 	<option value="Chair">Chair</option>
	    				<option value="Table">Table</option>
	  				</select>
				</div>
			</div>
		</div>
		<div id = "params2">
			<div style = " float:left; margin-right: 40px;" id = "1">
				<div class="input-group mb-3">
					<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "lights">
					</div>
	  				<div class="input-group-prepend" >
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Light Source</label>
	  				</div>
	 				<select class="custom-select" id="lightingTypes" style="width: 6vw; height: 4vh;">
	   					<option selected>Choose...</option>
	   					<option value="LED">LED</option>
	    			 	<option value="Windows">Windows</option>
	    				<option value="Combo">Combo</option>
	  				</select>
				</div>
			</div >
			<div  style=" float:left;">
				<div  class="input-group mb-3">
					<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "noise">
					</div>
	  				<div class="input-group-prepend">
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Noise Scale</label>
	  				</div>
	 				<select class="custom-select" id="noiseLevel" style="width: 6vw; height: 4vh;">
	   					<option selected>Choose...</option>
	   					<option value="1">1</option>
	    			 	<option value="2">2</option>
	    				<option value="3">3</option>
	    				<option value="4">4</option>
	    				<option value="5">5</option>
	  				</select>
				</div>
			</div>
		</div>
		<div id = "params3">
			<div style = " float:left; margin-right: 40px;" id = "1" >
				<div  class="input-group mb-3">
					<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "inOrOut">
					</div>
	  				<div class="input-group-prepend">
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Indoor/Outdoor</label>
	  				</div>
	 				<select class="custom-select" id="indoorOutdoor" style="width: 6vw; height: 4vh;">
	   					<option selected>Choose...</option>
	   					<option value="Indoor">Indoor</option>
	    			 	<option value="Outdoor">Outdoor</option>
	  				</select>
				</div>
			</div>
			<div style=" float:left;">
				<div class="input-group mb-3">
					<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "cafe">
					</div>
	  				<div class="input-group-prepend" >
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Cafe Availability</label>
	  				</div>
	 				<select class="custom-select" id="cafeAvailability" style="width: 6vw; height: 4vh;">
	   					<option selected>Choose...</option>
	   					<option value="Yes">Yes</option>
	    			 	<option value="No">No</option>
	  				</select>
				</div>
			</div >
		</div>
		<div id = "params4">
			<div style = " float:left; margin-right: 40px;" id = "1" >
				<div  class="input-group mb-3">
					<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "hoursOpen">
					</div>
	  				<div class="input-group-prepend">
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Hours(Open)</label>
	  				</div>
	 				<select class="custom-select" id="hourOpen" style="width: 6vw; height: 4vh;">
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
					<div style = " margin-right: 10px; margin-top:5px">
						<input type="checkbox" id = "hoursClose">
					</div>
	  				<div class="input-group-prepend" >
	   					 <label class="input-group-text" for="inputGroupSelect01" style="width: 8vw; height: 4vh;">Hours(Close)</label>
	  				</div>
	 				<select class="custom-select" id="hourClose" style="width: 6vw; height: 4vh;">
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
</html>
