package webblog;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class CronJobServlet extends HttpServlet{
	private static final Logger _logger = Logger.getLogger(CronJobServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
	try {
	_logger.info("Cron Job has been executed");
	//Put your logic here
	//BEGIN
	//END
	}
	catch (Exception ex) {
	//Log any exceptions in your Cron Job
	}
	}
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
	doGet(req, resp);
	}
}