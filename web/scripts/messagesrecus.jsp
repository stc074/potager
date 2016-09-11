<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="classes.Objet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Messages reçus</title>
<meta name="generator" content="NETBEANS 6.9"/>
<meta name="author" content=""/>
<meta name="date" content=""/>
<meta name="copyright" content=""/>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<meta name="ROBOTS" content="NOINDEX, NOFOLLOW"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8"/>
<meta http-equiv="content-style-type" content="text/css"/>
<link href="./CSS/style.css" type="text/css" rel="stylesheet" />
<link rel="icon" type="image/png" href="./GFXs/favicon.png" />
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
           <h1>Potagers solidaires :: Messages reçus</h1>
           <%
           if(request.getAttribute("info")!=null) {
               int info=Integer.parseInt(request.getAttribute("info").toString());
               switch(info) {
                   case 1: %>
                   <br/>
                   <div class="info">Vous devez être connecté pour pouvoir consulter vos messages.</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(request.getAttribute("idMembre")!=null) {
                   try {
                       Long idMembre=Long.parseLong(request.getAttribute("idMembre").toString());
                       Objet.getConnection();
                       String query="SELECT t1.id,t1.titre,t1.timestamp,t1.etat,t2.pseudo,t3.titre AS titreAnnonce FROM table_messages AS t1,table_membres AS t2,table_annonces AS t3 WHERE t1.id_membre_destinataire=? AND t2.id=t1.id_membre_expediteur AND t3.id=t1.id_annonce ORDER BY t1.timestamp DESC";
                       PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                       prepare.setLong(1, idMembre);
                       ResultSet result=prepare.executeQuery();
                       int nbMsg=0;
                       %>
                       <fieldset>
                           <br/>
                           <%
                       while(result.next()) {
                           nbMsg++;
                           long idMessage=result.getLong("id");
                           String titre=result.getString("titre");
                           long timestamp=result.getLong("timestamp");
                           int etat=result.getInt("etat");
                           String pseudo=result.getString("pseudo");
                           String titreAnnonce=result.getString("titreAnnonce");
                           Calendar cal=Calendar.getInstance();
                           cal.setTimeInMillis(timestamp);
                           %>
                           <div>
                               <a href="./message-recu-<%= idMessage %>.html" title="<%= titre %>" rel="nofollow"><%= titre %></a>
                               <%
                               if(etat==0) { %>
                               <span>[<span class="clign">Non lu</span>]</span><% } %>
                               <span>&nbsp;Message envoyé par <%= pseudo %> le, <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</span>
                               <span>&nbsp;[ Annonce : <%= titreAnnonce %> ]</span>
                               <a href="./efface-message-1-<%= idMessage %>.html" title="ÉFFACER CE MESSAGE" rel="nofollow">&rArr;Éffacer</a>
                           </div>
                           <br/>
                           <%
                           }
                       result.close();
                       prepare.close();
                       if(nbMsg==0) { %>
                       <div class="info">Aucun message reçu.</div>
                       <br/>
                       <%
                       }
                       %>
                       </fieldset>
                       <%
                       Objet.closeConnection();
                       } catch(Exception ex) { %>
                       <br/>
                       <div class="erreur">
                           <div><%= ex.getMessage() %></div>
                       </div><% }
                       }
               %>
        </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
