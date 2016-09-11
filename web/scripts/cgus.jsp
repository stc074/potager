<%@page import="java.util.Calendar"%>
<%@page import="classes.CGU"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Déposer une annonce</title>
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
<link rel="icon" type="image/png" href="./GFXs/favicon.png" />
<link href="./CSS/style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./scripts/scripts.js"></script>
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
           <h1>CONDITION GÉNÉRALES D'UTILISATION</h1>
           <%
           try {
               if(request.getAttribute("cgu")!=null) {
                   CGU cgu=(CGU)request.getAttribute("cgu");
                   Calendar cal=Calendar.getInstance();
                   cal.setTimeInMillis(cgu.getTimestamp());
                   %>
                   <div class="info">Dernières modification le, <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                   <br/>
                   <%= cgu.getContenu() %>
                   <%
                   }
               } catch(Exception ex) { %>
               <br/>
               <div class="erreur">
                   <div><%= ex.getMessage() %></div>
               </div>
               <br/>
               <% } %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
