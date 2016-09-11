<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes.Objet"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Infos personnelles</title>
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
           <h1>Potagers solidaires :: Infos personnelles</h1>
           <%
           if(request.getAttribute("info")!=null) {
               int info=Integer.parseInt(request.getAttribute("info").toString());
               switch(info) {
                   case 1: %>
                   <br/>
                   <div class="info">Vous devez être connecté pour pouvoir accéder à vos infos.</div>
                   <br/>
                   <%
                   break;
                   }
               } else if(request.getAttribute("membre")!=null) {
                   Membre membre=(Membre)request.getAttribute("membre");
                   Calendar cal=Calendar.getInstance();
                   cal.setTimeInMillis(membre.getTimestamp());
                   %>
                   <h2>Compte créé le, <%= cal.get(cal.DATE) %>/<%= cal.get(cal.MONTH)+1 %>/<%= cal.get(cal.YEAR) %></h2>
                   <div class="info">Vous pouvez modifier vos infos avec le formulaire ci-dessous :</div>
                   <br/>
                   <%
                   if(membre.getTest()==1) { %>
                   <br/>
                   <div class="info">Informations mises à jour.</div>
                   <br/>
                   <% } %>
                   <fieldset>
                       <legend>Vos informations personnelles</legend>
                   <div id="form">
                       <%
                       if(request.getParameter("kermit")!=null&&membre.getErrorMsg().length()>0) { %>
                       <div class="erreur">
                           <div>Erreur(s) :</div>
                           <br/>
                           <div><%= membre.getErrorMsg() %></div>
                       </div><% } %>
                       <form action="./infos-personnelles.html#form" method="POST">
                           <div>Votre PSEUDONYME :</div>
                           <input type="text" name="pseudo" value="<%= membre.getPseudo()%>" size="15" readonly="readonly" disabled="disabled" maxlength="20" />
                           <div>Votre ADRESSE EMAIL :</div>
                           <input type="text" name="email" value="<%= membre.getEmail()%>" size="40" readonly="readonly" disabled="disabled" maxlength="200" />
                           <div>Nouveau MOT DE PASSE (À ne remplir qu'en cas de changement) :</div>
                           <input type="password" name="motDePasse" value="" size="15" maxlength="15" />
                           <div>Confirmation du NOUVEAU MOT DE PASSE :</div>
                           <input type="password" name="motDePasse2" value="" size="15" maxlength="15" />
                    <div>Localisation - Vous habitez :</div>
                   <div>
                       <span>Région :</span>
                       <select name="idRegion" onchange="javascript:changeRegion(this.value);">
                           <option value="0"<% if(membre.getIdRegion().equals("0")) out.print(" selected=\"selected\""); %>>Choisissez</option>
                           <%
                           Objet.getConnection();
                           String query="SELECT id_region,region FROM table_regions ORDER BY region ASC";
                           Statement state=Objet.getConn().createStatement();
                           ResultSet result=state.executeQuery(query);
                           while(result.next()) {
                               String idRegion=result.getString("id_region");
                               String region=result.getString("region");
                               %>
                               <option value="<%= idRegion %>"<% if(idRegion.equals(membre.getIdRegion())) out.print(" selected=\"selected\""); %>><%= region %></option>
                               <%
                               }
                           result.close();
                           state.close();
                           %>
                       </select>
                   </div>
                       <div id="innerDepartements">
                           <span>Département :</span>
                           <select name="idDepartement" onchange="javascript:changeDepartement(this.value);">
                               <option value="0"<% if(membre.getIdDepartement().equals("0")) out.print(" selected=\"selected\""); %>>Choisissez</option>
                                   <%
                                   if(!membre.getIdRegion().equals("0")) {
                                       query="SELECT id_departement,departement FROM table_departements WHERE id_region=? ORDER BY departement ASC";
                                       PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                                       prepare.setString(1, membre.getIdRegion());
                                       result=prepare.executeQuery();
                                       while(result.next()) {
                                           String idDepartement=result.getString("id_departement");
                                           String departement=result.getString("departement");
                                           %>
                                           <option value="<%= idDepartement %>"<% if(membre.getIdDepartement().equals(idDepartement)) out.print(" selected=\"selected\""); %>><%= idDepartement+" &rarr; "+departement %></option>
                                           <%
                                           }
                                       result.close();
                                       prepare.close();
                                       }
                                       %>
                            </select>
                            <div id="innerCommunes">
                                <span>Commune :</span>
                                <select name="idCommune">
                                    <option value="0"<% if(membre.getIdCommune()==0) out.print(" selected=\"selected\""); %>>Choisissez</option>
                                    <%
                                    if(!membre.getIdDepartement().equals("0")) {
                                    query="SELECT id,commune,code_postal FROM table_communes WHERE id_departement=? ORDER BY commune ASC";
                                    PreparedStatement prepare=Objet.getConn().prepareStatement(query);
                                    prepare.setString(1, membre.getIdDepartement());
                                    result=prepare.executeQuery();
                                    while(result.next()) {
                                        int idCommune=result.getInt("id");
                                        String commune=result.getString("commune");
                                        String codePostal=result.getString("code_postal");
                                        %>
                                        <option value="<%= idCommune %>"<% if(membre.getIdCommune()==idCommune) out.print(" selected=\"selected\""); %>><%= codePostal+" &rarr; "+commune %></option>
                                        <%
                                        }
                                    result.close();
                                    prepare.close();
                                    }
                                    %>
                                </select>
                            </div>
                       </div>
                                <br/>
                                <input type="submit" value="Valider" name="kermit" />
                      </form>
                   </div>
                   </fieldset>
                           <%
                           Objet.closeConnection();
                   }
           %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
