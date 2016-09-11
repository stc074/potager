/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author pj
 */
public class CGU extends Objet {

    private String contenu;
    private long timestamp;
    private long id;

    public CGU() {
        super();
        this.contenu="";
        this.timestamp=0;
    }

    public void init() {
        try {
            Objet.getConnection();
            String query="SELECT id,contenu,timestamp FROM table_cgus LIMIT 0,1";
            Statement state=Objet.getConn().createStatement();
            ResultSet result=state.executeQuery(query);
            result.next();
            this.id=result.getLong("id");
            this.contenu=result.getString("contenu");
            this.timestamp=result.getLong("timestamp");
            result.close();
            state.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(CGU.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CGU.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void getPosts(HttpServletRequest request) {
        this.contenu=request.getParameter("contenu");
        Calendar cal=Calendar.getInstance();
        this.timestamp=cal.getTimeInMillis();
        try {
            Objet.getConnection();
            String query="UPDATE table_cgus SET contenu=?,timestamp=? WHERE id=?";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setString(1, this.contenu);
            prepare.setLong(2, this.timestamp);
            prepare.setLong(3, this.id);
            prepare.executeUpdate();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(CGU.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CGU.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    /**
     * @return the contenu
     */
    public String getContenu() {
        return contenu;
    }

    /**
     * @return the timestamp
     */
    public long getTimestamp() {
        return timestamp;
    }

}
