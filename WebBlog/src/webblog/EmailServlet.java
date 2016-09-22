package webblog;

import java.io.IOException;
import java.util.Properties;
import java.util.logging.*;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class EmailServlet extends HttpServlet {

	public static final Logger _log = Logger.getLogger(EmailServlet.class.getName());
	
  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    Properties props = new Properties();
    Session session = Session.getDefaultInstance(props, null);

    try {
      MimeMessage mess = new MimeMessage(session, req.getInputStream());
      Address[] fromAddresses = mess.getFrom();
      
      MimeMessage dig = new MimeMessage(session);   
      dig.setFrom(new InternetAddress("admin@yeezy461.appspotmail.com", "Kanye's Greatest Blog Admin"));
      dig.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(fromAddresses[0].toString()));
      dig.setSubject("Daily Greatests Posts of All Time");
      dig.setText("!!!");
      Transport.send(dig);
      
      _log.info(fromAddresses[0].toString());
		System.out.printf((_log.toString()));
      
    } 	catch (MessagingException e) { 
		_log.info("ERROR: Could not send out Email Results response : " + e.getMessage());
	}
    // [END simple_example]
  }
}
