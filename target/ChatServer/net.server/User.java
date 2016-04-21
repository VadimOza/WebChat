import com.sun.deploy.net.HttpResponse;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by Вадим on 12.04.2016.
 */
public class User {
    String nick;
    String id;
    HttpServletResponse rs;

    public User(String nick, String id, HttpServletResponse rs) {
        this.nick = nick;
        this.id = id;
        this.rs = rs;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (nick != null ? !nick.equals(user.nick) : user.nick != null) return false;
        if (id != null ? !id.equals(user.id) : user.id != null) return false;
        return rs != null ? rs.equals(user.rs) : user.rs == null;

    }

    @Override
    public int hashCode() {
        int result = nick != null ? nick.hashCode() : 0;
        result = 31 * result + (id != null ? id.hashCode() : 0);
        result = 31 * result + (rs != null ? rs.hashCode() : 0);
        return result;
    }
}



