<%@page import="java.util.Calendar"%>
<%@page import="classes.Img"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes.Objet"%>
<%@page import="classes.RechercheAnnonces"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
RechercheAnnonces recherche=null;
String tagTitle="Potagers Solidaires - Jardinez malin !";
String tagDescription="Potagers solidaires, le jardinage malin et sympa.";
if(request.getAttribute("recherche")!=null) {
    recherche=(RechercheAnnonces)request.getAttribute("recherche");
    tagTitle=recherche.getTagTitle();
    tagDescription=recherche.getTagDescription();
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
           <h1>Potagers solidaires :: les annonces</h1>
           <%
           if(recherche!=null) { %>
           <div class="info">Pour affiner votre recherche utilisez le formulaire ci-dessous:</div>
           <br/>
           <fieldset>
               <legend>Recherche</legend>
               <div id="form">
                   <form action="./annonces2.html#form" method="POST">
                       <div>
                           <span>Recherche :</span>
                           <input type="text" name="motsCles" value="<%= recherche.getMotsCles() %>" size="40" maxlength="300" />
                       </div>
                       <div>
                           <input type="radio" name="type1" value="1" id="type11"<% if(recherche.getType1()==1) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./annonces-1-1.html#form';" />
                           <label for="type11">&rarr;Je recherche&nbsp;</label>
                           <input type="radio" name="type1" value="2" id="type12"<% if(recherche.getType1()==2) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./annonces-1-2.html#form';" />
                           <label for="type12">&rarr;Je propose&nbsp;</label>
                       </div>
                           <div>
                               <input type="radio" name="type2" value="1" id="type21"<% if(recherche.getType2()==1) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./annonces-2-1.html#form';" />
                               <label for="type21">&rarr;Un échange&nbsp;</label>
                               <input type="radio" name="type2" value="2" id="type22"<% if(recherche.getType2()==2) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./annonces-2-2.html#form';" />
                               <label for="type22">&rarr;Un don&nbsp;</label>
                           </div>
                               <div>
                                   <span>Produits : </span>
                                   <input type="radio" name="type3" value="1" id="type31"<% if(recherche.getType3()==1) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./annonces-3-1.html#form';" />
                                   <label for="type31">&rarr;Graines&nbsp;</label>
                                   <input type="radio" name="type3" value="2" id="type32"<% if(recherche.getType3()==2) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./annonces-3-2.html#form';" />
                                   <label for="type32">&rarr;Plant(s)&nbsp;</label>
                                   <input type="radio" name="type3" value="3" id="type33"<% if(recherche.getType3()==3) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./annonces-3-3.html#form';" />
                                   <label for="type33">&rarr;Fruit(s) | Légume(s)&nbsp;</label>
                               </div>
                                   <div>
                                       <span>Localisation : </span>
                                       <span>Région &rArr; </span>
                                       <select name="idRegion" onchange="javascript:window.location.href='./annonces-4-'+this.value+'.html#form';">
                                           <option value="0"<% if(recherche.getIdRegion().equals("0")) out.print(" selected=\"selected\""); %>>Toutes</option>
                                           <%
                                           try {
                                               Objet.getConnection();
                                               String query="SELECT id_region,region FROM table_regions ORDER BY region ASC";
                                               Statement state=Objet.getConn().createStatement();
                                               ResultSet result=state.executeQuery(query);
                                               while(result.next()) {
                                                   String idRegion=result.getString("id_region");
                                                   String region=result.getString("region");
                                                   %>
                                                   <option value="<%= idRegion %>"<% if(recherche.getIdRegion().equals(idRegion)) out.print(" selected=\"selected\""); %>><%= region %></option>
                                                   <%
                                                   }
                                               result.close();
                                               state.close();
                                               Objet.closeConnection();
                                               } catch(Exception ex) { %>
                                               <br/>
                                               <div class="erreur"><%= ex.getMessage() %></div>
                                               <br/>
                                               <% } %>
                                       </select>
                                       <span>&nbsp;Département &rArr; </span>
                                       <select name="idDepartement" onchange="javascript:window.location.href='./annonces-5-'+this.value+'.html#form';">
                                           <option value="0"<% if(recherche.getIdDepartement().equals("0")) out.print(" selected=\"selected\""); %>>Tous</option>
                                           <%
                                           if(!recherche.getIdRegion().equals("0")) {
                                               try {
                                                   Objet.getConnection();
                                                   String query="SELECT id_departement,departement FROM table_departements WHERE id_region=? ORDER BY departement ASC";
                                                   PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                                                   prepare.setString(1, recherche.getIdRegion());
                                                   ResultSet result=prepare.executeQuery();
                                                   while(result.next()) {
                                                       String idDepartement=result.getString("id_departement");
                                                       String departement=result.getString("departement");
                                                       %>
                                                       <option value="<%= idDepartement %>"<% if(recherche.getIdDepartement().equals(idDepartement)) out.print(" selected=\"selected\""); %>><%= idDepartement %>&rarr;<%= departement %></option>
                                                       <%
                                                       }
                                                       result.close();
                                                       prepare.close();
                                                       Objet.closeConnection();
                                               } catch(Exception ex) { %>
                                               <br/>
                                               <div class="erreur"><%= ex.getMessage() %></div>
                                               <br/>
                                               <% }
                                               }
                                               %>
                                       </select>
                                       <span>&nbsp;Commune &rArr; </span>
                                       <select name="idCommune" onchange="javascript:window.location.href='./annonces-6-'+this.value+'.html#form';">
                                           <option value="0"<% if(recherche.getIdCommune()==0) out.print(" selected=\"selected\""); %>>Toutes</option>
                                           <%
                                           if(!recherche.getIdDepartement().equals("0")) {
                                               try {
                                                   Objet.getConnection();
                                                   String query="SELECT id,commune,code_postal FROM table_communes WHERE id_departement=? ORDER BY commune ASC";
                                                   PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                                                   prepare.setString(1, recherche.getIdDepartement());
                                                   ResultSet result=prepare.executeQuery();
                                                   while(result.next()) {
                                                       int idCommune=result.getInt("id");
                                                       String codePostal=result.getString("code_postal");
                                                       String commune=result.getString("commune");
                                                       %>
                                                       <option value="<%= idCommune %>"<% if(recherche.getIdCommune()==idCommune) out.print(" selected=\"selected\""); %>><%= codePostal %>&rarr;<%= commune %></option>
                                                       <%
                                                       }
                                                   result.close();
                                                   prepare.close();
                                                   Objet.closeConnection();
                                                   } catch(Exception ex) { %>
                                               <br/>
                                               <div class="erreur"><%= ex.getMessage() %></div>
                                               <br/>
                                               <% }
                                               }
                                               %>
                                       </select>
                                   </div>
                       <input type="submit" value="Valider" name="kermit" />
                       <input type="submit" value="Vider le formulaire" name="reset" />
                   </form>
               </div>
           </fieldset>
                           <%
                     try {
                         Objet.getConnection();
                         String query="SELECT COUNT(t1.id) AS nbAnnonces FROM table_annonces AS t1,table_membres AS t2"+recherche.getCondition()+" AND t2.id=t1.id_membre";
                         Statement state=Objet.getConn().createStatement();
                         ResultSet result=state.executeQuery(query);
                         result.next();
                         long nbAnnonces=result.getLong("nbAnnonces");
                         result.close();
                         state.close();
                         if(nbAnnonces==0) { %>
                         <br/>
                         <div class="info">Désolé, il n'y a aucune annonce pour cette recherche.</div>
                         <br/>
                         <% } else {
                         int nbPages=(int)(Math.ceil(((double)(nbAnnonces))/((double)(Datas.NBANNONCESPAGE))));
                         int nbAnnoncesPage=0;
                         if(nbAnnonces<Datas.NBANNONCESPAGE)
                             nbAnnoncesPage=(int)nbAnnonces;
                         else if((recherche.getPage()+1)<nbPages)
                             nbAnnoncesPage=Datas.NBANNONCESPAGE;
                         else if((recherche.getPage()+1)==nbPages)
                             nbAnnoncesPage=(int)nbAnnonces-((nbPages-1)*Datas.NBANNONCESPAGE);
                         //out.println(nbAnnoncesPage);
                         %>
                         <h2><%= nbAnnonces %> Annonce(s) pour cette recherche</h2>
                         <%
                         query="SELECT t1.id,t1.type2,t1.titre,t1.titre_contre,t1.extension1,t1.extension2,t1.extension3,t1.extension4,t1.extension5,t1.timestamp,t2.pseudo,t3.region,t4.departement,t5.commune,t5.code_postal FROM table_annonces AS t1,table_membres AS t2,table_regions AS t3,table_departements AS t4,table_communes AS t5"+recherche.getCondition()+" AND t2.id=t1.id_membre AND t3.id_region=t2.id_region AND t4.id_departement=t2.id_departement AND t5.id=t2.id_commune ORDER BY t1.last_timestamp DESC LIMIT "+(recherche.getPage()*Datas.NBANNONCESPAGE)+","+Datas.NBANNONCESPAGE;
                         state=Objet.getConn().createStatement();
                         result=state.executeQuery(query);
                         Calendar cal=Calendar.getInstance();
                         while(result.next()) {
                             long idAnnonce=result.getLong("id");
                             int type2=result.getInt("type2");
                             String titre=result.getString("titre");
                             String titreContre=result.getString("titre_contre");
                             String extensions[]=new String[5];
                             extensions[0]=result.getString("extension1");
                             extensions[1]=result.getString("extension2");
                             extensions[2]=result.getString("extension3");
                             extensions[3]=result.getString("extension4");
                             extensions[4]=result.getString("extension5");
                             long timestamp=result.getLong("timestamp");
                             String pseudo=result.getString("pseudo");
                             String region=result.getString("region");
                             String departement=result.getString("departement");
                             String commune=result.getString("commune");
                             String codePostal=result.getString("code_postal");
                             String url="";
                             if(type2==1)
                                 url="./annonce-"+idAnnonce+"-"+Objet.encodeTitre(titre)+"-contre-"+Objet.encodeTitre(titreContre)+".html";
                             else
                                 url="./annonce-"+idAnnonce+"-"+Objet.encodeTitre(titre)+".html";
                             cal.setTimeInMillis(timestamp);
                             %>
                             <div class="listeAnnonce">
                                 <div class="listeAnnonceGauche">
                                     <a href="<%= url %>#annonce" title="<%= titre %>">
                                 <%
                             int nbPhotos=0;
                             Img img=new Img();
                             for(int i=1;i<=5;i++) {
                                 String extension=extensions[i-1];
                                 if(extension.length()>0&&nbPhotos==0) {
                                     String filenameMini1=Datas.DIR+"photos/mini1_"+i+"_"+idAnnonce+extension;
                                     //out.println(filenameMini1);
                                     File fileMini1=new File(filenameMini1);
                                     if(fileMini1.exists()) {
                                         nbPhotos++;
                                         img.getSize(fileMini1);
                                         int largeur=img.getWidth();
                                         int hauteur=img.getHeight();
                                         %>
                                         <img src="./mini1-<%= idAnnonce%>-<%= i%><%= extension %>" width="<%= largeur%>" height="<%= hauteur%>" alt="Miniature"/>
                                         <%
                                         }
                                     }
                                 }
                             if(nbPhotos==0) { %>
                             <img src="./GFXs/miniature.png" width="125" height="125" alt="miniature"/>
                             <%
                             }
                             %>
                                     </a>
                                 </div>
                                 <div class="listeAnnonceDroite">
                                     <div><a href="<%= url %>#annonce" title="<%= titre %>"><%= titre %><% if(type2==1) { %>&nbsp;contre&nbsp;<%= titreContre %><% } %></a></div>
                                     <div>Annonce mise en ligne par <%= pseudo %>, le <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                                     <br/>
                                     <div>Localisation <%= codePostal %>-<%= commune %>&nbsp;[<%= departement %>|<%= region %>]</div>
                                 <div class="clearBoth"></div>
                                 </div>
                             </div>
                                 <br/>
                                 <%
                             }
                         result.close();
                         state.close();
                         int prem=recherche.getPage()-5;
                         if(prem<0)
                             prem=0;
                         int der=recherche.getPage()+5;
                         if(der>(nbPages-1))
                             der=nbPages-1;
                         %>
                         <div class="pages">
                             <span>Pages :</span>
                             <%
                         for(int i=prem;i<=der;i++) { %>
                         <span>
                             <%
                             if(i==recherche.getPage()) { %>
                             <span>[<span class="clign"><%= (i+1) %></span>]</span>
                             <% } else { %>
                             <a href="./annonces-7-<%= i %>.html#form" title="Page #<%= (i+1) %>"><%= (i+1) %></a>
                             <%
                             }
                             %>
                         </span>
                             <%
                             }
                         %>
                         </div>
                         <%
                         }
                         Objet.closeConnection();
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
