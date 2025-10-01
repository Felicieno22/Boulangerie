<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Liste des Unités</h2>
    <a href="/unites/new" class="btn btn-primary">Nouvelle Unité</a>
</div>

<!-- Recherche simple -->
<div class="card mb-4">
    <div class="card-body">
        <div class="row g-3">
            <div class="col-md-8">
                <input type="text" id="searchSimple" class="form-control" placeholder="Rechercher une unité...">
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
                    <label class="form-label">Nom de l'unité</label>
                    <input type="text" class="form-control" name="unite" id="searchUnite">
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
    <table class="table table-striped" id="unitesTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Unité</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${unites}" var="unite">
                <tr>
                    <td>${unite.idUnite}</td>
                    <td>${unite.unite}</td>
                    <td>
                        <a href="/unites/edit/${unite.idUnite}" class="btn btn-sm btn-warning">Modifier</a>
                        <a href="/unites/delete/${unite.idUnite}" class="btn btn-sm btn-danger" 
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette unité ?')">Supprimer</a>
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
    const table = document.getElementById('unitesTable');
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
    
    const unite = document.getElementById('searchUnite').value.toLowerCase();
    const rows = document.getElementById('unitesTable').getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName('td');
        const uniteText = cells[1].textContent.toLowerCase();
        
        row.style.display = uniteText.includes(unite) ? '' : 'none';
    }
});

// Réinitialisation
document.querySelector('button[type="reset"]').addEventListener('click', function() {
    const rows = document.getElementById('unitesTable').getElementsByTagName('tr');
    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display = '';
    }
});
</script>

<jsp:include page="../layout/footer.jsp" /> 