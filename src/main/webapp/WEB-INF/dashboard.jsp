<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/style1.css"> 
	<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
	
<title>Events Dashboard</title>
</head>
<body>

<header>

<form id="logoutForm" method="POST" action="/logout">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
<input type="submit" value="Logout!" />
</form>

</header>

<section id="hero1" class="hero">
  <div class="inner">
    <div class="copy">
		
		<h1>Welcome, <c:out value="${currentUser}"></c:out>!</h1><br><br>
		<h4 style="color: white">Find events all over the Nation or in your current location.</h4>
		<h4 style="color: white">Create your own event and add it to our current list for users to see and join.</h4>
    </div>
  </div>
</section>

<section class="content">
<div class="title">
	<h3>Here are some of the events in your state:</h3>
</div>
  <div class="inner">
    <div class="copy">
	
		<table>
		 <thead>
			<tr>
				<th>Event ID</th>
				<th>Name</th>
				<th>Date</th>
				<th>Location</th>
				<th>Host</th>
				<th>Action/Status</th>
			</tr>
			 </thead>
 <tbody class="tab">
			<c:forEach var="event" items="${ yourStateEvents }">
				<tr>
					<td><c:out value="${event.id }" /></td>
					<td><a href="/events/${ event.id }"><c:out
								value="${event.name }" /></a></td>
					<td><fmt:formatDate pattern="MMMM dd, yyyy"
							value="${event.eventdate}" /></td>
					<td><c:out value="${event.location }" /></td>
					<td><c:out value="${event.host }" /></td>
					<td><c:if test="${ event.host == currentUser }">
							<a href="/events/${ event.id }/edit">Edit</a> | 
							<a href="/delete/${ event.id }">Delete </a> |
						</c:if> <c:choose>
							<c:when test="${fn:contains(event.users, cur_user)}">
            					 	Joining <a href="/cancel/${ event.id }">Cancel</a>
							</c:when>
							<c:otherwise>
								<a href="/join/${ event.id }">Join</a>
							</c:otherwise>
						</c:choose></td>
				</tr>
			</c:forEach>
			 </tbody>
		</table>
	
    </div>
  </div>
</section>

<section id="hero2" class="hero">
  <div class="inner">
    <div class="copy">
  
    </div>
  </div>
</section>
  
<section class="content">
 <div class="title"> <h3>Here are some of the events in other state:</h3></div>
  <div class="inner">
    <div class="copy">
  
  <div>	
		<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Date</th>
				<th>Location</th>
				<th>Host</th>
				<th>Action</th>
			</tr>
</thead>
<tbody class="tab">
			<c:forEach var="nonstate" items="${ nonStateEvents }">
				<tr>
					<td><c:out value="${nonstate.id }" /></td>
					<td><a href="/events/${ nonstate.id }"><c:out
								value="${nonstate.name }" /></a></td>
					<td><fmt:formatDate pattern="MMMM dd, yyyy"
							value="${nonstate.eventdate}" /></td>
					<td><c:out value="${nonstate.location }" /></td>
					<td><c:out value="${nonstate.host }" /></td>
					<td><c:choose>
							<c:when test="${fn:contains(nonstate.users, cur_user)}">
            					 	Joining <a href="/cancel/${ nonstate.id }">Cancel</a>
							</c:when>
							<c:otherwise>
								<a href="/join/${ nonstate.id }">Join</a>
							</c:otherwise>
						</c:choose></td>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
    </div>
  </div>

</section>
<section class="addevent">
<!--  <div class="inner">
    <div class="copy"> -->
<div class="create">
		<h2>Create an Event</h2>
		<form:form action="/addEvent" method="POST" modelAttribute="event">

			<form:hidden path="host" value="${currentUser}"></form:hidden>
			
			<div class="form-row">
   		 	<div class="form-group col-md-2">
			<form:label class="labelSize" path="name">Event Name:</form:label>
   			<form:errors path="name" />
			<form:input class="form-control" path="name" />
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
			<form:input class="form-control" path="location" />
			</div>

   		 	<div class="form-group col-md-1">
			<form:label class="labelSize" path="state">State: </form:label>
    			<form:errors path="state" />
			<form:select class="form-control" path="state" var="{i}" items="${ states }">
			<form:options value="${ i }" />
			</form:select>
			</div>
			</div>

			<input type="submit" class="btn btn-primary btn-lg" value="Add Event!">
		</form:form>
	<!-- </div>
	</div> -->
	</div>
</section> 


<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,700' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Noto+Sans' rel='stylesheet' type='text/css'>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
  </body>
</html>