<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="index.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
	<body>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<div id = "search-div">
			<form class="form-inline mr-auto">
  				<input class="form-control mr-sm-2" type="text" placeholder="Leavey Library" aria-label="Search">
 				 <button class="btn btn-danger" type="submit">Search</button>
			</form>
		</div>
		<div id = "params">
			<div style = " float:left; margin-right: 40px;" id = "1">
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
			</div >
			<div  style=" float:left;">
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
		</div>
		<div id = "params2">
			<div style = " float:left; margin-right: 40px;" id = "1">
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
		</div>
		<div id = "params3">
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
		</div>
		
	</body>
</html>