<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
	<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<title><c:out value="${event.name }" /></title>
</head>
<body>
<header>
  <a href="/dashboard">Dashboard</a>
</header>

<section id="hero1" class="hero">
  <div class="inner">
    <div class="copy fontWhite">
    <h1 style="font-size: 5em">	<strong><c:out value="${event.name }" /></strong></h1><br>
   <h2>Host:<c:out value="${event.host }" /></h2>
   <h2>Date:<fmt:formatDate pattern="MMMM dd, yyyy" value="${event.eventdate}" /></h2>
	<h3>Location:<c:out value="${event.location }" />, <c:out value="${event.state }" /></h3>
	
    </div>
  </div>
</section>

<section class="content">
<div class="outer">
    <div class="attendence">
    <h3>People who are attending this event:<c:out value="${event.users.size() }" /></h3>
    <table>
		<thead>
			<tr>
				<th>Name:</th>
				<th>Location:</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${ event.users }">
				<tr>
					<td><c:out value="${user.firstName }" /></td>
					<td><c:out value="${user.location }" /></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
    </div>


     <div class="messages">
		<h2>Message Board</h2>
		<c:forEach var="comment" items="${ event.comments }">
			<p>
				<c:out value="${ comment.name }" />
				:
				<c:out value="${ comment.comment }" />
				
			</p>
			<p>___________________________</p>
		</c:forEach>
	</div>
	<div class="commentBox">

		<h4>Add Comment:</h4>
		<form:form action="/addComment" method="POST" modelAttribute="comment_">
			<form:input type="hidden" path="event" value="${event.id}" />
			<form:hidden path="name" value="${username}"></form:hidden>

   			<form:errors path="comment" />
			<form:textarea class="form-control" type="text" path="comment" /><br>
			
				<div class="form-row">
			<input type="submit" class="btn btn-primary btn-lg"  value="Submit!">
			</div>
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