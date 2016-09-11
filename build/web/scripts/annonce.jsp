<%@page import="classes.Img"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@page import="classes.Annonce"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
Annonce annonce=null;
String tagTitle="Potagers Solidaires - Jardinez malin !";
String tagDescription="Potagers solidaires, le jardinage malin et sympa.";
if(request.getAttribute("annonce")!=null) {
    annonce=(Annonce)request.getAttribute("annonce");
    tagTitle=annonce.getTagTitle();
    tagDescription=annonce.getTagDescription();
    }
%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><%= tagTitle %></title>
<meta name="generator" content="NETBEANS 6.9"/>
<meta name="author" content=""/>
<meta name="date" content=""/>
<meta name="copyright" content=""/>
<meta name="keywords" content=""/>
<meta name="description" content="<%= tagDescription %>"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8"/>
<meta http-equiv="content-style-type" content="text/css"/>
<link rel="icon" type="image/png" href="./GFXs/favicon.png" />
<link href="./CSS/style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="https://apis.google.com/js/plusone.js">
  {lang: 'fr'}
</script>
<script src="./js-global/FancyZoom.js" type="text/javascript"></script>
<script src="./js-global/FancyZoomHTML.js" type="text/javascript"></script>
<script type="text/javascript" src="./scripts/scripts.js"></script>
</head>
    <body onload="setupZoom()">
        <%@include file="./connexion.jsp" %>
        <%@include file="./haut.jsp" %>
       <div class="contenu">
           <br/>
           <g:plusone></g:plusone>
           <br/>
           <%
           if(request.getAttribute("info")!=null) {
               int info=Integer.parseInt(request.getAttribute("info").toString());
               switch(info) {
                   case 1: %>
                   <br/>
                   <div class="info">Annonce inconnue.</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(annonce!=null) {
                   %>
                   <div id="annonce">
                       <div><a href="./annonces2.html" title="RETOUR À LA LISTE">Retour à la liste de résultat</a></div>
                       <br/>
                       <div><a href="#" title="SIGNALER UN ABUS" onclick="javascript:signalerAbus(<%= annonce.getId() %>);">Signaler un abus</a></div>
                       <br/>
                       <div>
                        <a name="fb_share" type="button_count" share_url="<% out.print(Datas.URLROOT+annonce.getUri()); %>">Cliquez pour partager !!!</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
                        </div>
                       <%
                   Calendar cal=Calendar.getInstance();
                   cal.setTimeInMillis(annonce.getTimestamp());
                   if(annonce.getType2()==1) { %>
                   <h1><%= annonce.getTitre() %> contre <%= annonce.getTitreContre() %></h1>
                   <%
                   } else { %>
           <h1>Potagers solidaires :: <%= annonce.getTitre() %></h1>
           <%
           }
                   %>
                       <div class="cadre">
                           <div>
                           <%
                           switch(annonce.getType1()) {
                               case 1: %>
                               <span><%= annonce.getPseudo() %> propose :</span>
                               <%
                               break;
                               case 2: %>
                               <span><%= annonce.getPseudo() %> recherche :</span>
                               <%
                               break;
                               }
                           switch(annonce.getType2()) {
                               case 1: %>
                               <span>&nbsp;un échange</span>
                               <%
                               break;
                               case 2: %>
                               <span>&nbsp;un don</span>
                               <%
                               break;
                               }
                           switch(annonce.getType3()) {
                               case 1: %>
                               <span>&nbsp;de graines.</span>
                               <%
                               break;
                               case 2: %>
                               <span>&nbsp;de plants.</span>
                               <%
                               break;
                               case 3: %>
                               <span>&nbsp;de fruits/légumes.</span>
                               <%
                               break;
                               }
                           %>
                                   </div>
                           <div>Annonce mise en ligne, le <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                           <div>Localisation : <%= annonce.getCodePostal() %>-<%= annonce.getCommune() %>&nbsp;[<%= annonce.getDepartement() %>|<%= annonce.getRegion() %>].</div>
                       </div>
                       <h2><%= annonce.getTitre() %></h2>
                       <div class="cadre"><%= annonce.getDescription() %></div>
                       <%
                       if(annonce.getType2()==1) { %>
                       <h2>Contre</h2>
                       <div class="cadre"><%= annonce.getDescriptionContre() %></div>
                       <% } %>
        <h2>Photos</h2>
        <div class="cadre">
            <div class="photosMini">
        <%
        int nbPhotos=0;
        Img img=new Img();
        for(int i=1;i<=5;i++) {
            String extension=annonce.getExtensions()[i-1];
            if(extension.length()>0) {
            String filename=Datas.DIR+"photos/"+i+"_"+annonce.getId()+extension;
            String filenameMini2=Datas.DIR+"photos/mini2_"+i+"_"+annonce.getId()+extension;
            File file=new File(filename);
            File fileMini2=new File(filenameMini2);
            if(file.exists()&&fileMini2.exists()) {
                nbPhotos++;
                img.getSize(fileMini2);
                int largeur=img.getWidth();
                int hauteur=img.getHeight();
                %>
                <div class="mini">
                    <a href="./photo-<%= annonce.getId() %>-<%= i %><%= extension %>" zoom="1">
                        <img src="./mini2-<%= annonce.getId()%>-<%= i%><%= extension %>" width="<%= largeur%>" height="<%= hauteur%>" alt="miniature"/>
                    </a>
                </div>
                    <%
                    }
            }
            }
        %>
        <div class="clearBoth"></div>
            </div>
        <%
        if(nbPhotos==0) { %>
        <br/>
        <div class="info">Aucune photo pour cette annonce.</div>
        <br/>
        <% } %>
            </div>
        <h2>Contacter <%= annonce.getPseudo() %></h2>
        <div class="cadre">
            <div>Pour contacter <%= annonce.getPseudo() %> (l'annonceur) <a href="./contact-annonceur-<%= annonce.getId() %>.html" rel="nofollow" title="CONTACTER <%= annonce.getPseudo() %>">CLIQUEZ ICI</a></div>
        </div>
                   </div>
                                  <%
           }
        %>
            </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
