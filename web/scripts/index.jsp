<%@page import="java.io.File"%>
<%@page import="classes.Img"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Le jardinage est plus sympa avec Potagers Solidaires !</title>
<meta name="generator" content="NETBEANS 6.9"/>
<meta name="author" content=""/>
<meta name="date" content=""/>
<meta name="copyright" content=""/>
<meta name="keywords" content=""/>
<meta name="description" content="Potagers Solidaires, le jardinage sympa, echangez|Donnez des graines|Plants|Fruits et légumes." />
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8"/>
<meta http-equiv="content-style-type" content="text/css"/>
<link rel="icon" type="image/png" href="./GFXs/favicon.png" />
<link href="./CSS/style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="https://apis.google.com/js/plusone.js">
  {lang: 'fr'}
</script>
</head>
    <body>
        <%@include file="./connexion.jsp" %>
        <%@include file="./haut.jsp" %>
       <div class="contenu">
<div>
<a name="fb_share" type="button_count" share_url="<%= Datas.URLROOT %>">Cliquez pour partager !!!</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
</div>
           <br/>
           <g:plusone></g:plusone>
           <br/>
           <h1>Potagers solidaires - Jardinage sympa !</h1>
           <p>Le <strong>jardinage</strong> est un de vos passe-temps, vous possédez un <strong>potager</strong>?<br/>Utilisez ce site pour échanger votre production, trouver ou donner des graines et plants !</p>
           <h2>Dernières annonces enregistrées</h2>
           <%
           try {
               Objet.getConnection();
               String query="SELECT t1.id,t1.type2,t1.titre,t1.titre_contre,t1.extension1,t1.extension2,t1.extension3,t1.extension4,t1.extension5,t1.timestamp,t2.pseudo,t3.region,t4.departement,t5.commune,t5.code_postal FROM table_annonces AS t1,table_membres AS t2,table_regions AS t3,table_departements AS t4,table_communes AS t5 WHERE t2.id=t1.id_membre AND t3.id_region=t2.id_region AND t4.id_departement=t2.id_departement AND t5.id=t2.id_commune ORDER BY t1.timestamp DESC LIMIT 0,5";
               Statement state=Objet.getConn().createStatement();
               ResultSet result=state.executeQuery(query);
                         Calendar cal=Calendar.getInstance();
                         int nbAnnonces=0;
                         while(result.next()) {
                             nbAnnonces++;
                             long idAnnonce=result.getLong("id");
                             int type2=result.getInt("type2");
                             String titre=result.getString("titre");
                             String titreContre=result.getString("titre_contre");
                             String extensions[]=new String[5];
                             extensions[0]=result.getString("extension1");
                             extensions[1]=result.getString("extension2");
                             extensions[2]=result.getString("extension3");
                             extensions[3]=result.getString("extension4");
                             extensions[4]=result.getString("extension5");
                             long timestamp=result.getLong("timestamp");
                             String pseudo=result.getString("pseudo");
                             String region=result.getString("region");
                             String departement=result.getString("departement");
                             String commune=result.getString("commune");
                             String codePostal=result.getString("code_postal");
                             String url="";
                             if(type2==1)
                                 url="./annonce-"+idAnnonce+"-"+Objet.encodeTitre(titre)+"-contre-"+Objet.encodeTitre(titreContre)+".html";
                             else
                                 url="./annonce-"+idAnnonce+"-"+Objet.encodeTitre(titre)+".html";
                             cal.setTimeInMillis(timestamp);
                             %>
                             <div class="listeAnnonce">
                                 <div class="listeAnnonceGauche">
                                     <a href="<%= url %>#annonce" title="<%= titre %>">
                                 <%
                             int nbPhotos=0;
                             Img img=new Img();
                             for(int i=1;i<=5;i++) {
                                 String extension=extensions[i-1];
                                 if(extension.length()>0&&nbPhotos==0) {
                                     String filenameMini1=Datas.DIR+"photos/mini1_"+i+"_"+idAnnonce+extension;
                                     //out.println(filenameMini1);
                                     File fileMini1=new File(filenameMini1);
                                     if(fileMini1.exists()) {
                                         nbPhotos++;
                                         img.getSize(fileMini1);
                                         int largeur=img.getWidth();
                                         int hauteur=img.getHeight();
                                         %>
                                         <img src="./mini1-<%= idAnnonce%>-<%= i%><%= extension %>" width="<%= largeur%>" height="<%= hauteur%>" alt="Miniature"/>
                                         <%
                                         }
                                     }
                                 }
                             if(nbPhotos==0) { %>
                             <img src="./GFXs/miniature.png" width="125" height="125" alt="miniature"/>
                             <%
                             }
                             %>
                                     </a>
                                 </div>
                                 <div class="listeAnnonceDroite">
                                     <div><a href="<%= url %>#annonce" title="<%= titre %>"><%= titre %><% if(type2==1) { %>&nbsp;contre&nbsp;<%= titreContre %><% } %></a></div>
                                     <div>Annonce mise en ligne par <%= pseudo %>, le <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                                     <br/>
                                     <div>Localisation <%= codePostal %>-<%= commune %>&nbsp;[<%= departement %>|<%= region %>]</div>
                                 <div class="clearBoth"></div>
                                 </div>
                             </div>
                                 <br/>
                                 <%
                             }
                         result.close();
                         state.close();
                         Objet.closeConnection();
                         if(nbAnnonces==0) { %>
                         <br/>
                         <div class="info">Aucune annonce pour le moment.</div>
                         <br/>
                         <%
                         }
               } catch(Exception ex) { %>
               <br/>
               <div class="erreur">
                   <div><%= ex.getMessage() %></div>
               </div><% } %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
