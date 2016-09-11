function signalerAbus(idAnnonce) {
    option=3;
    obj_req=null;
    obj_req=new createXMLHttpRequestObject();
    sendReq(obj_req,'./signaler-abus-'+idAnnonce+'.html');
}
function changeRegion(idRegion) {
    option=0;
    obj_req=null;
    obj_req=new createXMLHttpRequestObject();
    sendReq(obj_req,'./change-region-'+idRegion+'.html');

}
function changeDepartement(idDepartement) {
    option=1;
    obj_req=null;
    obj_req=new createXMLHttpRequestObject();
    sendReq(obj_req,'./change-departement-'+idDepartement+'.html');

}
function deconnexion() {
    option=7;
    obj_req=null;
    obj_req=new createXMLHttpRequestObject();
    sendReq(obj_req,'scripts/deconnexion.php');

}
function creer_cookie() {
    option=7;
    obj_req=null;
    obj_req=new createXMLHttpRequestObject();
    sendReq(obj_req,'scripts/creer_cookie.php');
}
function signaler_abus(id_annonce) {
    option=4;
    obj_req=null;
    obj_req=new createXMLHttpRequestObject();
    sendReq(obj_req,'scripts/signaler_abus.php?id_annonce='+id_annonce);
}

function mdp_oublie() {
    email=prompt('Saisissez L\'Email de votre compte SVP.','');
    if(email!=null)
        {
            option=4;
            obj_req=null;
            obj_req=new createXMLHttpRequestObject();
            sendReq(obj_req,'scripts/mdp_oublie.php?email='+email);
        }

}
function suggerer(id_annonce,id_categorie,id_sous_categorie) {
    email=prompt('Veuillez saisir l\'email de votre ami(e) SVP.','');
    if(email!=null)
        {
            option=4;
            obj_req=null;
            obj_req=new createXMLHttpRequestObject();
            sendReq(obj_req,'scripts/suggerer_annonce.php?id_categorie='+id_categorie+'&id_sous_categorie='+id_sous_categorie+'&id_annonce='+id_annonce+'&email='+email);
        }
}
function createXMLHttpRequestObject() {

var objReq=null;
	try {
		objReq=new ActiveXObject("Microsoft.XMLHTTP");
	}
	catch(Error) {
		try {
			objReq=new ActiveXObject("MSXML2.XMLHTTP");
		}
		catch(Error) {
			try {
				objReq=new XMLHttpRequest();
			}
			catch(Error) {
			}
		}
	}
	return objReq;
}
function sendReq(objReq,file) {
	objReq.open('GET',file,true);
	objReq.onreadystatechange=treat_response;
	objReq.send(null);
}
function treat_response() {
	if(obj_req.readyState==4) {
		if(obj_req.responseText!=-1)
                    {
                        switch(option)
                        {
                            case 0:
                                document.getElementById('innerDepartements').innerHTML=obj_req.responseText;
                                break;
                            case 1:
                                document.getElementById('innerCommunes').innerHTML=obj_req.responseText;
                                break;
                            case 3:
                                alert(obj_req.responseText);
                                break;
                             case 4:
                                resultat=obj_req.responseText;
                                break;

                        }
                    }

	}
}
