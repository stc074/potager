<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Supprimer mon compte</title>
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
<script type="text/javascript" src="./datas/ckeditor/ckeditor.js"></script>
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
           <h1>Supprimer mon compte</h1>
           <%
           if(request.getAttribute("info")!=null) {
               int info=Integer.parseInt(request.getAttribute("info").toString());
               switch(info) {
                   case 1: %>
                   <br/>
                   <div class="info">Vous devez être connecté pour pouvoir supprimer votre compte.</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(request.getAttribute("membre")!=null) {
                   try {
                       Membre membre=(Membre)request.getAttribute("membre");
                       if(membre.getTest()==0) { %>
                       <br/>
                       <p>Si vous supprimez votre compte toutes les données qui lui sont associées seront éffacées (Annonces & messages).</p>
                       <br/>
                       <div id="form">
                           <form action="./supprimer-compte.html#form" method="POST">
                           <div>En cliquant sur le bouton, je supprime mon compte.</div>
                           <br/>
                           <input type="submit" value="Supprimer mon compte" name="kermit" />
                           </form>
                       </div>
                       <%
                       } else if(membre.getTest()==1) { %>
                       <br/>
                       <div class="info">Compte supprimé !</div>
                       <br/>
                       <%
                       }
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
