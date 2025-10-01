<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Liste des Types de Produits</h2>
    <a href="/typeproduits/new" class="btn btn-primary">Nouveau Type de Produit</a>
</div>

<!-- Recherche simple -->
<div class="card mb-4">
    <div class="card-body">
        <div class="row g-3">
            <div class="col-md-8">
                <input type="text" id="searchSimple" class="form-control" placeholder="Rechercher un type de produit...">
            </div>
            <div class="col-md-4">
                <button class="btn btn-secondary w-100" type="button" data-bs-toggle="collapse" 
                        data-bs-target="#rechercheAvancee">
                    Recherche avancée
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Recherche avancée -->
<div class="collapse mb-4" id="rechercheAvancee">
    <div class="card">
        <div class="card-body">
            <form id="searchForm" class="row g-3">
                <div class="col-12">
                    <label class="form-label">Nom du type de produit</label>
                    <input type="text" class="form-control" name="nomType" id="searchNom">
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Rechercher</button>
                    <button type="reset" class="btn btn-secondary">Réinitialiser</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-striped" id="typeProduitsTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${typeProduits}" var="typeProduit">
                <tr>
                    <td>${typeProduit.idTypeProduit}</td>
                    <td>${typeProduit.nomTypeProduit}</td>
                    <td>
                        <a href="/typeproduits/edit/${typeProduit.idTypeProduit}" class="btn btn-sm btn-warning">Modifier</a>
                        <a href="/typeproduits/delete/${typeProduit.idTypeProduit}" class="btn btn-sm btn-danger" 
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce type de produit ?')">Supprimer</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
// Recherche simple
document.getElementById('searchSimple').addEventListener('keyup', function() {
    const searchText = this.value.toLowerCase();
    const table = document.getElementById('typeProduitsTable');
    const rows = table.getElementsByTagName('tr');

    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName('td');
        let found = false;

        for (let j = 0; j < cells.length; j++) {
            const cell = cells[j];
            if (cell.textContent.toLowerCase().indexOf(searchText) > -1) {
                found = true;
                break;
            }
        }

        row.style.display = found ? '' : 'none';
    }
});

// Recherche avancée
document.getElementById('searchForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const nom = document.getElementById('searchNom').value.toLowerCase();
    const rows = document.getElementById('typeProduitsTable').getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName('td');
        const nomType = cells[1].textContent.toLowerCase();
        
        row.style.display = nomType.includes(nom) ? '' : 'none';
    }
});

// Réinitialisation
document.querySelector('button[type="reset"]').addEventListener('click', function() {
    const rows = document.getElementById('typeProduitsTable').getElementsByTagName('tr');
    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display = '';
    }
});
</script>

<jsp:include page="../layout/footer.jsp" /> 