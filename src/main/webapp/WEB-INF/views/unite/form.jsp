<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />

<h2>${unite.idUnite == null ? 'Nouvelle Unité' : 'Modifier Unité'}</h2>

<form:form action="/unites/save" method="post" modelAttribute="unite">
    <form:hidden path="idUnite" />
    
    <div class="mb-3">
        <label class="form-label">Unité</label>
        <form:input path="unite" class="form-control" required="true" />
    </div>
    
    <button type="submit" class="btn btn-primary">Enregistrer</button>
    <a href="/unites" class="btn btn-secondary">Annuler</a>
</form:form>

<jsp:include page="../layout/footer.jsp" /> 