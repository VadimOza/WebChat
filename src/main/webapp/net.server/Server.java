import com.sun.deploy.net.HttpResponse;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class Server extends HttpServlet {
    HashSet<User> users = new HashSet<User>();
    Collection<String> allMessages = new LinkedList<String>();


    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException {


    }
}