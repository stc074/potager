<%@page import="classes.Objet"%>
<%@page import="classes.Datas"%>
<%@page import="classes.Membre"%>
<%
session=Objet.initSession(request, response);
Membre mbr=new Membre();
if(request.getParameter("kermitCnx")!=null) {
    mbr.getPostsCnx(request);
    mbr.verifPostsCnx(request, response);
    }
if(mbr.getTest()==1) {
mbr.blank();
%>
<script type="text/javascript">
   window.location.href="";
</script>
<%
}
%>
<div class="connexion">
    <div id="formCnx">
    <div>Connexion</div>
        <%
        if(request.getParameter("kermitCnx")!=null&&mbr.getErrorMsg().length()>0) { %>
        <div class="erreur">
            <div>Erreur(s) :</div>
            <br/>
            <div><%= mbr.getErrorMsg() %></div>
        </div><% } %>
    <form action="#formCnx" method="POST">
        <div>Pseudonyme :</div>
        <input type="text" name="pseudo" value="<%= mbr.getPseudo()%>" size="15" maxlength="20" />
        <div>Mot de passe :</div>
        <input type="password" name="motDePasse" value="" size="15" maxlength="15" />
        <br/>
        <input type="submit" value="Se connecter" name="kermitCnx" />
    </form>
    </div>
        <div>
            <span>Statut : </span>
            <%
            if(session.getAttribute("idMembre")==null||session.getAttribute("pseudo")==null) { %>
            <span>Déconnecté.</span>
            <% } else { %>
            <span>Connecté &rarr; <%= session.getAttribute("pseudo").toString() %></span>
            <% } %>
        </div>
        <div><a href="./mdp-oublie.html" title="MOT DE PASSE OUBLIÉ" rel="nofollow">Mot de passe Oublié ?</a></div>
</div>
        <div class="logo" onclick="javascript:window.location.href='./';"></div>
        <div class="clearBoth"></div>