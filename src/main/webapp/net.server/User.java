import com.sun.deploy.net.HttpResponse;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;
import java.io.IOException;

/**
 * Created by Вадим on 12.04.2016.
 */
public class User {
    private String nick;
    private Session session;

    public User(String nick, Session session) {
        this.nick = nick;
        this.session = session;
    }

    public void send(String message){
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        return nick.equals(user.nick);

    }

    @Override
    public int hashCode() {
        int sum = 0;
        for (char c :
                this.nick.toCharArray()) {
            sum += (int) c;
        }
        return sum;
    }
}



