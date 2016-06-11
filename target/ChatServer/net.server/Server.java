import com.sun.deploy.net.HttpResponse;
import com.sun.deploy.util.StringUtils;


import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentLinkedQueue;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/server/{nick}")
public class Server {
    static ConcurrentLinkedQueue<User> users = new ConcurrentLinkedQueue<User>();
    static ConcurrentLinkedQueue<String> allMessages = new ConcurrentLinkedQueue<String>();

//    /**
//     * @OnOpen allows us to intercept the creation of a new session.
//     * The session class allows us to send data to the user.
//     * In the method onOpen, we'll let the user know that the handshake was
//     * successful.
//     */
//    @OnOpen
//    public void onOpen(Session session){
//        System.out.println(session.getId() + " has opened a connection");
//        try {
//            session.getBasicRemote().sendText("Connection Established");
//        } catch (IOException ex) {
//            ex.printStackTrace();
//        }
//    }
//
//    /**
//     * When a user sends a message to the server, this method will intercept the message
//     * and allow us to react to it. For now the message is read as a String.
//     */
//    @OnMessage
//    public void onMessage(String message, Session session){
//        System.out.println("Message from " + session.getId() + ": " + message);
//        try {
//            session.getBasicRemote().sendText(message);
//        } catch (IOException ex) {
//            ex.printStackTrace();
//        }
//    }
//
//    /**
//     * The user closes the connection.
//     *
//     * Note: you can't send messages to the client from this method
//     */
//    @OnClose
//    public void onClose(Session session){
//        System.out.println("Session " +session.getId()+" has ended");
//    }

    public String getDate() {
        Calendar c = new GregorianCalendar();
        String[] day = new String[]{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a");
        return day[(c.get(Calendar.DAY_OF_WEEK)) - 1] + " - " + sdf.format(cal.getTime());
    }

    @OnOpen
    public void onOpen(Session session, @PathParam("nick") String nick) {
        System.out.println(nick + " enter chat");
        RemoteEndpoint.Basic writer = session.getBasicRemote();
        try {
            if (users.contains(new User(nick, null))) {
                writer.sendText("NO!");


            } else {
                users.add(new User(nick, session));
                allMessages.add("{{newuser}}" + nick + "{{/newuser}}{{date}}" + getDate() + "{{/date}}");
                for (String str :
                        allMessages) {
                    session.getBasicRemote().sendText(str);
                }


            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(String message, Session session, @PathParam("nick") String nick) {
        message = "{{username}}" + nick + "{{/username}}" + "{{mes}}" + message;
        if (allMessages.size() == 50) {
            allMessages.poll();
            allMessages.add(message);
        } else {
            allMessages.add(message);
        }
        System.out.printf(message);
        for (User user :
                users) {
            user.send(message);
        }
    }

    @OnClose
    public void onClose(Session session, @PathParam("nick") String nick) {
        users.remove(new User(nick, null));
        System.out.printf(nick + " leave chat!");

    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.out.println("Окно было закрыто");
    }
}