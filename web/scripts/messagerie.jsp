<%@page import="classes.Messagerie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Messagerie</title>
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
           <h1>Potagers solidaires :: Messagerie</h1>
           <%
           if(request.getAttribute("info")!=null) {
               int info=Integer.parseInt(request.getAttribute("info").toString());
               switch(info) {
                   case 1: %>
                   <br/>
                   <div class="info">Vous devez être connecté pour pouvoir accéder à votre messagerie.</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(request.getAttribute("messagerie")!=null) {
                   try {
                       Messagerie messagerie=(Messagerie)request.getAttribute("messagerie");
                       %>
                   <br/>
                   <fieldset>
                       <br/>
                       <div>
                           <a href="./messages-recus.html" title="MESSAGES REÇUS" rel="nofollow">Messages reçus</a>
                           <%
                           if(messagerie.getNbMsgRecusNonLus()>0) { %>
                           <span>[<span class="clign"><%= messagerie.getNbMsgRecusNonLus() %></span>]&nbsp;Non lu(s).</span>
                           <% } %>
                       </div>
                       <br/>
                   </fieldset>
                   <br/>
                   <fieldset>
                       <br/>
                       <div>
                           <a href="./messages-envoyes.html" title="MESSAGES ENVOYÉS" rel="nofollow">Messages envoyés</a>
                           <%
                           if(messagerie.getNbMsgEnvoyesNonLus()>0) { %>
                           <span>[<span class="clign"><%= messagerie.getNbMsgEnvoyesNonLus() %></span>]&nbsp;Non lu(s).</span>
                           <% } %>
                       </div>
                       <br/>
                   </fieldset>
                       <%
                   } catch(Exception ex) { %>
                   <br/>
                   <div class="erreur">
                       <div><%= ex.getMessage() %></div>
                   </div><%
                   }
               }
           %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
