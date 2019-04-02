<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>SCtudy</title>
		<link rel="stylesheet" type="text/css" href="index.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body background="background.jpg">
		<div id = "header">
			<a href="login.jsp" id = "logo" style = "color: black; float: left; font-family: Courier; font-size: 30px;">
				Sctudy
			</a>
			<a href="login.jsp" id = "login" style = "color: black; float: right; margin-right: 1%; margin-top: 1%;">
				Login
			</a>
			<a href="register.jsp" id = "register" style = "color: black; margin-right: 1%;  margin-top: 1%; float: right;">
				Register
			</a>
		</div>
		<div class="search">
			<div class = "search-div">
				<form class="form-inline mr-auto">
	  				<input class="form-control mr-sm-2" type="text" placeholder="Leavey Library" aria-label="Search">
	 				 <button class="btn btn-danger" type="submit">Search</button>
				</form>
			</div>
			<div class = "params">
				<div style = " float:left;" id = "1">
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
				
				<div  style=" float:left; margin-left: 40px;">
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

				<div style = " float:left; margin-right: 40px; margin-left: 40px;" id = "1">
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
				</div >
			<div  style=" float:left;">
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
						<div style = " float:left; margin-right: 40px;" id = "1" >
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
			<div style=" float:left;">
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
			<div style = " float:left; margin-right: 40px; margin-left: 40px;" id = "1" >
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
			<div style=" float:left;">
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
			</div >

				
			</div>
		</div>

		
	</body>
</html>