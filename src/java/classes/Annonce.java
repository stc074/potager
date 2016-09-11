/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package classes;

import java.io.File;
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
public class Annonce extends Objet {

    private int type1;
    private int type2;
    private int type3;
    private String titre;
    private String titreContre;
    private String description;
    private String descriptionContre;
    private String captcha;
    private long id;
    private Membre membre;
    private long idMembre;
    private long timestamp;
    private String[] extensions;
    private String pseudo;
    private String region;
    private String departement;
    private String commune;
    private String codePostal;
    private String tagTitle;
    private String tagDescription;
    private String uri;

    public Annonce(Membre membre, long idMembre) {
        super();
        this.membre=membre;
        this.idMembre=idMembre;
        this.membre.initInfos(idMembre);
        this.type1=0;
        this.type2=0;
        this.type3=0;
        this.titre="";
        this.titreContre="";
        this.description="";
        this.descriptionContre="";
        this.extensions=new String[5];
    }

    public Annonce() {
        super();
        this.extensions=new String[5];
    }

    public void getGetsDepot(HttpServletRequest request) {
        if(request.getParameter("type1")!=null)
            this.type1=Integer.parseInt(request.getParameter("type1"));
        if(request.getParameter("type2")!=null)
            this.type2=Integer.parseInt(request.getParameter("type2"));
        if(request.getParameter("type3")!=null)
            this.type3=Integer.parseInt(request.getParameter("type3"));
    }

    public void getPostsDepot(HttpServletRequest request) {
        this.type1=Integer.parseInt(request.getParameter("type1"));
        this.type2=Integer.parseInt(request.getParameter("type2"));
        this.type3=Integer.parseInt(request.getParameter("type3"));
        this.titre=request.getParameter("titre");
        this.titre=Objet.codeHTML(this.titre);
        this.description=request.getParameter("description");
        this.description=Objet.codeHTML2(this.description);
        if(this.type2==1) {
            this.titreContre=request.getParameter("titreContre");
            this.titreContre=Objet.codeHTML(this.titreContre);
            this.descriptionContre=request.getParameter("descriptionContre");
            this.descriptionContre=Objet.codeHTML2(this.description);
        }
        this.captcha=request.getParameter("captcha");
        this.captcha=Objet.codeHTML(this.captcha);
    }

    public void verifPostsDepot(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(true);
            if (this.type1 == 0) {
                this.setErrorMsg("Veuillez spécifier s'il s'agit d'une PROPOSITION ou d'une RECHERCHE SVP.<br/>");
            }
            if (this.type2 == 0) {
                this.setErrorMsg("Veuillez spécifier s'il s'agit d'un ÉCHANGE ou d'un DON SVP.<br/>");
            }
            if (this.type3 == 0) {
                this.setErrorMsg("Veuillez spécifier le TYPE DE PRODUIT SVP.<br/>");
            }
            if (this.titre.length() == 0) {
                this.setErrorMsg("Champ COURTE DESCRIPTION vide.<br/>");
            } else if (this.titre.length() < 4) {
                this.setErrorMsg("Champ COURTE DESCRIPTION trop court.<br/>");
            } else if (this.titre.length() > 40) {
                this.setErrorMsg("Champ COURTE DESCRIPTION trop long.<br/>");
            }
            if (this.description.length() == 0) {
                this.setErrorMsg("Champ DESCRIPTION vide.<br/>");
            } else if (this.description.length() < 10) {
                this.setErrorMsg("Champ DESCRIPTION trop court.<br/>");
            } else if (this.description.length() > 5000) {
                this.setErrorMsg("Champ DESCRIPTION trop long.<br/>");
            }
            if (this.type2 == 1) {
                if (this.titreContre.length() == 0) {
                    this.setErrorMsg("Champ 2° COURTE DESCRIPTION vide.<br/>");
                } else if (this.titreContre.length() < 4) {
                    this.setErrorMsg("Champ 2° COURTE DESCRIPTION trop court.<br/>");
                } else if (this.titreContre.length() > 40) {
                    this.setErrorMsg("Champ 2° COURTE DESCRIPTION trop long.<br/>");
                }
                if (this.descriptionContre.length() == 0) {
                    this.setErrorMsg("Champ 2° DESCRIPTION vide.<br/>");
                } else if (this.descriptionContre.length() < 10) {
                    this.setErrorMsg("Champ 2° DESCRIPTION trop court.<br/>");
                } else if (this.descriptionContre.length() > 5000) {
                    this.setErrorMsg("Champ 2° DESCRIPTION trop long.<br/>");
                }
            }
            if (this.captcha.length() == 0) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT vide.<br/>");
            } else if (this.captcha.length() > 5) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT trop long.<br/>");
            } else if (session.getAttribute("captcha") == null) {
                this.setErrorMsg("Temps de session CODE ANTI-ROBOT passée.<br/>");
            } else if (!session.getAttribute("captcha").toString().equals(Objet.getEncoded(this.captcha))) {
                this.setErrorMsg("Mauvais CODE ANTI-ROBOT.<br/>");
            }
            if(this.getErrorMsg().length()==0) {
                try {
                    Objet.getConnection();
                    String query="INSERT INTO table_annonces (id_membre,type1,type2,type3,titre,description,titre_contre,description_contre,timestamp,last_timestamp) VALUES (?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.getMembre().getId());
                    prepare.setInt(2, this.type1);
                    prepare.setInt(3, this.type2);
                    prepare.setInt(4, this.type3);
                    prepare.setString(5, this.titre);
                    prepare.setString(6, this.description);
                    prepare.setString(7, this.titreContre);
                    prepare.setString(8, this.descriptionContre);
                    Calendar cal=Calendar.getInstance();
                    long ts=cal.getTimeInMillis();
                    prepare.setLong(9, ts);
                    prepare.setLong(10, ts);
                    prepare.executeUpdate();
                    prepare.close();
                    query="SELECT LAST_INSERT_ID() AS idAnnonce FROM table_annonces WHERE id_membre=?";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.getMembre().getId());
                    ResultSet result=prepare.executeQuery();
                    boolean flag=result.next();
                    if(!flag) {
                        this.setErrorMsg("Erreur interne, veuillez réessayer.<br/>");
                        result.close();
                        prepare.close();
                    } else if(flag) {
                        this.setId(result.getLong("idAnnonce"));
                        session.setAttribute("idAnnonce", this.getId());
                        result.close();
                        prepare.close();
                        Mail mail=new Mail(this.getMembre().getEmail(), this.getMembre().getPseudo(), Datas.TITRESITE+" - Nouvelle annonce");
                        mail.initMailAnnonce1(this.getMembre().getPseudo(), this.titre, this.getId());
                        mail.send();
                        session.setAttribute("captcha", null);
                        this.setTest(1);
                    }
                    Objet.closeConnection();
                } catch (NamingException ex) {
                    Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
                } catch (SQLException ex) {
                    Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
                }
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
        }
    }

    public void effaceAnnonce(long idAnnonce, long idMembre) {
        this.id=idAnnonce;
        this.idMembre=idMembre;
        try {
            Objet.getConnection();
            String query="SELECT COUNT(id) AS nb FROM table_annonces WHERE id=? AND id_membre=?";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.id);
            prepare.setLong(2, this.idMembre);
            ResultSet result=prepare.executeQuery();
            result.next();
            int nb=result.getInt("nb");
            if(nb==0) {
                this.id=0;
                result.close();
                prepare.close();
            } else {
                result.close();
                prepare.close();
                query="SELECT extension1,extension2,extension3,extension4,extension5 FROM table_annonces WHERE id=? AND id_membre=?";
                prepare=Objet.getConn().prepareStatement(query);
                prepare.setLong(1, this.id);
                prepare.setLong(2, this.idMembre);
                result=prepare.executeQuery();
                boolean flag=result.next();
                if(!flag) {
                    this.id=0;
                    result.close();
                    prepare.close();
                } else {
                    extensions[0]=result.getString("extension1");
                    extensions[1]=result.getString("extension2");
                    extensions[2]=result.getString("extension3");
                    extensions[3]=result.getString("extension4");
                    extensions[4]=result.getString("extension5");
                    result.close();
                    prepare.close();
                    for(int i=1;i<=5;i++) {
                        String extension=getExtensions()[i-1];
                        if(extension.length()>0) {
                                String filename=Datas.DIR+"/photos/"+i+"_"+this.id+extension;
                                String filenameMini1=Datas.DIR+"/photos/mini1_"+i+"_"+this.id+extension;
                                String filenameMini2=Datas.DIR+"/photos/mini2_"+i+"_"+this.id+extension;
                                File file=new File(filename);
                                File fileMini1=new File(filenameMini1);
                                File fileMini2=new File(filenameMini2);
                                if(file.exists())
                                    file.delete();
                                if(fileMini1.exists())
                                    fileMini1.delete();
                                if(fileMini2.exists())
                                    fileMini2.delete();
                        }
                    }
                    query="DELETE FROM table_annonces WHERE id=? AND id_membre=?";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.id);
                    prepare.setLong(2, this.idMembre);
                    prepare.executeUpdate();
                    prepare.close();
                    query="DELETE FROM table_messages WHERE id_annonce=? AND (id_membre_expediteur=? OR id_membre_destinataire=?)";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.id);
                    prepare.setLong(2, this.idMembre);
                    prepare.setLong(3, this.idMembre);
                    prepare.executeUpdate();
                    prepare.close();
                        }
            }
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        } catch (SQLException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        }
    }

    public void effaceAnnonce2(long idAnnonce, long idMembre) {
        this.id=idAnnonce;
        this.idMembre=idMembre;
        try {
            String query="SELECT COUNT(id) AS nb FROM table_annonces WHERE id=? AND id_membre=?";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.id);
            prepare.setLong(2, this.idMembre);
            ResultSet result=prepare.executeQuery();
            result.next();
            int nb=result.getInt("nb");
            if(nb==0) {
                this.id=0;
                result.close();
                prepare.close();
            } else {
                result.close();
                prepare.close();
                query="SELECT extension1,extension2,extension3,extension4,extension5 FROM table_annonces WHERE id=? AND id_membre=?";
                prepare=Objet.getConn().prepareStatement(query);
                prepare.setLong(1, this.id);
                prepare.setLong(2, this.idMembre);
                result=prepare.executeQuery();
                boolean flag=result.next();
                if(!flag) {
                    this.id=0;
                    result.close();
                    prepare.close();
                } else {
                    extensions[0]=result.getString("extension1");
                    extensions[1]=result.getString("extension2");
                    extensions[2]=result.getString("extension3");
                    extensions[3]=result.getString("extension4");
                    extensions[4]=result.getString("extension5");
                    result.close();
                    prepare.close();
                    for(int i=1;i<=5;i++) {
                        String extension=getExtensions()[i-1];
                        if(extension.length()>0) {
                                String filename=Datas.DIR+"/photos/"+i+"_"+this.id+extension;
                                String filenameMini1=Datas.DIR+"/photos/mini1_"+i+"_"+this.id+extension;
                                String filenameMini2=Datas.DIR+"/photos/mini2_"+i+"_"+this.id+extension;
                                File file=new File(filename);
                                File fileMini1=new File(filenameMini1);
                                File fileMini2=new File(filenameMini2);
                                if(file.exists())
                                    file.delete();
                                if(fileMini1.exists())
                                    fileMini1.delete();
                                if(fileMini2.exists())
                                    fileMini2.delete();
                        }
                    }
                    query="DELETE FROM table_annonces WHERE id=? AND id_membre=?";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.id);
                    prepare.setLong(2, this.idMembre);
                    prepare.executeUpdate();
                    prepare.close();
                    query="DELETE FROM table_messages WHERE id_annonce=? AND (id_membre_expediteur=? OR id_membre_destinataire=?)";
                    prepare=Objet.getConn().prepareStatement(query);
                    prepare.setLong(1, this.id);
                    prepare.setLong(2, this.idMembre);
                    prepare.setLong(3, this.idMembre);
                    prepare.executeUpdate();
                    prepare.close();
                        }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        }
    }

    public void initEdit(long idAnnonce) {
        this.id=idAnnonce;
        try {
            Objet.getConnection();
            String query="SELECT type1,type2,type3,titre,description,titre_contre,description_contre,timestamp FROM table_annonces WHERE id=? AND id_membre=? LIMIT 0,1";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.id);
            prepare.setLong(2, this.idMembre);
            ResultSet result=prepare.executeQuery();
            boolean flag=result.next();
            if(!flag)
                this.id=0;
            else if(flag) {
                this.type1=result.getInt("type1");
                this.type2=result.getInt("type2");
                this.type3=result.getInt("type3");
                this.titre=result.getString("titre");
                this.description=result.getString("description");
                this.titreContre=result.getString("titre_contre");
                this.descriptionContre=result.getString("description_contre");
                this.timestamp=result.getLong("timestamp");
            }
            result.close();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        } catch (SQLException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        }
    }

    public void getPostsEdit(HttpServletRequest request) {
        this.titre=request.getParameter("titre");
        this.titre=Objet.codeHTML(this.titre);
        this.description=request.getParameter("description");
        this.description=Objet.codeHTML2(this.description);
        if(this.type2==1) {
            this.titreContre=request.getParameter("titreContre");
            this.titreContre=Objet.codeHTML(this.titreContre);
            this.descriptionContre=request.getParameter("descriptionContre");
            this.descriptionContre=Objet.codeHTML2(this.descriptionContre);
        }
        this.captcha=request.getParameter("captcha");
        this.captcha=Objet.codeHTML(this.captcha);
    }

    public void verifPostsEdit(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(true);
            if (this.titre.length() == 0) {
                this.setErrorMsg("Champ COURTE DESCRIPTION vide.<br/>");
            } else if (this.titre.length() < 4) {
                this.setErrorMsg("Champ COURTE DESCRIPTION trop court.<br/>");
            } else if (this.titre.length() > 40) {
                this.setErrorMsg("Champ COURTE DESCRIPTION trop long.<br/>");
            }
            if (this.description.length() == 0) {
                this.setErrorMsg("Champ DESCRIPTION vide.<br/>");
            } else if (this.description.length() < 10) {
                this.setErrorMsg("Champ DESCRIPTION trop court.<br/>");
            } else if (this.description.length() > 5000) {
                this.setErrorMsg("Champ DESCRIPTION trop long.<br/>");
            }
            if (this.type2 == 1) {
                if (this.titreContre.length() == 0) {
                    this.setErrorMsg("Champ 2° COURTE DESCRIPTION vide.<br/>");
                } else if (this.titreContre.length() < 4) {
                    this.setErrorMsg("Champ 2° COURTE DESCRIPTION trop court.<br/>");
                } else if (this.titreContre.length() > 40) {
                    this.setErrorMsg("Champ 2° COURTE DESCRIPTION trop long.<br/>");
                }
                if (this.descriptionContre.length() == 0) {
                    this.setErrorMsg("Champ 2° DESCRIPTION vide.<br/>");
                } else if (this.descriptionContre.length() < 10) {
                    this.setErrorMsg("Champ 2° DESCRIPTION trop court.<br/>");
                } else if (this.descriptionContre.length() > 5000) {
                    this.setErrorMsg("Champ 2° DESCRIPTION trop long.<br/>");
                }
            }
            if (this.captcha.length() == 0) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT vide.<br/>");
            } else if (this.captcha.length() > 5) {
                this.setErrorMsg("Champ CODE ANTI-ROBOT trop long.<br/>");
            } else if (session.getAttribute("captcha") == null) {
                this.setErrorMsg("Temps de session CODE ANTI-ROBOT passée.<br/>");
            } else if (!session.getAttribute("captcha").toString().equals(Objet.getEncoded(this.captcha))) {
                this.setErrorMsg("Mauvais CODE ANTI-ROBOT.<br/>");
            }
            if(this.getErrorMsg().length()==0) {
                try {
                    Objet.getConnection();
                    String query="UPDATE table_annonces SET titre=?,description=?,titre_contre=?,description_contre=?,last_timestamp=? WHERE id=? AND id_membre=?";
                    PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                    prepare.setString(1, this.titre);
                    prepare.setString(2, this.description);
                    prepare.setString(3, this.titreContre);
                    prepare.setString(4, this.descriptionContre);
                    Calendar cal=Calendar.getInstance();
                    long ts=cal.getTimeInMillis();
                    prepare.setLong(5, ts);
                    prepare.setLong(6, this.id);
                    prepare.setLong(7, this.membre.getId());
                    prepare.executeUpdate();
                    session.setAttribute("idAnnonce", this.id);
                    Mail mail=new Mail(this.membre.getEmail(), this.membre.getPseudo(), Datas.TITRESITE+" - Annonce modifié !");
                    mail.initMailAnnonceModif1(this.membre.getPseudo(), this.titre, this.id);
                    mail.send();
                    Objet.closeConnection();
                    this.setTest(1);
                } catch (NamingException ex) {
                    Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
                } catch (SQLException ex) {
                    Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
                    this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
                }
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.setErrorMsg("ERREUR INTERNE : "+ex.getMessage());
        }

    }

    public void initDatas(long idAnnonce) {
        this.id=idAnnonce;
        this.tagTitle="Le jardinage est plus sympa avec Potagers Solidaires.";
        this.tagDescription="Potagers Solidaires - Jardinez et partagez !";
        try {
            Objet.getConnection();
            String query="SELECT t1.type1,t1.type2,t1.type3,t1.titre,t1.description,t1.titre_contre,t1.description_contre,t1.extension1,t1.extension2,t1.extension3,t1.extension4,t1.extension5,t1.timestamp,t2.pseudo,t3.region,t4.departement,t5.commune,t5.code_postal FROM table_annonces AS t1,table_membres AS t2,table_regions AS t3,table_departements AS t4,table_communes AS t5 WHERE t1.etat='1' AND t1.id=? AND t2.id=t1.id_membre AND t3.id_region=t2.id_region AND t4.id_departement=t2.id_departement AND t5.id=t2.id_commune LIMIT 0,1";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, this.id);
            ResultSet result=prepare.executeQuery();
            boolean flag=result.next();
            if(!flag)
                this.id=0;
            else if(flag) {
                this.type1=result.getInt("type1");
                this.type2=result.getInt("type2");
                this.type3=result.getInt("type3");
                this.titre=result.getString("titre");
                this.description=result.getString("description");
                this.titreContre=result.getString("titre_contre");
                this.descriptionContre=result.getString("description_contre");
                this.extensions[0]=result.getString("extension1");
                this.extensions[1]=result.getString("extension2");
                this.extensions[2]=result.getString("extension3");
                this.extensions[3]=result.getString("extension4");
                this.extensions[4]=result.getString("extension5");
                this.timestamp=result.getLong("timestamp");
                this.pseudo=result.getString("pseudo");
                this.region=result.getString("region");
                this.departement=result.getString("departement");
                this.commune=result.getString("commune");
                this.codePostal=result.getString("code_postal");
                if(this.type2==1) {
                    this.uri="/annonce-"+this.id+"-"+Objet.encodeTitre(this.titre)+"-contre-"+Objet.encodeTitre(this.titreContre)+".html";
                    this.tagTitle=this.titre+" contre "+this.titreContre;
                    this.tagDescription="Potagers solidaires - jardinage - "+this.titre+" contre "+this.titreContre+".";
                } else {
                    this.uri="/annonce-"+this.id+"-"+Objet.encodeTitre(this.titre)+".html";
                    this.tagTitle=this.titre;
                    this.tagDescription="Potagers solidaires - jardinage - "+this.titre+".";
                }
                query="UPDATE table_annonces SET last_timestamp=? WHERE id=? AND etat='1'";
                prepare=Objet.getConn().prepareStatement(query);
                Calendar cal=Calendar.getInstance();
                long ts=cal.getTimeInMillis();
                prepare.setLong(1, ts);
                prepare.setLong(2, this.id);
                prepare.executeUpdate();
            }
            result.close();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            this.id=0;
        } catch (SQLException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
            //this.setErrorMsg(ex.getMessage());
            this.id=0;
        }
    }

    public void effaceOlds() {
        try {
            Objet.getConnection();
            Calendar cal=Calendar.getInstance();
            long ts=cal.getTimeInMillis()-((long)(1000.0*60.0*60.0*24.0*30.0*6.0));
            String query="SELECT id,id_membre FROM table_annonces WHERE last_timestamp<?";
            PreparedStatement prepare=Objet.getConn().prepareStatement(query);
            prepare.setLong(1, ts);
            ResultSet result=prepare.executeQuery();
            while(result.next()) {
                long idAnnonce=result.getLong("id");
                long idM=result.getLong("id_membre");
                effaceAnnonce2(idAnnonce, idM);
            }
            result.close();
            prepare.close();
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Annonce.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void blank() {
        super.blank();
        this.membre=null;
        this.idMembre=0;
        this.type1=0;
        this.type2=0;
        this.type3=0;
        this.titre="";
        this.titreContre="";
        this.description="";
        this.descriptionContre="";
    }
    /**
     * @param idMembre the idMembre to set
     */

    /**
     * @return the type1
     */
    public int getType1() {
        return type1;
    }

    /**
     * @return the type2
     */
    public int getType2() {
        return type2;
    }

    /**
     * @return the type3
     */
    public int getType3() {
        return type3;
    }

    /**
     * @return the titre
     */
    public String getTitre() {
        return titre;
    }

    /**
     * @return the titreContre
     */
    public String getTitreContre() {
        return titreContre;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @return the descriptionContre
     */
    public String getDescriptionContre() {
        return descriptionContre;
    }

    /**
     * @return the membre
     */
    public Membre getMembre() {
        return membre;
    }

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * @return the tagTitle
     */
    public String getTagTitle() {
        return tagTitle;
    }

    /**
     * @return the tagDescription
     */
    public String getTagDescription() {
        return tagDescription;
    }

    /**
     * @return the timestamp
     */
    public long getTimestamp() {
        return timestamp;
    }

    /**
     * @return the extensions
     */
    public String[] getExtensions() {
        return extensions;
    }

    /**
     * @return the pseudo
     */
    public String getPseudo() {
        return pseudo;
    }

    /**
     * @return the region
     */
    public String getRegion() {
        return region;
    }

    /**
     * @return the departement
     */
    public String getDepartement() {
        return departement;
    }

    /**
     * @return the commune
     */
    public String getCommune() {
        return commune;
    }

    /**
     * @return the codePostal
     */
    public String getCodePostal() {
        return codePostal;
    }

    /**
     * @return the uri
     */
    public String getUri() {
        return uri;
    }

}
