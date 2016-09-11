<%@page import="classes.Img"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="classes.Objet"%>
<%@page import="classes.AnnoncePhotos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Éditer une annonce</title>
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
           <h1>Potagers solidaires :: Éditer une annonce (Photos)</h1>
           <%
           if(request.getAttribute("info")!=null) {
               int info=Integer.parseInt(request.getAttribute("info").toString());
               switch(info) {
                   case 1: %>
                   <br/>
                   <div class="info">Vous devez être connecté pour pouvoir déposer une annonce.</div>
                   <br/>
                   <div><a href="./deposer-une-annonce-1.html" title="SE CONNECTER" rel="nofollow">SE CONNECTER</a></div>
                   <br/>
                   <%
                   break;
                   case 2: %>
                   <br/>
                   <div class="info">Erreur annonce inconnu.</div>
                   <br/>
                   <%
                   }
               } else if(request.getAttribute("photos")!=null) {
                   AnnoncePhotos photos=(AnnoncePhotos)request.getAttribute("photos");
                   %>
                   <div class="info">Photos déjà enregistrées :</div>
                   <%
                   long idAnnonce=photos.getId();
                   long idMembre=photos.getMembre().getId();
                   int nbPhotos=0;
                   Objet.getConnection();
                   String query="SELECT extension1,extension2,extension3,extension4,extension5 FROM table_annonces WHERE id=? AND id_membre=? LIMIT 0,1";
                   String extensions[]=new String[5];
                   PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                   prepare.setLong(1, idAnnonce);
                   prepare.setLong(2, idMembre);
                   ResultSet result=prepare.executeQuery();
                   boolean flag=result.next();
                   if(flag) {
                       extensions[0]=result.getString("extension1");
                       extensions[1]=result.getString("extension2");
                       extensions[2]=result.getString("extension3");
                       extensions[3]=result.getString("extension4");
                       extensions[4]=result.getString("extension5");
                       %>
                       <table border="0" cellspacing="5" cellpadding="5" align="center">
                          <tbody>
                               <tr>
                                   <%
                                   Img img=new Img();
                       for(int i=1;i<=5;i++) {
                           String extension=extensions[i-1];
                           if(extension.length()>0) {
                               String filenameMini2=Datas.DIR+"photos/mini2_"+i+"_"+idAnnonce+extension;
                               File fileMini2=new File(filenameMini2);
                               if(fileMini2.exists()) {
                                   nbPhotos++;
                               img.getSize(fileMini2);
                               int largeur=img.getWidth();
                               int hauteur=img.getHeight();
                               %>
                               <td>
                               <img src="./mini2-<%= idAnnonce%>-<%= i%><%= extension %>" width="<%= largeur%>" height="<%= hauteur%>" alt="Miniature #<%= i%>"/>
                               </td>
                               <%
                               }
                               }
                           }
                            %>
                               </tr>
                           </tbody>
                       </table>
                               <%
                                  }
                   if(nbPhotos==0) { %>
                   <br/>
                   <div class="info">Aucune photo enregistrée.</div>
                   <br/>
                   <%
                   }
                                   %>
                   <br/>
                   <div class="info">Téléchargez vos photos grâce au formulaire ci-dessous :</div>
                   <p>Note : Dans le cas de gros fichiers , nous vous conseillons de ne télécharger les photos que les unes après les autres afin d'éviter les problèmes de mémoire.Vous n'êtes d'ailleurs pas obligé de télécharger 5 photos.</p>
                   <fieldset>
                       <legend>Upload de photos</legend>
                   <div id="form">
                       <%
                       if(photos.getErrorMsg().length()>0) { %>
                       <div class="erreur">
                           <div>Erreur(s) :</div>
                           <br/>
                           <div><%= photos.getErrorMsg() %></div>
                       </div><% } %>
                       <form action="./edit-annonce-photos.html#form" method="POST" enctype="multipart/form-data">
                           <div>1° photo :</div>
                           <input type="file" name="1" value="" />
                           <div>2° photo :</div>
                           <input type="file" name="2" value="" />
                           <div>3° photo :</div>
                           <input type="file" name="3" value="" />
                           <div>4° photo :</div>
                           <input type="file" name="4" value="" />
                           <div>5° photo :</div>
                           <input type="file" name="5" value="" />
                           <br/>
                           <input type="submit" value="Valider" name="kermit" />
                       </form>
                   </div>
                   </fieldset>
                   <%
                   }
           %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
