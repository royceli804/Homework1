package webblog;


import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;

import java.util.Date;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import webblog.Comment;

 



public class LeaveCommentServlet extends HttpServlet {
	

static {

        ObjectifyService.register(Comment.class);

    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

        String content = req.getParameter("content");
        
        Comment comment = new Comment(user, content);
        
        //ofy().load().entity(comment).get();
        
        ofy().save().entity(comment).now();
        
 

        resp.sendRedirect("/webblog.jsp?webblogName=");
        

    }

}