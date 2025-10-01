<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />

<h2>${stock.idStock == null ? 'Nouveau Stock' : 'Modifier Stock'}</h2>

<form:form action="/stocks/save" method="post" modelAttribute="stock">
    <form:hidden path="idStock" />
    
    <div class="mb-3">
        <label class="form-label">Produit</label>
        <form:select path="produit.idProduit" class="form-control" required="true">
            <form:options items="${produits}" itemValue="idProduit" itemLabel="nomProduit" />
        </form:select>
    </div>
    
    <div class="mb-3">
        <label class="form-label">Quantité en Stock</label>
        <form:input path="quantiteStock" type="number" step="0.01" class="form-control" required="true" />
    </div>
    
    <div class="mb-3">
        <label class="form-label">Date de Mise à Jour</label>
        <form:input path="dateMaj" type="date" class="form-control" required="true" />
    </div>
    
    <button type="submit" class="btn btn-primary">Enregistrer</button>
    <a href="/stocks" class="btn btn-secondary">Annuler</a>
</form:form>

<jsp:include page="../layout/footer.jsp" /> 