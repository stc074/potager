/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package classes;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author pj
 */
public class RechercheAnnonces extends Objet {

    private String motsCles;
    private String condition;
    private int type1;
    private int type2;
    private int type3;
    private String idRegion;
    private String idDepartement;
    private int idCommune;
    private int page;
    private String tagTitle;
    private String tagDescription;

    public RechercheAnnonces() {
        super();
        this.motsCles="";
        this.type1=0;
        this.type2=0;
        this.type3=0;
        this.idRegion="0";
        this.idDepartement="0";
        this.idCommune=0;
        this.page=0;
    }

    public void init(HttpServletRequest request) {
        HttpSession session=request.getSession(true);
        this.motsCles="";
        if(session.getAttribute("motsCles")!=null)
            this.motsCles=Objet.codeHTML(session.getAttribute("motsCles").toString());
        this.type1=0;
        if(session.getAttribute("type1")!=null)
            this.type1=Integer.parseInt(session.getAttribute("type1").toString());
        this.type2=0;
        if(session.getAttribute("type2")!=null)
            this.type2=Integer.parseInt(session.getAttribute("type2").toString());
        this.type3=0;
        if(session.getAttribute("type3")!=null)
            this.type3=Integer.parseInt(session.getAttribute("type3").toString());
        this.idRegion="0";
        if(session.getAttribute("idRegion")!=null)
            this.idRegion=Objet.codeHTML(session.getAttribute("idRegion").toString());
        this.idDepartement="0";
        if(session.getAttribute("idDepartement")!=null)
            this.idDepartement=Objet.codeHTML(session.getAttribute("idDepartement").toString());
        this.idCommune=0;
        if(session.getAttribute("idCommune")!=null)
            this.idCommune=Integer.parseInt(session.getAttribute("idCommune").toString());
        this.page=0;
        if(session.getAttribute("page")!=null)
            this.page=Integer.parseInt(session.getAttribute("page").toString());
    }

    public void getPosts(HttpServletRequest request) {
        HttpSession session=request.getSession(true);
        this.page=0;
        session.setAttribute("page", 0);
        this.motsCles=request.getParameter("motsCles");
        this.motsCles=Objet.codeHTML(this.motsCles);
        if(request.getParameter("type1")!=null) {
            this.type1=Integer.parseInt(request.getParameter("type1"));
        }
        if(request.getParameter("type2")!=null) {
            this.type2=Integer.parseInt(request.getParameter("type2"));
        }
        if(request.getParameter("type3")!=null) {
            this.type3=Integer.parseInt(request.getParameter("type3"));
        }
        this.idRegion=request.getParameter("idRegion");
        this.idRegion=Objet.codeHTML(this.idRegion);
        this.idDepartement=request.getParameter("idDepartement");
        this.idDepartement=Objet.codeHTML(this.idDepartement);
        this.idCommune=Integer.parseInt(request.getParameter("idCommune"));
    }

    public void verifPosts(HttpServletRequest request) {
        HttpSession session=request.getSession(true);
        if(this.type1!=0)
            session.setAttribute("type1", this.type1);
        else
            session.setAttribute("type1", null);
        if(this.type2!=0)
            session.setAttribute("type2", this.type2);
        else
            session.setAttribute("type2", null);
        if(this.type3!=0)
            session.setAttribute("type3", this.type3);
        else
            session.setAttribute("type3", null);
        if(!this.idRegion.equals("0"))
            session.setAttribute("idRegion", this.idRegion);
        else
            session.setAttribute("idRegion", null);
        if(!this.idDepartement.equals("0"))
            session.setAttribute("idDepartement", this.idDepartement);
        else
            session.setAttribute("idDepartement", null);
        if(this.idCommune!=0)
            session.setAttribute("idCommune", this.idCommune);
        else
            session.setAttribute("idCommune", null);
    }

    public void reset(HttpServletRequest request) {
        HttpSession session=request.getSession(true);
        session.setAttribute("motsCles", null);
        session.setAttribute("type1", null);
        session.setAttribute("type2", null);
        session.setAttribute("type3", null);
        session.setAttribute("idRegion", null);
        session.setAttribute("idDepartement", null);
        session.setAttribute("idCommune", null);
        session.setAttribute("page", null);
    }
    public void initCondition() {
        this.condition=" WHERE t1.etat='1'";
        if(this.motsCles.length()>0) {
            String motsCles2=this.motsCles;
            for(String article:Datas.arrayArticles) {
                motsCles2=motsCles2.replaceAll(article, " ");
            }
            String arrayMotsCles[]=motsCles2.split(" ");
            for(String mot:arrayMotsCles) {
                if(mot.length()>0)
                    this.condition+=" OR (t1.titre LIKE '%"+mot+"%' OR t1.titre_contre LIKE '%"+mot+"%' OR t1.description LIKE '%"+mot+"%' OR t1.description_contre LIKE '%"+mot+"%')";
            }
        }
        if(this.type1!=0)
            this.condition+=" AND t1.type1='"+this.type1+"'";
        if(this.type2!=0)
            this.condition+=" AND t1.type2='"+this.type2+"'";
        if(this.type3!=0)
            this.condition+=" AND t1.type3='"+this.type3+"'";
        if(!this.idRegion.equals("0"))
            this.condition+=" AND t2.id_region='"+this.idRegion+"'";
        if(!this.idDepartement.equals("0"))
            this.condition+=" AND t2.id_departement='"+this.idDepartement+"'";
        if(this.idCommune!=0)
            this.condition+=" AND t2.id_commune='"+this.idCommune+"'";
    }

    public void getGets(HttpServletRequest request) {
        HttpSession session=request.getSession(true);
        if(request.getParameter("type1")!=null) {
            this.type1=Integer.parseInt(request.getParameter("type1"));
            if(this.type1!=0)
                session.setAttribute("type1", this.type1);
            else
                session.setAttribute("type1", null);
            this.page=0;
            session.setAttribute("page", 0);
        }
        if(request.getParameter("type2")!=null) {
            this.type2=Integer.parseInt(request.getParameter("type2"));
            if(this.type2!=0)
                session.setAttribute("type2", this.type2);
            else
                session.setAttribute("type2", null);
            this.page=0;
            session.setAttribute("page", 0);
        }
        if(request.getParameter("type3")!=null) {
            this.type3=Integer.parseInt(request.getParameter("type3"));
            if(this.type3!=0)
                session.setAttribute("type3", this.type3);
            else
                session.setAttribute("type3", null);
            this.page=0;
            session.setAttribute("page", 0);
        }
        if(request.getParameter("idRegion")!=null) {
            this.idRegion=request.getParameter("idRegion");
            this.idRegion=Objet.codeHTML(this.idRegion);
            if(!this.idRegion.equals("0"))
                session.setAttribute("idRegion", this.idRegion);
            else
                session.setAttribute("idRegion", null);
            this.page=0;
            session.setAttribute("page", 0);
        }
        if(request.getParameter("idDepartement")!=null) {
            this.idDepartement=request.getParameter("idDepartement");
            this.idDepartement=Objet.codeHTML(this.idDepartement);
            if(!this.idDepartement.equals("0"))
                session.setAttribute("idDepartement", this.idDepartement);
            else
                session.setAttribute("idDepartement", null);
            this.page=0;
            session.setAttribute("page", 0);
        }
        if(request.getParameter("idCommune")!=null) {
            this.idCommune=Integer.parseInt(request.getParameter("idCommune"));
            if(this.idCommune!=0)
                session.setAttribute("idCommune", this.idCommune);
            else
                session.setAttribute("idCommune", null);
            this.page=0;
            session.setAttribute("page", 0);
        }
        if(request.getParameter("page")!=null) {
            this.page=Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", this.getPage());
        }
    }

    public void initTags(HttpServletRequest request) {
        try {
            HttpSession session=request.getSession(true);
            Objet.getConnection();
            if (request.getParameter("type2") != null &&this.type2!=0) {
                switch (this.type2) {
                    case 1:
                        this.setTagTitle("Potagers solidaires - Troc et échanges");
                        this.setTagDescription("Le jardinage est plus sympa avec potagers solidaires - Troc et échanges.");
                        break;
                    case 2:
                        this.setTagTitle("Potagers solidaires - annonces de dons");
                        this.setTagDescription("Potagers solidaires, toutes les annonces de dons, jardinez malin !");
                        break;
                }
            }
            if (request.getParameter("type3") != null&&this.type3!=0) {
                switch (this.type3) {
                    case 1:
                        this.setTagTitle("Potagers solidaires, toutes les graines");
                        this.setTagDescription("Trouvez vos graines sur potagers solidaires.");
                        break;
                    case 2:
                        this.setTagTitle("Potagers solidaires - Tous les plants");
                        this.setTagDescription("Trouvez vos plants sur potagers solidaires.");
                        break;
                    case 3:
                        this.setTagTitle("Potagers solidaires - Fruits et légumes");
                        this.setTagDescription("Trouvez vos fruits et légumes sur potagers solidaires.");
                        break;
                }
            }
            if(request.getParameter("idRegion")!=null&&!this.idRegion.equals("0")) {
                String query="SELECT region FROM table_regions WHERE id_region=? LIMIT 0,1";
                PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                prepare.setString(1, this.idRegion);
                ResultSet result=prepare.executeQuery();
                boolean flag=result.next();
                if(flag) {
                    String region=result.getString("region");
                    this.setTagTitle("Potagers solidaires - région " + region);
                    this.setTagDescription("Potagers solidaires jardinez malin en région " + region + ".");
                }
                result.close();
                prepare.close();
            } else if(request.getParameter("idDepartement")!=null&!this.idDepartement.equals("0")) {
                String query="SELECT id_region,departement FROM table_departements WHERE id_departement=? LIMIT 0,1";
                PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                prepare.setString(1, this.idDepartement);
                ResultSet result=prepare.executeQuery();
                boolean flag=result.next();
                if(flag) {
                    this.idRegion=result.getString("id_region");
                    session.setAttribute("idRegion", this.idRegion);
                    String departement=result.getString("departement");
                    this.tagTitle="Potagers Solidaires - "+this.idDepartement+" - "+departement;
                    this.tagDescription="Potagers Solidaires - jardinage - "+this.idDepartement+" - "+departement+".";
                }
                result.close();
                prepare.close();
            } else if(request.getParameter("idCommune")!=null&&this.idCommune!=0) {
                String query="SELECT id_region,id_departement,commune,code_postal FROM table_communes WHERE id=? LIMIT 0,1";
                PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                prepare.setInt(1, this.idCommune);
                ResultSet result=prepare.executeQuery();
                boolean flag=result.next();
                if(flag) {
                    this.idRegion=result.getString("id_region");
                    this.idDepartement=result.getString("id_departement");
                    session.setAttribute("idRegion", this.idRegion);
                    session.setAttribute("idDepartement", this.idDepartement);
                    String commune=result.getString("commune");
                    String codePostal=result.getString("code_postal");
                    this.tagTitle="Potagers Solidaires - "+codePostal+" - "+commune;
                    this.tagDescription="Postagers solidaires - Jardinez malin - "+codePostal+" - "+commune+".";
                }
                result.close();
                prepare.close();
            }
            Objet.closeConnection();
        } catch (NamingException ex) {
            Logger.getLogger(RechercheAnnonces.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(RechercheAnnonces.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * @return the motsCles
     */
    public String getMotsCles() {
        return motsCles;
    }

    /**
     * @return the condition
     */
    public String getCondition() {
        return condition;
    }

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
     * @return the idRegion
     */
    public String getIdRegion() {
        return idRegion;
    }

    /**
     * @return the idDepartement
     */
    public String getIdDepartement() {
        return idDepartement;
    }

    /**
     * @return the idCommune
     */
    public int getIdCommune() {
        return idCommune;
    }

    /**
     * @return the page
     */
    public int getPage() {
        return page;
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
     * @param tagTitle the tagTitle to set
     */
    public void setTagTitle(String tagTitle) {
        this.tagTitle = tagTitle;
    }

    /**
     * @param tagDescription the tagDescription to set
     */
    public void setTagDescription(String tagDescription) {
        this.tagDescription = tagDescription;
    }

}
