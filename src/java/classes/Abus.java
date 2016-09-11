/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author pj
 */
public class Abus extends Objet {

    private long idAnnonce;
    private long id;
    private long timestamp;
    private int type2;
    private String titre;
    private String description;
    private String titreContre;
    private String descriptionContre;
    private long idMembre;
    
    public Abus(long idAnnonce) {
        super();
        this.idAnnonce=idAnnonce;
    }

    public Abus() {
        super();
    }

    public void enregistre() {
        try {
            Objet.getConnection();
            String query="SELECT COUNT(id) AS nb FROM table_abus WHERE id_annonce=?";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.idAnnonce);
            ResultSet result=prepare.executeQuery();
            result.next();
            int nb=result.getInt("nb");
            result.close();
            prepare.close();
            if(nb==0) {
            query="INSERT INTO table_abus (id_annonce,timestamp) VALUES (?,?)";
            prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.getIdAnnonce());
            Calendar cal=Calendar.getInstance();
            long ts=cal.getTimeInMillis();
            prepare.setLong(2, ts);
            prepare.executeUpdate();
            prepare.close();
            query="SELECT LAST_INSERT_ID() AS idAbus FROM table_abus WHERE id_annonce=?";
            prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.idAnnonce);
            result=prepare.executeQuery();
            boolean flag=result.next();
            if(!flag) {
                this.idAnnonce=0;
                result.close();
                prepare.close();
            } else if(flag) {
                this.id=result.getLong("idAbus");
                result.close();
                prepare.close();
                Mail mail=new Mail(Datas.EMAILADMIN, Datas.TITRESITE+" - ADMIN", Datas.TITRESITE+" - Abus signalé !");
                mail.initMailAbus(this.getId());
                mail.send();
            }
            }
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
            this.idAnnonce=0;
        } catch (SQLException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
            this.idAnnonce=0;
        }
    }

    public void initAbus(long idAbus) {
        this.id=idAbus;
        try {
            Objet.getConnection();
            String query="SELECT t1.timestamp,t2.type2,t2.titre,t2.description,t2.titre_contre,t2.description_contre FROM table_abus AS t1,table_annonces AS t2 WHERE t1.id=? AND t2.id=t1.id_annonce LIMIT 0,1";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.getId());
            ResultSet result=prepare.executeQuery();
            result.next();
            this.timestamp=result.getLong("timestamp");
            this.type2=result.getInt("type2");
            this.titre=result.getString("titre");
            this.description=result.getString("description");
            this.titreContre=result.getString("titre_contre");
            this.descriptionContre=result.getString("description_contre");
            result.close();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void ignoreAbus(long idAbus) {
        this.id=idAbus;
        try {
            Objet.getConnection();
            String query="DELETE FROM table_abus WHERE id=?";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.id);
            prepare.executeUpdate();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void effaceAnnonce(long idAbus) {
        this.id=idAbus;
        try {
            Objet.getConnection();
            String query="SELECT t1.id,t1.id_membre FROM table_annonces AS t1,table_abus AS t2 WHERE t2.id=? AND t1.id=t2.id_annonce LIMIT 0,1";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.id);
            ResultSet result=prepare.executeQuery();
            result.next();
            this.idAnnonce=result.getLong("id");
            this.idMembre=result.getLong("id_membre");
            Annonce annonce=new Annonce();
            annonce.effaceAnnonce(idAnnonce, idMembre);
            query="DELETE FROM table_abus WHERE id=?";
            prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.id);
            prepare.executeUpdate();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Abus.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * @return the idAnnonce
     */
    public long getIdAnnonce() {
        return idAnnonce;
    }

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @return the timestamp
     */
    public long getTimestamp() {
        return timestamp;
    }

    /**
     * @return the type2
     */
    public int getType2() {
        return type2;
    }

    /**
     * @return the titre
     */
    public String getTitre() {
        return titre;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @return the titreContre
     */
    public String getTitreContre() {
        return titreContre;
    }

    /**
     * @return the descriptionContre
     */
    public String getDescriptionContre() {
        return descriptionContre;
    }

}
