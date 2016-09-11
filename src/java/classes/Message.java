/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package classes;

import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author pj
 */
public class Message extends Objet {

    private String titreMsg;
    private String contenuMsg;
    private String captcha;
    private long idAnnonce;
    private long idMembreExpediteur;
    private int type2;
    private String titreAnnonce;
    private String titreContreAnnonce;
    private String pseudoExpediteur;
    private String emailExpediteur;
    private String pseudoDestinataire;
    private String emailDestinataire;
    private long timestampAnnonce;
    private long idMembreDestinataire;
    private long id;
    private String titre;
    private String contenu;
    private long timestamp;
    private long idPrec;
    private String titrePrec;
    private String contenuPrec;
    private long timestampPrec;

    public Message() {
        super();
        this.titreMsg="";
        this.contenuMsg="";
        this.captcha="";
    }

    public Message(long idMessage) {
        super();
        this.id=idMessage;
        this.titreMsg="";
        this.contenuMsg="";
        this.captcha="";
    }

    public void initContact(long idAnnonce, long idMembreExpediteur) {
        this.idAnnonce=idAnnonce;
        this.idMembreExpediteur=idMembreExpediteur;
        try {
            Objet.getConnection();
            String query="SELECT t1.type2,t1.titre,t1.titre_contre,t1.timestamp,t2.pseudo AS pseudoExpediteur,t2.email AS emailExpediteur,t3.id AS idMembreDestinataire,t3.pseudo AS pseudoDestinataire,t3.email AS emailDestinataire FROM table_annonces AS t1,table_membres AS t2,table_membres AS t3 WHERE t1.id=? AND t2.id=? AND t3.id=t1.id_membre LIMIT 0,1";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.idAnnonce);
            prepare.setLong(2, this.idMembreExpediteur);
            ResultSet result=prepare.executeQuery();
            boolean flag=result.next();
            if(!flag)
                this.idAnnonce=0;
            else if(flag) {
                this.type2=result.getInt("type2");
                this.titreAnnonce=result.getString("titre");
                this.titreContreAnnonce=result.getString("titre_contre");
                this.timestampAnnonce=result.getLong("timestamp");
                this.pseudoExpediteur=result.getString("pseudoExpediteur");
                this.emailExpediteur=result.getString("emailExpediteur");
                this.idMembreDestinataire=result.getLong("idMembreDestinataire");
                this.pseudoDestinataire=result.getString("pseudoDestinataire");
                this.emailDestinataire=result.getString("emailDestinataire");
            }
            result.close();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.idAnnonce=0;
        } catch (SQLException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.idAnnonce=0;
        }
    }

    public void getPosts1(HttpServletRequest request) {
        this.titreMsg=request.getParameter("titreMsg");
        this.titreMsg=Objet.codeHTML(this.titreMsg);
        this.contenuMsg=request.getParameter("contenuMsg");
        this.contenuMsg=Objet.codeHTML2(this.contenuMsg);
        this.captcha=request.getParameter("captcha").toLowerCase();
        this.captcha=Objet.codeHTML(this.captcha);
    }

    public void verifPosts1(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(true);
            if (titreMsg.length() == 0) {
                this.setErrorMsg("Champ TITRE DU MESSAGE vide.<br/>");
            } else if (this.titreMsg.length() > 40) {
                this.setErrorMsg("Champ TITRE DU MESSAGE trop long.<br/>");
            }
            if (this.contenuMsg.length() == 0) {
                this.setErrorMsg("Champ CONTENU DU MESSAGE vide.<br/>");
            } else if (this.contenuMsg.length() > 3000) {
                this.setErrorMsg("Champ CONTENU DU MESSAGE trop long.<br/>");
            }
            if (this.captcha.length() == 0) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT vide.<br/>");
            } else if (this.captcha.length() > 5) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT trop long.<br/>");
            } else if (session.getAttribute("captcha") == null) {
                this.setErrorMsg("Session CODE ANTI-ROBOT dépassée.<br/>");
            } else if (!session.getAttribute("captcha").toString().equals(Objet.getEncoded(this.captcha))) {
                this.setErrorMsg("Mauvais CODE ANTI-ROBOT.<br/>");
            }
            if(this.getErrorMsg().length()==0) {
                try {
                    Objet.getConnection();
                    String query="INSERT INTO table_messages (id_annonce,id_membre_expediteur,id_membre_destinataire,titre,contenu,timestamp) VALUES (?,?,?,?,?,?)";
                    PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.idAnnonce);
                    prepare.setLong(2, this.idMembreExpediteur);
                    prepare.setLong(3, this.idMembreDestinataire);
                    prepare.setString(4, this.titreMsg);
                    prepare.setString(5, this.contenuMsg);
                    Calendar cal=Calendar.getInstance();
                    long ts=cal.getTimeInMillis();
                    prepare.setLong(6, ts);
                    prepare.executeUpdate();
                    prepare.close();
                    query="SELECT LAST_INSERT_ID() AS idMessage FROM table_messages WHERE id_membre_expediteur=? AND id_membre_destinataire=?";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.idMembreExpediteur);
                    prepare.setLong(2, this.idMembreDestinataire);
                    ResultSet result=prepare.executeQuery();
                    result.next();
                    long idMesssage=result.getLong("idMessage");
                    result.close();
                    prepare.close();
                    Mail mail=new Mail(this.emailExpediteur, this.getPseudoExpediteur(), Datas.TITRESITE+"- Message envoyé !");
                    mail.initMailMessage1(this.getPseudoExpediteur(),this.pseudoDestinataire, this.titreMsg, idMesssage);
                    mail.send();
                    mail=new Mail(this.emailDestinataire, this.pseudoDestinataire, Datas.TITRESITE+" - Nouveau message !");
                    mail.initMailMessage2(this.getPseudoExpediteur(),this.pseudoDestinataire, this.titreMsg, idMesssage);
                    mail.send();
                    Objet.closeConnection();
                    session.setAttribute("captcha", null);
                    this.setTest(1);
                } catch (NamingException ex) {
                    Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
                } catch (SQLException ex) {
                    Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
                }
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
        }
    }

    public void initMessageRecu(long idMembre) {
        this.idMembreDestinataire=idMembre;
        try {
            Objet.getConnection();
            String query="UPDATE table_messages SET etat='1' WHERE id=? AND id_membre_destinataire=?";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.getId());
            prepare.setLong(2, this.idMembreDestinataire);
            prepare.executeUpdate();
            prepare.close();
            query="SELECT t1.id_annonce,t1.id_prec,t1.titre,t1.contenu,t1.timestamp,t2.id AS idMembreExpediteur,t2.pseudo AS pseudoExpediteur,t2.email AS emailExpediteur,t3.pseudo AS pseudoDestinataire,t3.email AS emailDestinataire,t4.type2,t4.titre AS titreAnnonce,t4.titre_contre AS titreContreAnnonce FROM table_messages AS t1,table_membres AS t2,table_membres AS t3,table_annonces AS t4 WHERE t1.id=? AND t1.id_membre_destinataire=? AND t2.id=t1.id_membre_expediteur AND t3.id=t1.id_membre_destinataire AND t4.id=t1.id_annonce LIMIT 0,1";
            prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.getId());
            prepare.setLong(2, this.idMembreDestinataire);
            ResultSet result=prepare.executeQuery();
            result.next();
            this.idAnnonce=result.getLong("id_annonce");
            this.idPrec=result.getLong("id_prec");
            this.titre=result.getString("titre");
            this.contenu=result.getString("contenu");
            this.timestamp=result.getLong("timestamp");
            this.idMembreExpediteur=result.getLong("idMembreExpediteur");
            this.pseudoExpediteur=result.getString("pseudoExpediteur");
            this.emailExpediteur=result.getString("emailExpediteur");
            this.pseudoDestinataire=result.getString("pseudoDestinataire");
            this.emailDestinataire=result.getString("emailDestinataire");
            this.type2=result.getInt("type2");
            this.titreAnnonce=result.getString("titreAnnonce");
            this.titreContreAnnonce=result.getString("titreContreAnnonce");
            if(this.type2==1)
                this.titreAnnonce=this.titreAnnonce+" contre "+this.titreContreAnnonce;
            result.close();
            prepare.close();
            if(this.getIdPrec()!=0) {
                query="SELECT titre,contenu,timestamp FROM table_messages WHERE id=? AND id_membre_expediteur=? LIMIT 0,1";
                prepare=Objet.getConn().prepareStatement(query);
                prepare.setLong(1, this.getIdPrec());
                prepare.setLong(2, this.idMembreDestinataire);
                result=prepare.executeQuery();
                result.next();
                this.titrePrec=result.getString("titre");
                this.contenuPrec=result.getString("contenu");
                this.timestampPrec=result.getLong("timestamp");
            }
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        } catch (SQLException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
            this.setErrorMsg(ex.getMessage());
        }
    }

    public void verifPosts2(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(true);
            if (titreMsg.length() == 0) {
                this.setErrorMsg("Champ TITRE DU MESSAGE vide.<br/>");
            } else if (this.titreMsg.length() > 40) {
                this.setErrorMsg("Champ TITRE DU MESSAGE trop long.<br/>");
            }
            if (this.contenuMsg.length() == 0) {
                this.setErrorMsg("Champ CONTENU DU MESSAGE vide.<br/>");
            } else if (this.contenuMsg.length() > 3000) {
                this.setErrorMsg("Champ CONTENU DU MESSAGE trop long.<br/>");
            }
            if (this.captcha.length() == 0) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT vide.<br/>");
            } else if (this.captcha.length() > 5) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT trop long.<br/>");
            } else if (session.getAttribute("captcha") == null) {
                this.setErrorMsg("Session CODE ANTI-ROBOT dépassée.<br/>");
            } else if (!session.getAttribute("captcha").toString().equals(Objet.getEncoded(this.captcha))) {
                this.setErrorMsg("Mauvais CODE ANTI-ROBOT.<br/>");
            }
            if(this.getErrorMsg().length()==0) {
                try {
                    Objet.getConnection();
                    String query="INSERT INTO table_messages (id_annonce,id_prec,id_membre_expediteur,id_membre_destinataire,titre,contenu,timestamp) VALUES (?,?,?,?,?,?,?)";
                    PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.idAnnonce);
                    prepare.setLong(2, this.id);
                    prepare.setLong(3, this.idMembreDestinataire);
                    prepare.setLong(4, this.idMembreExpediteur);
                    prepare.setString(5, this.titreMsg);
                    prepare.setString(6, this.contenuMsg);
                    Calendar cal=Calendar.getInstance();
                    long ts=cal.getTimeInMillis();
                    prepare.setLong(7, ts);
                    prepare.executeUpdate();
                    prepare.close();
                    query="SELECT LAST_INSERT_ID() AS idMessage FROM table_messages WHERE id_annonce=? AND id_membre_expediteur=? AND id_membre_destinataire=?";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.idAnnonce);
                    prepare.setLong(2, this.idMembreDestinataire);
                    prepare.setLong(3, this.idMembreExpediteur);
                    ResultSet result=prepare.executeQuery();
                    result.next();
                    long idMessage=result.getLong("idMessage");
                    result.close();
                    prepare.close();
                    Objet.closeConnection();
                    Mail mail=new Mail(this.emailDestinataire, this.pseudoDestinataire, "Message envoyé !");
                    mail.initMailMessage1(this.pseudoDestinataire, this.pseudoExpediteur, this.titreMsg, idMessage);
                    mail.send();
                    mail=new Mail(this.emailExpediteur, this.pseudoExpediteur, "Nouveau message !");
                    mail.initMailMessage2(this.pseudoDestinataire, this.pseudoExpediteur, this.titreMsg, idMessage);
                    mail.send();
                    session.setAttribute("captcha", null);
                    this.setTest(1);
                } catch (NamingException ex) {
                    Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTRENE : "+ex.getMessage()+".<br/>");
                } catch (SQLException ex) {
                    Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTRENE : "+ex.getMessage()+".<br/>");
                }
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.setErrorMsg("ERREUR INTRENE : "+ex.getMessage()+".<br/>");
        }

    }

    public void initMessageEnvoye(long idMembre) {
        this.idMembreExpediteur=idMembre;
        try {
            Objet.getConnection();
            String query="SELECT t1.id_annonce,t1.id_prec,t1.titre,t1.contenu,t1.timestamp,t2.id AS idMembreDestinataire,t2.pseudo AS pseudoDestinataire,t2.email AS emailDestinataire,t3.pseudo AS pseudoExpediteur,t3.email AS emailExpediteur,t4.type2,t4.titre AS titreAnnonce,t4.titre_contre AS titreContreAnnonce FROM table_messages AS t1,table_membres AS t2,table_membres AS t3,table_annonces AS t4 WHERE t1.id=? AND t1.id_membre_expediteur=? AND t2.id=t1.id_membre_destinataire AND t3.id=t1.id_membre_expediteur AND t4.id=t1.id_annonce LIMIT 0,1";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.getId());
            prepare.setLong(2, this.idMembreExpediteur);
            ResultSet result=prepare.executeQuery();
            result.next();
            this.idAnnonce=result.getLong("id_annonce");
            this.idPrec=result.getLong("id_prec");
            this.titre=result.getString("titre");
            this.contenu=result.getString("contenu");
            this.timestamp=result.getLong("timestamp");
            this.idMembreDestinataire=result.getLong("idMembreDestinataire");
            this.pseudoDestinataire=result.getString("pseudoDestinataire");
            this.emailDestinataire=result.getString("emailDestinataire");
            this.pseudoExpediteur=result.getString("pseudoExpediteur");
            this.emailExpediteur=result.getString("emailExpediteur");
            this.type2=result.getInt("type2");
            this.titreAnnonce=result.getString("titreAnnonce");
            this.titreContreAnnonce=result.getString("titreContreAnnonce");
            if(this.type2==1)
                this.titreAnnonce=this.titreAnnonce+" contre "+this.titreContreAnnonce;
            result.close();
            prepare.close();
            if(this.getIdPrec()!=0) {
                query="SELECT titre,contenu,timestamp FROM table_messages WHERE id=? AND id_membre_expediteur=? LIMIT 0,1";
                prepare=Objet.getConn().prepareStatement(query);
                prepare.setLong(1, this.getIdPrec());
                prepare.setLong(2, this.idMembreDestinataire);
                result=prepare.executeQuery();
                result.next();
                this.titrePrec=result.getString("titre");
                this.contenuPrec=result.getString("contenu");
                this.timestampPrec=result.getLong("timestamp");
            }
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        } catch (SQLException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
            this.setErrorMsg(ex.getMessage());
        }

    }

    public void verifPosts3(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(true);
            if (titreMsg.length() == 0) {
                this.setErrorMsg("Champ TITRE DU MESSAGE vide.<br/>");
            } else if (this.titreMsg.length() > 40) {
                this.setErrorMsg("Champ TITRE DU MESSAGE trop long.<br/>");
            }
            if (this.contenuMsg.length() == 0) {
                this.setErrorMsg("Champ CONTENU DU MESSAGE vide.<br/>");
            } else if (this.contenuMsg.length() > 3000) {
                this.setErrorMsg("Champ CONTENU DU MESSAGE trop long.<br/>");
            }
            if (this.captcha.length() == 0) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT vide.<br/>");
            } else if (this.captcha.length() > 5) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT trop long.<br/>");
            } else if (session.getAttribute("captcha") == null) {
                this.setErrorMsg("Session CODE ANTI-ROBOT dépassée.<br/>");
            } else if (!session.getAttribute("captcha").toString().equals(Objet.getEncoded(this.captcha))) {
                this.setErrorMsg("Mauvais CODE ANTI-ROBOT.<br/>");
            }
            if(this.getErrorMsg().length()==0) {
                try {
                    Objet.getConnection();
                    String query="INSERT INTO table_messages (id_annonce,id_prec,id_membre_expediteur,id_membre_destinataire,titre,contenu,timestamp) VALUES (?,?,?,?,?,?,?)";
                    PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.idAnnonce);
                    prepare.setLong(2, this.idPrec);
                    prepare.setLong(3, this.idMembreExpediteur);
                    prepare.setLong(4, this.idMembreDestinataire);
                    prepare.setString(5, this.titreMsg);
                    prepare.setString(6, this.contenuMsg);
                    Calendar cal=Calendar.getInstance();
                    long ts=cal.getTimeInMillis();
                    prepare.setLong(7, ts);
                    prepare.executeUpdate();
                    prepare.close();
                    query="SELECT LAST_INSERT_ID() AS idMessage FROM table_messages WHERE id_annonce=? AND id_membre_expediteur=? AND id_membre_destinataire=?";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.idAnnonce);
                    prepare.setLong(2, this.idMembreExpediteur);
                    prepare.setLong(3, this.idMembreDestinataire);
                    ResultSet result=prepare.executeQuery();
                    result.next();
                    long idMessage=result.getLong("idMessage");
                    result.close();
                    prepare.close();
                    Objet.closeConnection();
                    Mail mail=new Mail(this.emailExpediteur, this.pseudoExpediteur, "Message envoyé !");
                    mail.initMailMessage1(this.pseudoExpediteur, this.pseudoDestinataire, this.titreMsg, idMessage);
                    mail.send();
                    mail=new Mail(this.emailDestinataire, this.pseudoDestinataire, "Nouveau message !");
                    mail.initMailMessage2(this.pseudoExpediteur, this.pseudoDestinataire, this.titreMsg, idMessage);
                    mail.send();
                    this.setTest(1);
                } catch (NamingException ex) {
                    Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage()+".<br/>");
                } catch (SQLException ex) {
                    Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage()+".<br/>");
                }
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Message.class.getName()).log(Level.SEVERE, null, ex);
            this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage()+".<br/>");
        }

    }

    @Override
    public void blank() {
        super.blank();
        this.titreMsg="";
        this.contenuMsg="";
        this.captcha="";
    }

    /**
     * @return the titreMsg
     */
    public String getTitreMsg() {
        return titreMsg;
    }

    /**
     * @return the contenuMsg
     */
    public String getContenuMsg() {
        return contenuMsg;
    }

    /**
     * @return the idAnnonce
     */
    public long getIdAnnonce() {
        return idAnnonce;
    }

    /**
     * @return the type2
     */
    public int getType2() {
        return type2;
    }

    /**
     * @return the titreAnnonce
     */
    public String getTitreAnnonce() {
        return titreAnnonce;
    }

    /**
     * @return the titreContreAnnonce
     */
    public String getTitreContreAnnonce() {
        return titreContreAnnonce;
    }

    /**
     * @return the pseudoDestinataire
     */
    public String getPseudoDestinataire() {
        return pseudoDestinataire;
    }

    /**
     * @return the timestampAnnonce
     */
    public long getTimestampAnnonce() {
        return timestampAnnonce;
    }

    /**
     * @return the pseudoExpediteur
     */
    public String getPseudoExpediteur() {
        return pseudoExpediteur;
    }

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @return the titre
     */
    public String getTitre() {
        return titre;
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

    /**
     * @return the idPrec
     */
    public long getIdPrec() {
        return idPrec;
    }

    /**
     * @return the titrePrec
     */
    public String getTitrePrec() {
        return titrePrec;
    }

    /**
     * @return the contenuPrec
     */
    public String getContenuPrec() {
        return contenuPrec;
    }

    /**
     * @return the timestampPrec
     */
    public long getTimestampPrec() {
        return timestampPrec;
    }

}
