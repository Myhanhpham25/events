<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Date"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="/css/style1.css">
<title>Edit Events</title>
</head>
<body>

<header>
  <a href="/dashboard">Dashboard</a>
</header>

<section id="hero1" class="hero">
  <div class="inner">
    <div class="copy">
    <h1 style="font-size: 5em">	<strong><c:out value="${oldEvent.name}" /></strong></h1><br>
    </div>
  </div>
</section>

<section class="content">
  <div class="inner">
    <div class="copy">
 
		<h2>Edit Event</h2>  
		<div id="editForm">
		<form:form action="/events/${oldEvent.id}/edit" method="POST" modelAttribute="event">
			<form:hidden path="id" value="${oldEvent.id}"></form:hidden>
			<form:hidden path="host" value="${oldEvent.host}"></form:hidden>

			<div class="form-row">
   		 	<div class="form-group col-md-2">
			<form:label class="labelSize" path="name">Event Name:</form:label>
   			<form:errors path="name" />
			<form:input class="form-control" path="name" value="${oldEvent.name}" />
			</div>
			</div>
			
			<div class="form-row">
   		 	<div class="form-group col-md-2">
			<form:label class="labelSize" path="eventdate">Date:</form:label>
   			<form:errors path="eventdate" />
			<form:input class="form-control" type="date" path="eventdate" />	
			</div>
			</div>
			
			<div class="form-row">
   		 	<div class="form-group col-md-1">
			<form:label class="labelSize" path="location">Location:</form:label>
   			<form:errors path="location" />
			<form:input class="form-control" path="location" value="${oldEvent.location}" />
			</div>

   		 	<div class="form-group col-md-1">
			<form:label class="labelSize" path="state">State: </form:label>
    			<form:errors path="state" />
			<form:select class="form-control" path="state" var="{i}" items="${ states }">
			<form:options value="${ i }" />
			</form:select>
			</div>
			</div>

			<input type="submit" id="btnMove" class="btn-primary btn-lg" value="Update Event!">
			</form:form>	
			</div>
	</div>
    </div>
</section>

<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,700' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Noto+Sans' rel='stylesheet' type='text/css'>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
  </body>
</html>