import com.sun.deploy.net.HttpResponse;
import com.sun.deploy.util.StringUtils;
import com.sun.xml.internal.ws.api.pipe.ThrowableContainerPropertySet;

import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentLinkedQueue;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/login/{nick}")
public class Login {


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

    @OnOpen
    public void onOpen(Session session, @PathParam("nick") String nick) {
        System.out.println(nick + " try to login");
        RemoteEndpoint.Basic writer = session.getBasicRemote();
        try {
            if (Server.users.contains(new User(nick, null))) {
                writer.sendText("NO!");
                System.out.println(nick + " error of login");

            } else {
                writer.sendText("OK");
                System.out.println(nick + " loging");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session,@PathParam("nick") String nick){
        System.out.printf(nick + " has disconected!");

    }

    @OnError
    public void onError(Session session, Throwable throwable){
        throwable.printStackTrace();
    }
}