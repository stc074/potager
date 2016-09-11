<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes.Objet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - ADMINISTRATION - Liste des abus</title>
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
<link href="./../CSS/style.css" type="text/css" rel="stylesheet" />
</head>
    <body>
        <%@include file="./haut.jsp" %>
        <div class="contenu">
            <h1>Liste des abus</h1>
            <%
            try {
                int nbAbus=0;
                Objet.getConnection();
                String query="SELECT t1.id,t1.timestamp,t2.titre FROM table_abus AS t1,table_annonces AS t2 WHERE t2.id=t1.id_annonce ORDER BY t1.timestamp ASC";
                Statement state=Objet.getConn().createStatement();
                ResultSet result=state.executeQuery(query);
                Calendar cal=Calendar.getInstance();
                while(result.next()) {
                    nbAbus++;
                    long idAbus=result.getLong("id");
                    long timestamp=result.getLong("timestamp");
                    String titre=result.getString("titre");
                    cal.setTimeInMillis(timestamp);
                    %>
                    <div>
                        <a href="./AbusAdmin?idAbus=<%= idAbus %>" rel="nofillow"><%= titre %></a>
                        <span>&nbsp;&rarr;Abus signalé le <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</span>
                    </div>
                    <br/>
                    <%
                    }
                result.close();
                state.close();
                Objet.closeConnection();
                } catch(Exception ex) { %>
                <div class="erreur">
                    <br/>
                    <div><%= ex.getMessage() %></div>
                    <br/>
                </div><% } %>
        </div>
    </body>
</html>
