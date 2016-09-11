<%@page import="classes.Abus"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - ADMINISTRATION - abus</title>
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
            <h1>Abus</h1>
            <%
            try {
                if(request.getAttribute("info")!=null) {
                    int info=Integer.parseInt(request.getAttribute("info").toString());
                    switch(info) {
                        case 1: %>
                        <script type="text/javascript">
                            window.location.href="./ListeAbus";
                        </script>
                        <%
                        }
                    } else if(request.getAttribute("abus")!=null) {
                    Abus abus=(Abus)request.getAttribute("abus");
                    %>
                    <div><a href="./AbusAdmin?idIgnore=<%= abus.getId() %>" rel="nofollow">Ignorer cette abus</a></div>
                    <br/>
                    <div><a href="./AbusAdmin?idDel=<%= abus.getId() %>" rel="nofollow">Effacer cette annonce</a></div>
                    <br/>
                    <%
                    if(abus.getType2()==1) { %>
                    <h2><%= abus.getTitre() %> contre <%= abus.getTitreContre() %></h2>
                    <%
                     } else { %>
                    <h2><%= abus.getTitre() %></h2>
                    <% } %>
                    <%= abus.getDescription() %>
                    <%
                    if(abus.getType2()==1) { %>
                    <h2>Contre <%= abus.getTitreContre() %></h2>
                    <%= abus.getDescriptionContre() %>
                    <% }
                    }
                } catch(Exception ex) { %>
                <div class="erreur">
                    <br/>
                    <div><%= ex.getMessage() %></div>
                </div><% } %>
        </div>
    </body>
</html>
