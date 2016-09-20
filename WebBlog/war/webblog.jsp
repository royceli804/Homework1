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
 </head>
 
  <body>

<%

    String webblogName = request.getParameter("webblogName");

    if (webblogName == null) {

    	webblogName = "default";

    }

    pageContext.setAttribute("webblogName", webblogName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    } else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to include your name with your comment.</p>

<%

    }

%>

 

<%

ObjectifyService.register(Comment.class);

List<Comment> comments = ObjectifyService.ofy().load().type(Comment.class).list();   

Collections.sort(comments); 

    if (comments.isEmpty()) {

        %>

        <p>WebBlog '${fn:escapeXml(webblogName)}' has no messages.</p>

        <%

    } else {

        %>

        <p>Messages in WebBlog '${fn:escapeXml(webblogName)}'.</p>

        <%

        for (Comment comment : comments) {

            pageContext.setAttribute("comment_content",

                                     comment.getContent());

            if (comment.getUser() == null) {

                %>

                <p>An anonymous person wrote:</p>

                <%

            } else {

                pageContext.setAttribute("comment_user",

                                         comment.getUser());

                %>

                <p><b>${fn:escapeXml(comment_user.nickname)}</b> wrote:</p>

                <%

            }

            %>

            <blockquote>${fn:escapeXml(comment_content)}</blockquote>

            <%

        }

    }

%>

 

    <form action="/sign" method="post">

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Submit Comment" /></div>

      <input type="hidden" name="webblogName" value="${fn:escapeXml(webblogName)}"/>

    </form>

 

  </body>

</html>