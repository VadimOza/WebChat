import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedList;


public class Login extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException {
        String nick = request.getParameter("username");

        if(!User.AllUsers.contains(nick)){
            User.AllUsers.add(nick);
            response.sendRedirect("/chat.jsp");

        } else {
            PrintWriter pw =  response.getWriter();
            response.setContentType("text/html");
            pw.print("<html>\n" +
                    "\n" +
                    "<style>\n" +
                    "\n" +
                    "</style>\n" +
                    "\n" +
                    "<head>\n" +
                    "    <link rel=\"stylesheet\" type=\"text/css\" href=\"Style/LoginStyle.css\">\n" +
                    "    <title>Login</title>\n" +
                    "</head>\n" +
                    "\n" +
                    "<body>\n" +
                    "\n" +
                    "<form action=\"LoginServlet\" method=\"get\">\n" +
                    "    <h2>Login</h2>\n" +
                    "    <input id=\"username\" name=\"username\" placeholder=\"Username\" type=\"text\" required>\n" +
                    "    <input type=\"file\" name=\"file1\">\n" +
                    "    <label >Nik is already in use</label>\n" +
                    "    <button> Login  </button>\n" +
                    "</form>\n" +
                    "\n" +
                    "</body>\n" +
                    "\n" +
                    "</html>");
        }


    }
}