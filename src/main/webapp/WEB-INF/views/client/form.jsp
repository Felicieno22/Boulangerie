<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />

<h2>${client.idClient == null ? 'Nouveau Client' : 'Modifier Client'}</h2>

<form:form action="/clients/save" method="post" modelAttribute="client">
    <form:hidden path="idClient" />
    
    <div class="mb-3">
        <label class="form-label">Nom</label>
        <form:input path="nomClient" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Email</label>
        <form:input path="email" type="email" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Mot de passe</label>
        <form:password path="password" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Téléphone</label>
        <form:input path="telephone" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Adresse</label>
        <form:textarea path="adresse" class="form-control" required="true" />
    </div>
    
    <button type="submit" class="btn btn-primary">Enregistrer</button>
    <a href="/clients" class="btn btn-secondary">Annuler</a>
</form:form>

<jsp:include page="../layout/footer.jsp" /> 