<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
	
<title>Login and Registration</title>
</head>

<body id="indexpage">

<div class="header">
  <div class="info">
  <h1 class="display-3">PLAN AND SIMPLE</h1>    
  </div>
</div>
<section class="content">
  <h1> Plan and Simple brings people together through live experiences. <br> Discover events that match your location, passions, or create your own.</h1>
</section>

<section class="content">

<div class="container-fluid">
	<div>
	<h2 style="color: red">
		<c:if test="${logoutMessage != null}">
			<c:out value="${logoutMessage}"></c:out>
		</c:if>
	</h2>
	</div>
	
	<div class="d-inline">
		<h1>Login</h1>
		<h3><c:if test="${errorMessage != null}">
			<c:out value="${errorMessage}"></c:out>
		</c:if></h3>
	
<form method="POST" action="/login">
  <div class="form-row">
    <div class="col col-md-4">
     <label for="username" class="labelSize">Email:</label> 
	<input type="text" class="form-control" id="username" name="username" />
    </div>
    </div>
     <div class="form-row">
    <div class="col col-md-4">
     <label for="password" class="labelSize">Password:</label> 
	<input type="password" class="form-control" id="password" name="password" />
    </div>
  </div>
  <div class="form-row">
  <div class="col-auto my-3">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="submit" class="btn btn-primary btn-lg" value="Login!" />
	</div>
	</div>
</form>
</div>
 <hr class="my-3">

 <button type="button" id="regbtn" class="btn btn-success btn-lg">Click to Register!</button>
 
 <script>
	$( "#regbtn" ).click(function() {
		  $( ".reg" ).toggle( "slow", function() {

		  });
		});
	
	</script>
	
	<div class="reg">
	
		<h1>Register</h1>
		<h3 style="color: green">
			<c:out value="${successful}"></c:out>
		</h3>
		<form:form action="/registration" method="POST" modelAttribute="user">

			<div class="form-row">
   		 	<div class="form-group col-md-4">
			<form:label class="labelSize" path="firstName">First Name:</form:label>
			<form:input class="form-control" path="firstName" />
			<form:errors path="firstName" />
			</div>
			</div>
			
			<div class="form-row">
   		 	<div class="form-group col-md-4">
			<form:label class="labelSize" path="lastName">Last Name:</form:label>
			<form:input class="form-control" path="lastName" />
			<form:errors path="lastName" />
			</div>
			</div>
			
			<div class="form-row">
   		 	<div class="form-group col-md-4">
			<form:label class="labelSize" path="email">Email:</form:label>
			<form:input class="form-control" path="email" />
			<form:errors path="email" />
			</div>
			</div>
			
			<div class="form-row">
   		 	<div class="form-group col-md-2">
			<form:label class="labelSize" path="location">Location:</form:label>
			<form:input class="form-control" path="location" />
			<form:errors path="location" />
			</div>
			<div class="form-group col-md-4">
			<form:label class="labelSize" path="state">State: </form:label>
    			<form:errors path="state" />
			<form:select path="state" var="{i}" items="${ states }">
			<form:options value="${ i }" />
			</form:select>
			</div>
			</div>
			
			<div class="form-row">
   		 	<div class="form-group col-md-4">
			<form:label class="labelSize" path="password">Password:</form:label>
			<form:input class="form-control" path="password" />
			<form:errors path="password" />
			</div>
			</div>
			
			<div class="form-row">
   		 	<div class="form-group col-md-4">
			<form:label class="labelSize" path="passwordConfirmation">Password Confirmation:</form:label>
			<form:input class="form-control" path="passwordConfirmation" />
			<form:errors path="passwordConfirmation" />
			</div>
			</div>

			 <div class="form-row">
  			<div class="col-auto my-3">
			<input type="submit" class="btn btn-primary btn-lg" value="Register!" />
			</div>
			</div>
			
		</form:form>
	</div>
</div>
</section>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
  </body>
</html>