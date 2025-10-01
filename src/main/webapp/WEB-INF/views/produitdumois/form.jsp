<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="../layout/header.jsp" %>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-body">
                    <h2 class="card-title mb-4">
                        <i class="fas fa-gift"></i>
                        ${produitDuMois.idProduitMois == null ? 'Ajouter' : 'Modifier'} un Produit du Mois
                    </h2>

                    <form:form action="/produits-du-mois/save" method="post" modelAttribute="produitDuMois" class="needs-validation" novalidate="true">
                        <form:hidden path="idProduitMois"/>
                        
                        <div class="mb-4">
                            <label for="produit" class="form-label">
                                <i class="fas fa-box"></i> Produit
                            </label>
                            <form:select path="produit" class="form-select" required="true">
                                <form:option value="" label="Sélectionnez un produit"/>
                                <form:options items="${produits}" itemValue="idProduit" itemLabel="nomProduit"/>
                            </form:select>
                            <div class="invalid-feedback">Veuillez sélectionner un produit</div>
                        </div>
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label for="mois" class="form-label">
                                    <i class="fas fa-calendar"></i> Mois
                                </label>
                                <form:select path="mois" class="form-select" required="true">
                                    <form:option value="1" label="Janvier"/>
                                    <form:option value="2" label="Février"/>
                                    <form:option value="3" label="Mars"/>
                                    <form:option value="4" label="Avril"/>
                                    <form:option value="5" label="Mai"/>
                                    <form:option value="6" label="Juin"/>
                                    <form:option value="7" label="Juillet"/>
                                    <form:option value="8" label="Août"/>
                                    <form:option value="9" label="Septembre"/>
                                    <form:option value="10" label="Octobre"/>
                                    <form:option value="11" label="Novembre"/>
                                    <form:option value="12" label="Décembre"/>
                                </form:select>
                                <div class="invalid-feedback">Veuillez sélectionner un mois</div>
                            </div>
                            <div class="col-md-6">
                                <label for="annee" class="form-label">
                                    <i class="fas fa-calendar-alt"></i> Année
                                </label>
                                <form:input path="annee" type="number" class="form-control" required="true" min="2024"/>
                                <div class="invalid-feedback">Veuillez entrer une année valide (minimum 2024)</div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="description" class="form-label">
                                <i class="fas fa-align-left"></i> Description
                            </label>
                            <form:textarea path="description" class="form-control" rows="3" 
                                         placeholder="Décrivez la promotion..."/>
                        </div>
                        
                        <div class="mb-4">
                            <label for="remise" class="form-label">
                                <i class="fas fa-percent"></i> Remise (%)
                            </label>
                            <form:input path="remise" type="number" step="0.01" class="form-control" 
                                      required="true" min="0" max="100"/>
                            <div class="invalid-feedback">La remise doit être comprise entre 0 et 100%</div>
                        </div>
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label for="dateDebut" class="form-label">
                                    <i class="fas fa-calendar-plus"></i> Date de début
                                </label>
                                <form:input path="dateDebut" type="date" class="form-control" required="true"/>
                                <div class="invalid-feedback">Veuillez sélectionner une date de début</div>
                            </div>
                            <div class="col-md-6">
                                <label for="dateFin" class="form-label">
                                    <i class="fas fa-calendar-minus"></i> Date de fin
                                </label>
                                <form:input path="dateFin" type="date" class="form-control" required="true"/>
                                <div class="invalid-feedback">Veuillez sélectionner une date de fin</div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="/produits-du-mois" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Retour
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Enregistrer
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Validation du formulaire
    (function() {
        'use strict';
        var forms = document.querySelectorAll('.needs-validation');
        Array.prototype.slice.call(forms).forEach(function(form) {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();

    // Validation des dates
    document.getElementById('dateDebut').addEventListener('change', validateDates);
    document.getElementById('dateFin').addEventListener('change', validateDates);

    function validateDates() {
        var dateDebut = document.getElementById('dateDebut').value;
        var dateFin = document.getElementById('dateFin').value;
        
        if (dateDebut && dateFin && dateDebut > dateFin) {
            alert('La date de fin doit être postérieure à la date de début');
            document.getElementById('dateFin').value = '';
        }
    }
</script>

<%@ include file="../layout/footer.jsp" %>
