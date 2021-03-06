package webblog;


import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import webblog.Subscriber;

 



public class SubscribeServlet extends HttpServlet {
	

static {

        ObjectifyService.register(Subscriber.class);

    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

        Subscriber subscriber = new Subscriber(user);
        
        List <Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
        
        if(req.getParameter("sub") != null){
        	
        	subscribers.add(subscriber);
        	ofy().save().entities(subscribers).now();
        	

        	//Collections.sort(subscribers); 
        } else if(req.getParameter("unsub") != null) {
        	
        	subscribers.remove(subscriber);
        	ofy().save().entities(subscribers).now();   	
        }
        
        
        resp.sendRedirect("/webblog.jsp?webblogName=");
        
        //ofy().load().entity(Subscriber).get();

        
        
        

    }

}