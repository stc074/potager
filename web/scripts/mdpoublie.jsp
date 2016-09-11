<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Mot de passe oublié</title>
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
           <h1>Potagers solidaires :: Mot de passe oublié</h1>
           <%
           if(request.getAttribute("membre")!=null) {
           Membre membre=(Membre)request.getAttribute("membre");
           if(membre.getTest()==0) {
    %>
           <p>Vous avez oublié votre mot de passe ? ce n'est pas grave nous allons vous en envoyer un autre.</p>
           <div id="form">
               <%
               if(membre.getErrorMsg().length()>0) { %>
               <div class="erreur">
                   <div>Erreur(s) :</div>
                   <br/>
                   <div><%= membre.getErrorMsg() %></div>
               </div><% } %>
               <form action="./mdp-oublie.html" method="POST">
                   <div>Adresse EMAIL de votre compte :</div>
                   <input type="text" name="email" value="<%= membre.getEmail()%>" size="40" maxlength="200" />
                   <br/>
                   <input type="submit" value="Valider" name="kermit" />
               </form>
           </div>
                   <%
                   } else if(membre.getTest()==1) { %>
                   <br/>
                   <div class="info">Un nouveau mot de passe vous a été envoyé.</div>
                   <br/>
                   <%
                   membre.blank();
                   }
                   }
           %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
