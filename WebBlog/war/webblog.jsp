<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="webblog.Comment" %>
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

<%

    String webblogName = request.getParameter("webblogName");

    if (webblogName == null) {

    	webblogName = "Kanye's Greatest Blog";

    }

    pageContext.setAttribute("webblogName", webblogName);


    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p align = right>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    } else {
    	 	
    	

%>

<p align = right>Welcome to the one and only, Kanye West's Blog Page.</p>


<p align = right>Please <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>

if you would like to leave your 2 cents.</p>

<%

    }

%>

 

<%

ObjectifyService.register(Comment.class);

List<Comment> comments = ObjectifyService.ofy().load().type(Comment.class).list();

Collections.sort(comments); 

    if (comments.isEmpty()) {

        %>

        <p align = right>${fn:escapeXml(webblogName)} has no messages.</p>

        <%

    } else {

        %>

        <p align = right>Comments on ${fn:escapeXml(webblogName)}.</p>

        <%

        for (int i=((comments.size()-1)); i>(comments.size()-5); i--) {
        	
        	Comment comment = comments.get(i);
        
        	//Comment comment = comments.get(i);

        	pageContext.setAttribute("comment_title",

                      comment.getTitle());
        	
            pageContext.setAttribute("comment_content",

                      comment.getContent());
            
            
            pageContext.setAttribute("comment_date",

                      comment.getToday());
                     
            if (comment.getUser() == null) {

                %>

               <p align = right>An anonymous person wrote:</p>

                <%

            } else {

                pageContext.setAttribute("comment_user",

                                         comment.getUser());

                %>

                <p align = right><b>${fn:escapeXml(comment_user.nickname)}</b> wrote:</p>
                <blockquote align = right>Title: ${fn:escapeXml(comment_title)}</blockquote>
                <blockquote align = right>Sent on: ${fn:escapeXml(comment_date)}</blockquote>
            	<blockquote align = right>Comment: ${fn:escapeXml(comment_content)}</blockquote>
            	

                <%
            }

        }%>

	<% if (user != null) {%>

	
	
	<form action="/sign" method="post">
	
		<fieldset style="width:0px"><legend><h>Blog Post:</h></legend>
			
		  <div><textarea name="title" rows="1" cols="60">Title</textarea></div><br>

          <div><textarea name="content" rows="3" cols="60" >enter comment here</textarea></div>

          <div><input type="submit" value="Submit Comment" /></div>

          <input type="hidden" name="webblogName" value="${fn:escapeXml(webblogName)}"/>
          
          </fieldset>

	</form>
	<%} %>


        <%
    }

 
    
%>

 

 
 
 

  </body>

</html>