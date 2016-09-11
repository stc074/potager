<%@page import="java.util.Calendar"%>
<%@page import="classes.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Message reçu</title>
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
                   case 2: %>
                   <br/>
                   <div class="info">Message inconnu !</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(request.getAttribute("message")!=null) {
                   try {
                       Message message=(Message)request.getAttribute("message");
                       Calendar cal=Calendar.getInstance();
                       %>
                       <h1>Annonce : <%= message.getTitreAnnonce() %></h1>
                       <%
                       if(message.getIdPrec()!=0) {
                       cal.setTimeInMillis(message.getTimestampPrec());
                        %>
                        <div class="info">Vous aviez écris à <%= message.getPseudoExpediteur() %>, le <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                        <h2><%= message.getTitrePrec() %></h2>
                        <%= message.getContenuPrec() %>
                        <br/>
                        <%
                        cal.setTimeInMillis(message.getTimestamp());
                        %>
                        <div class="info"><%= message.getPseudoExpediteur() %> vous a répondu, le <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                        <%
                        } else if(message.getIdPrec()==0) {
                            cal.setTimeInMillis(message.getTimestamp());
                            %>
                            <div class="info"><%= message.getPseudoExpediteur() %> vous a écris, le  <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                            <% } %>
                            <h2><%= message.getTitre() %></h2>
                            <%= message.getContenu() %>
                            <br/>
                            <%
                            if(message.getTest()==0) { %>
                            <div class="info">Pour répondre à <%= message.getPseudoExpediteur() %>, utilisez le formulaire ci-dessous :</div>
                            <br/>
                            <fieldset>
                                <legend>Répondre à <%= message.getPseudoExpediteur() %> :</legend>
                            <div id="form">
                                <%
                                if(message.getErrorMsg().length()>0) { %>
                                <div class="erreur">
                                    <div>Erreur(s) :</div>
                                    <br/>
                                    <div><%= message.getErrorMsg() %></div>
                                </div><% } %>
                                <form action="./message-recu.html#form" method="POST">
                                    <input type="hidden" name="idMessage" value="<%= message.getId()%>" />
                                    <div>Titre de votre message :</div>
                                    <input type="text" name="titreMsg" value="<%= message.getTitreMsg()%>" size="30" maxlength="40" />
                                    <div>Contenu de votre message :</div>
                                    <textarea name="contenuMsg" id="contenuMsg" rows="4" cols="20"><%= message.getContenuMsg()%></textarea>
                                 <br/>
                                <br/>
                                <div>
                                    <div class="captcha"></div>
                                    <span>&rarr;Copier le code SVP &rarr;</span>
                                    <input type="text" name="captcha" value="" size="5" maxlength="5" />
                                    <div class="clearBoth"></div>
                                </div>
                               <br/>
                               <br/>
                               <input type="submit" value="Valider" name="kermit" />
                               </form>
                            </div>
                            </fieldset>
<script type="text/javascript">
	CKEDITOR.replace( 'contenuMsg' );
</script>
                            <%
                            } else if(message.getTest()==1) { %>
                            <br/>
                            <div class="info">Message envoyé a <%= message.getPseudoExpediteur() %>.</div>
                            <br/>
                            <%
                            message.blank();
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
