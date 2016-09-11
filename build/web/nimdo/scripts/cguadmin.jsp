<%@page import="java.util.Calendar"%>
<%@page import="classes.CGU"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - ADMINISTRATION - CGUS</title>
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
<script type="text/javascript" src="./../datas/ckeditor/ckeditor.js"></script>
</head>
    <body>
        <%@include file="./haut.jsp" %>
        <div class="contenu">
            <h1>CGUs</h1>
            <%
            try {
                if(request.getAttribute("cgu")!=null) {
                    CGU cgu=(CGU)request.getAttribute("cgu");
                    Calendar cal=Calendar.getInstance();
                    cal.setTimeInMillis(cgu.getTimestamp());
                    %>
                    <br/>
                    <div class="info">Dernière modification, le <%= cal.get(cal.DATE) %>-<%= cal.get(cal.MONTH)+1 %>-<%= cal.get(cal.YEAR) %>.</div>
                    <br/>
                    <div id="form">
                        <form action="./CGUAdmin#form" method="POST">
                        <textarea name="contenu" id="contenu" rows="4" cols="20"><%= cgu.getContenu()%></textarea>
                        <br/>
                        <input type="submit" value="Valider" name="kermit" />
                        </form>
                    </div>
<script type="text/javascript">
	CKEDITOR.replace( 'contenu' );
</script>
                        <%
                        }
                } catch(Exception ex) { %>
                <br/>
                <div class="erreur">
                    <div><%= ex.getMessage() %></div>
                </div>
                <br/><% } %>
        </div>
    </body>
</html>
