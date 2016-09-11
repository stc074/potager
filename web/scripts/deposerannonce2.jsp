<%@page import="classes.Annonce"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Potagers solidaires - Déposer une annonce</title>
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
<a name="fb_share" type="button_count" share_url="<%= request.getRequestURL().toString() %>">Cliquez pour partager !!!</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
</div>
           <br/>
           <g:plusone></g:plusone>
           <br/>
           <h1>Potagers solidaires :: Déposer une annonce (Contenu)</h1>
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
                   }
               } else if(request.getAttribute("annonce")!=null) {
                   Annonce annonce=(Annonce)request.getAttribute("annonce");
                   if(annonce.getTest()==0) {
                   %>
                   <br/>
                   <div class="info">Pour remplir votre annonce, utilisez le formulaire ci-dessous :</div>
                   <br/>
                   <fieldset>
                       <legend>Contenu de votre annonce</legend>
                   <div id="form">
                       <%
                       if(request.getParameter("kermit")!=null&&annonce.getErrorMsg().length()>0) { %>
                       <div class="erreur">
                           <div>Erreur(s) :</div>
                           <br/>
                           <div><%= annonce.getErrorMsg() %></div>
                       </div><% } %>
                       <form action="./deposer-une-annonce-2.html#form" method="POST">
                           <div>
                               <input type="radio" name="type1" value="1" id="type11"<% if(annonce.getType1()==1) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./deposer-annonce-2-1-1-<%= annonce.getType2() %>-<%= annonce.getType3() %>.html#form';" />
                               <label for="type11">&rarr;Je propose&nbsp;</label>
                               <input type="radio" name="type1" value="2" id="type12"<% if(annonce.getType1()==2) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./deposer-annonce-2-1-2-<%= annonce.getType2() %>-<%= annonce.getType3() %>.html#form';" />
                               <label for="type12">&rarr;Je recherche&nbsp;</label>
                           </div>
                           <div>
                               <input type="radio" name="type2" value="1" id="type21"<% if(annonce.getType2()==1) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./deposer-annonce-2-1-<%= annonce.getType1() %>-1-<%= annonce.getType3() %>.html#form';" />
                               <label for="type21">&rarr;Un échange&nbsp;</label>
                               <input type="radio" name="type2" value="2" id="type22"<% if(annonce.getType2()==2) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./deposer-annonce-2-1-<%= annonce.getType1() %>-2-<%= annonce.getType3() %>.html#form';" />
                               <label for="type22">&rarr;Un don&nbsp;</label>
                           </div>
                           <div>
                               <span>Produit(s) : </span>
                               <input type="radio" name="type3" value="1" id="type31"<% if(annonce.getType3()==1) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./deposer-annonce-2-1-<%= annonce.getType1() %>-<%= annonce.getType2() %>-1.html#form';" />
                               <label for="type31">&rarr;Graines&nbsp;</label>
                               <input type="radio" name="type3" value="2" id="type32"<% if(annonce.getType3()==2) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./deposer-annonce-2-1-<%= annonce.getType1() %>-<%= annonce.getType2() %>-2.html#form';" />
                               <label for="type32">&rarr;Plant(s)&nbsp;</label>
                               <input type="radio" name="type3" value="3" id="type33"<% if(annonce.getType3()==3) out.print(" checked=\"checked\""); %> onclick="javascript:window.location.href='./deposer-annonce-2-1-<%= annonce.getType1() %>-<%= annonce.getType2() %>-3.html#form';" />
                               <label for="type33">&rarr;Fruit(s)/Légume(s)&nbsp;</label>
                           </div>
                               <%
                               if(annonce.getType1()!=0&&annonce.getType2()!=0&&annonce.getType3()!=0) { %>
                               <br/>
                               <%
                                   if(annonce.getType1()==1&&annonce.getType2()==1&&annonce.getType3()==1) { %>
                                   <div>Courte description des graines vous voulez échanger :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==1&&annonce.getType3()==2) { %>
                                   <div>Courte description des plants que vous voulez échanger :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==1&&annonce.getType3()==3) { %>
                                   <div>Courte description des Fruits ou legumes que vous voulez échanger :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==1&&annonce.getType3()==1) { %>
                                   <div>Courte description des graines vous cherchez :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==1&&annonce.getType3()==2) { %>
                                   <div>Courte description des plants que vous cherchez :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==1&&annonce.getType3()==3) { %>
                                   <div>Courte description des Fruits ou legumes que vous cherchez :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==2&&annonce.getType3()==1) { %>
                                   <div>Courte description des graines vous voulez donner :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==2&&annonce.getType3()==2) { %>
                                   <div>Courte description des plants que vous voulez donner :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==2&&annonce.getType3()==3) { %>
                                   <div>Courte description des Fruits ou legumes que vous voulez donner :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==2&&annonce.getType3()==1) { %>
                                   <div>Courte description des graines vous voulez acquérir :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==2&&annonce.getType3()==2) { %>
                                   <div>Courte description des plants que vous voulez acquérir :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==2&&annonce.getType3()==3) { %>
                                   <div>Courte description des Fruits ou legumes que vous voulez acquérir :</div>
                                   <%
                                   }
                                   %>
                                   <input type="text" name="titre" value="<%= annonce.getTitre()%>" size="30" maxlength="40" />
                                   <%
                                  if(annonce.getType1()==1&&annonce.getType2()==1&&annonce.getType3()==1) { %>
                                   <div>Description des graines vous voulez échanger :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==1&&annonce.getType3()==2) { %>
                                   <div>Description des plants que vous voulez échanger :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==1&&annonce.getType3()==3) { %>
                                   <div>Description des Fruits ou legumes que vous voulez échanger :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==1&&annonce.getType3()==1) { %>
                                   <div>Description des graines vous cherchez :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==1&&annonce.getType3()==2) { %>
                                   <div>Description des plants que vous cherchez :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==1&&annonce.getType3()==3) { %>
                                   <div>Description des Fruits ou legumes que vous cherchez :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==2&&annonce.getType3()==1) { %>
                                   <div>Description des graines vous voulez donner :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==2&&annonce.getType3()==2) { %>
                                   <div>Description des plants que vous voulez donner :</div>
                                   <%
                                   } else if(annonce.getType1()==1&&annonce.getType2()==2&&annonce.getType3()==3) { %>
                                   <div>Description des Fruits ou legumes que vous voulez donner :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==2&&annonce.getType3()==1) { %>
                                   <div>Description des graines vous voulez acquérir :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==2&&annonce.getType3()==2) { %>
                                   <div>Description des plants que vous voulez acquérir :</div>
                                   <%
                                   } else if(annonce.getType1()==2&&annonce.getType2()==2&&annonce.getType3()==3) { %>
                                   <div>Description des Fruits ou legumes que vous voulez acquérir :</div>
                                   <%
                                   }
                                   %>
                                   <textarea name="description" id="description" rows="4" cols="20"><%= annonce.getDescription()%></textarea>
 <script type="text/javascript">
	CKEDITOR.replace( 'description' );
</script>
                                  <%
                                  if(annonce.getType2()==1) {
                                   if(annonce.getType1()==1&&annonce.getType2()==1) { %>
                                       <div>Courte description de ce que vous voulez en échange :</div>
                                       <% } else if(annonce.getType1()==2&&annonce.getType2()==1) { %>
                                       <div>Courte description de ce que vous proposez en échange :</div><%
                                       } %>
                                       <input type="text" name="titreContre" value="<%= annonce.getTitreContre()%>" size="30" />
                                       <%
                                   if(annonce.getType1()==1&&annonce.getType2()==1) { %>
                                       <div>Description de ce que vous voulez en échange :</div>
                                       <% } else if(annonce.getType1()==2&&annonce.getType2()==1) { %>
                                       <div>Description de ce que vous proposez en échange :</div><%
                                       } %>
                                       <textarea name="descriptionContre" id="descriptionContre" rows="4" cols="20"><%= annonce.getDescriptionContre()%></textarea>
<script type="text/javascript">
	CKEDITOR.replace( 'descriptionContre' );
</script>
<%
                                       }
                                   %>
                                <br/>
                                <div>
                                    <div class="captcha"></div>
                                    <span>&rarr;Copier le code SVP &rarr;</span>
                                    <input type="text" name="captcha" value="" size="5" maxlength="5" />
                                    <div class="clearBoth"></div>
                                </div>
                               <br/>
                                   <input type="submit" value="Valider" name="kermit" />
                                   <%
                                   }
                   %>
                       </form>
                   </div>
                   </fieldset>
                   <%
                   } else if(annonce.getTest()==1) {
                       annonce.blank();
                       %>
                       <script type="text/javascript">
                           window.location.href="./deposer-annonce-photos.html";
                       </script>
                       <%
                       }
                   }
           %>
       </div>
       <%@include file="./footer.jsp" %>
    </body>
</html>
