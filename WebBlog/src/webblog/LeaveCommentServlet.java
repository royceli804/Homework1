package webblog;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;


import java.io.IOException;
import java.util.Date;


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class LeaveCommentServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

 


        String webblogName = req.getParameter("webblogName");

        Key webblogKey = KeyFactory.createKey("WebBlog", webblogName);

        String content = req.getParameter("content");

        Date date = new Date();

        Entity comment = new Entity("Comment", webblogKey);

        comment.setProperty("user", user);

        comment.setProperty("date", date);

        comment.setProperty("content", content);

 

        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

        datastore.put(comment);

 

        resp.sendRedirect("/webblog.jsp?webblogName=" + webblogName);

    }

}