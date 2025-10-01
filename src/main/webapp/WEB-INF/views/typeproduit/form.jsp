<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />

<h2>${typeProduit.idTypeProduit == null ? 'Nouveau Type de Produit' : 'Modifier Type de Produit'}</h2>

<form:form action="/typeproduits/save" method="post" modelAttribute="typeProduit">
    <form:hidden path="idTypeProduit" />
    
    <div class="mb-3">
        <label class="form-label">Nom du Type de Produit</label>
        <form:input path="nomTypeProduit" class="form-control" required="true" />
    </div>
    
    <button type="submit" class="btn btn-primary">Enregistrer</button>
    <a href="/typeproduits" class="btn btn-secondary">Annuler</a>
</form:form>

<jsp:include page="../layout/footer.jsp" /> 