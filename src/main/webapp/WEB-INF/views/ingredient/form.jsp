<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />

<div class="main-content">
    <div class="card">
        <div class="card-body">
            <h2 class="card-title mb-4">
                <i class="bi bi-${ingredient.idIngredient == null ? 'plus-circle' : 'pencil'}"></i>
                ${ingredient.idIngredient == null ? 'Nouvel Ingrédient' : 'Modifier Ingrédient'}
            </h2>

            <form:form action="/ingredients/save" method="post" modelAttribute="ingredient" cssClass="row g-3">
                <form:hidden path="idIngredient" />
                
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-tag"></i> Nom de l'Ingrédient
                    </label>
                    <form:input path="nomIngredient" cssClass="form-control" required="true" />
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-rulers"></i> Unité
                    </label>
                    <form:select path="unite.idUnite" cssClass="form-control" required="true">
                        <form:options items="${unites}" itemValue="idUnite" itemLabel="unite" />
                    </form:select>
                </div>
                
                <div class="col-12 mt-4">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save"></i> Enregistrer
                    </button>
                    <a href="/ingredients" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i> Annuler
                    </a>
                </div>
            </form:form>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />