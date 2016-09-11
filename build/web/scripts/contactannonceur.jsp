<%@page import="java.util.Calendar"%>
<%@page import="classes.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Contact</title>
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
                   <div class="info">Vous devez être connecté pour pouvoir envoyer un message.</div>
                   <br/>
                   <div><a href="./inscription.html" rel="nofollow" title="S'INSCRIRE">S'INSCRIRE</a></div>
                   <br/>
                   <%
                   break;
                   case 2: %>
                   <br/>
                   <div class="info">Annonce inconnue</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(request.getAttribute("message")!=null) {
                   try {
                        Message message=(Message)request.getAttribute("message");
                        Calendar cal=Calendar.getInstance();
                        cal.setTimeInMillis(message.getTimestampAnnonce());
                        if(message.getType2()==1) { %>
                        <h1><%= message.getTitreAnnonce() %> contre <%= message.getTitreContreAnnonce() %></h1>
                        <%
                        } else { %>
                        <h1><%= message.getTitreAnnonce() %></h1>
                        <%
                        }
                        %>
                        <div class="info">Annonce mise en ligne par <%= message.getPseudoDestinataire() %> le, <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                        <br/>
                        <%if(message.getTest()==0) { %>
                        <div class="info">Pour écrire à <%= message.getPseudoDestinataire() %>, utilisez le formulaire ci-dessous :</div>
                        <br/>
                        <fieldset>
                            <legend>Formulaire de contact</legend>
                        <div id="form">
                            <%
                            if(request.getParameter("kermit")!=null&&message.getErrorMsg().length()>0) { %>
                            <div class="erreur">
                                <div>Erreur(s) :</div>
                                <br/>
                                <div><%= message.getErrorMsg() %></div>
                            </div><% } %>
                            <form action="./contact-annonceur.html#form" method="POST">
                                <input type="hidden" name="idAnnonce" value="<%= message.getIdAnnonce()%>" />
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
                        <div class="info">Message envoyé ! Nous avons prévenu <%= message.getPseudoDestinataire() %> de votre message.</div>
                        <br/>
                        <%
                        }
                   } catch(Exception ex) { %>
                   <div class="erreur">
                       <br/>
                       <div><%= ex.getMessage() %></div>
                   </div><% }
                   }
               %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
