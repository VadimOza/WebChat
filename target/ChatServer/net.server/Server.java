import com.sun.deploy.net.HttpResponse;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class Server extends HttpServlet {
    static HashSet<User> users = new HashSet<User>();
    Collection<String> allMessages = new LinkedList<String>();


    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException {
        log("hello log");
        log(request.getParameter("sendMessage"));
        PrintWriter pw =  response.getWriter();
        pw.print("<h1>"+request.getParameter("message")+"<h1>");


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log("hello log");
        log(req.getParameter("sendMessage"));

    }
}