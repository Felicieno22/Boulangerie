<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Liste des Clients</h2>
    <a href="/clients/new" class="btn btn-primary">Nouveau Client</a>
</div>

<!-- Recherche simple -->
<div class="card mb-4">
    <div class="card-body">
        <div class="row g-3">
            <div class="col-md-8">
                <input type="text" id="searchSimple" class="form-control" placeholder="Rechercher un client...">
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
                    <label class="form-label">Nom</label>
                    <input type="text" class="form-control" name="nomClient" id="searchNom">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" id="searchEmail">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Téléphone</label>
                    <input type="text" class="form-control" name="telephone" id="searchTelephone">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Adresse</label>
                    <input type="text" class="form-control" name="adresse" id="searchAdresse">
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
    <table class="table table-striped" id="clientsTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Email</th>
                <th>Téléphone</th>
                <th>Adresse</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${clients}" var="client">
                <tr>
                    <td>${client.idClient}</td>
                    <td>${client.nomClient}</td>
                    <td>${client.email}</td>
                    <td>${client.telephone}</td>
                    <td>${client.adresse}</td>
                    <td>
                        <a href="/clients/edit/${client.idClient}" class="btn btn-sm btn-warning">Modifier</a>
                        <a href="/clients/delete/${client.idClient}" class="btn btn-sm btn-danger" 
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce client ?')">Supprimer</a>
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
    const table = document.getElementById('clientsTable');
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
    const email = document.getElementById('searchEmail').value.toLowerCase();
    const telephone = document.getElementById('searchTelephone').value.toLowerCase();
    const adresse = document.getElementById('searchAdresse').value.toLowerCase();
    
    const rows = document.getElementById('clientsTable').getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName('td');
        
        const nomClient = cells[1].textContent.toLowerCase();
        const emailClient = cells[2].textContent.toLowerCase();
        const telClient = cells[3].textContent.toLowerCase();
        const adresseClient = cells[4].textContent.toLowerCase();
        
        let visible = true;
        
        if (nom && !nomClient.includes(nom)) visible = false;
        if (email && !emailClient.includes(email)) visible = false;
        if (telephone && !telClient.includes(telephone)) visible = false;
        if (adresse && !adresseClient.includes(adresse)) visible = false;
        
        row.style.display = visible ? '' : 'none';
    }
});

// Réinitialisation
document.querySelector('button[type="reset"]').addEventListener('click', function() {
    const rows = document.getElementById('clientsTable').getElementsByTagName('tr');
    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display = '';
    }
});
</script>

<jsp:include page="../layout/footer.jsp" /> 