<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="webblog.Subscriber" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

  <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   <title>YK16</title>
 </head>
 
 
  <body background="/images/background1.jpg">
  
<% UserService userService = UserServiceFactory.getUserService();

User user = userService.getCurrentUser();%>
      
<p><h3 align = center><img src="/images/web_banner.jpg" alt="Kanye West">
</h3></p>
<p><h3><ul>
  <li><a href="https://yeezus461.appspot.com/">Home</a></li>
  <li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Login</a></li>
  <li><a href="http://www.kanyewest.com/">Music</a></li>
  <li><a href="http://localhost:8888/allposts.jsp">All Posts</a></li>
  <li><a href="http://localhost:8888/subscribe.jsp">Subscribe</a></li>
</ul></h3></p>

	
	<form action="/subscribe" method="post">
	
		<fieldset style="width:0px"><legend><h>Subscription Options:</h></legend>

          <div><input type="submit" value="Subscribe"/></div>

       	  <input type="button" class="button" value="Unsubscribe">
          
          </fieldset>

	</form>

<%

ObjectifyService.register(Subscriber.class);

List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();

Collections.sort(subscribers); 


 
    
%>

 

 
 
 

  </body>

</html>