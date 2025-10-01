<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Liste des Stocks</h2>
    <a href="/stocks/new" class="btn btn-primary">Nouveau Stock</a>
</div>

<!-- Recherche simple -->
<div class="card mb-4">
    <div class="card-body">
        <div class="row g-3">
            <div class="col-md-8">
                <input type="text" id="searchSimple" class="form-control" placeholder="Rechercher un stock...">
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
                <div class="col-md-6">
                    <label class="form-label">Produit</label>
                    <select class="form-control" name="produit" id="searchProduit">
                        <option value="">Tous</option>
                        <c:forEach items="${produits}" var="produit">
                            <option value="${produit.nomProduit}">${produit.nomProduit}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Quantité minimum</label>
                    <input type="number" class="form-control" name="quantiteMin" id="searchQuantiteMin" step="0.01">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Quantité maximum</label>
                    <input type="number" class="form-control" name="quantiteMax" id="searchQuantiteMax" step="0.01">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Date de mise à jour</label>
                    <input type="date" class="form-control" name="date" id="searchDate">
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
    <table class="table table-striped" id="stocksTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Produit</th>
                <th>Quantité en Stock</th>
                <th>Dernière Mise à Jour</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${stocks}" var="stock">
                <tr>
                    <td>${stock.idStock}</td>
                    <td>${stock.produit.nomProduit}</td>
                    <td>${stock.quantiteStock}</td>
                    <td>${stock.dateMaj}</td>
                    <td>
                        <a href="/stocks/edit/${stock.idStock}" class="btn btn-sm btn-warning">Modifier</a>
                        <a href="/stocks/delete/${stock.idStock}" class="btn btn-sm btn-danger" 
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce stock ?')">Supprimer</a>
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
    const table = document.getElementById('stocksTable');
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
    
    const produit = document.getElementById('searchProduit').value.toLowerCase();
    const quantiteMin = document.getElementById('searchQuantiteMin').value;
    const quantiteMax = document.getElementById('searchQuantiteMax').value;
    const date = document.getElementById('searchDate').value;
    
    const rows = document.getElementById('stocksTable').getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName('td');
        
        const produitText = cells[1].textContent.toLowerCase();
        const quantite = parseFloat(cells[2].textContent);
        const dateText = cells[3].textContent;
        
        let visible = true;
        
        if (produit && !produitText.includes(produit)) visible = false;
        if (quantiteMin && quantite < parseFloat(quantiteMin)) visible = false;
        if (quantiteMax && quantite > parseFloat(quantiteMax)) visible = false;
        if (date && dateText !== date) visible = false;
        
        row.style.display = visible ? '' : 'none';
    }
});

// Réinitialisation
document.querySelector('button[type="reset"]').addEventListener('click', function() {
    const rows = document.getElementById('stocksTable').getElementsByTagName('tr');
    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display = '';
    }
});
</script>

<jsp:include page="../layout/footer.jsp" /> 