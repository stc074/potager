<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="classes.Objet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Mes annonces</title>
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
           <h1>Potagers solidaires :: Mes annonces</h1>
           <%
           if(request.getAttribute("info")!=null) {
               int info=Integer.parseInt(request.getAttribute("info").toString());
               switch(info) {
                   case 1: %>
                   <br/>
                   <div class="info">Vous devez être connecté pour pouvoir accéder à vos annonces.</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(request.getAttribute("idMembre")!=null) {
                   long idMembre=Long.parseLong(request.getAttribute("idMembre").toString());
                   try {
                       Objet.getConnection();
                       String query="SELECT id,titre,timestamp FROM table_annonces WHERE id_membre=? ORDER BY timestamp DESC";
                       PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                       prepare.setLong(1, idMembre);
                       ResultSet result=prepare.executeQuery();
                       int i=0;
                       Calendar cal=Calendar.getInstance();
                       while(result.next()) {
                           i++;
                           long idAnnonce=result.getLong("id");
                           String titre=result.getString("titre");
                           long timestamp=result.getLong("timestamp");
                           cal.setTimeInMillis(timestamp);
                           %>
                           <fieldset>
                           <div>
                               <a href="./edit-annonce-<%= idAnnonce %>.html" title="<%= titre %>" rel="bofollow"><%= titre %></a>
                               <span>&nbsp;&rarr; Annonce créée le <%= cal.get(cal.DATE) %>/<%= cal.get(cal.MONTH)+1 %>/<%= cal.get(cal.YEAR) %>.&nbsp;</span>
                               <a href="./efface-annonce-<%= idAnnonce %>.html" title="ÉFFACER CETTE ANNONCE" rel="nofollow">&rarr;ÉFFACER</a>
                           </div>
                           </fieldset>
                           <br/>
                               <%
                               }
                       result.close();
                       prepare.close();
                       Objet.closeConnection();
                       if(i==0) { %>
                       <br/>
                       <div class="info">Aucune annonce enregistrée.</div>
                       <br/>
                       <%
                       }
                   } catch (Exception ex) { %>
                   <br/>
                   <div class="erreur">ERREUR INTERNE : <%= ex.getMessage() %></div>
                   <br/>
                   <%
                   }
                   }

           %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
