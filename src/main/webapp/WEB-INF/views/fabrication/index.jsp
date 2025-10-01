<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="container-fluid p-0">
    <div class="row">
        <!-- Formulaire de fabrication à gauche -->
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0">Fabrication de Produits</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            ${success}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/fabrication/generer" method="post" id="fabricationForm">
                        <div class="mb-3">
                            <label class="form-label">Produit à fabriquer</label>
                            <select name="produitId" class="form-control" id="produitSelect" required>
                                <option value="">Sélectionnez un produit</option>
                                <c:forEach items="${produits}" var="produit">
                                    <option value="${produit.idProduit}">${produit.nomProduit}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Quantité à produire</label>
                            <input type="number" name="quantite" class="form-control" required min="1" step="1">
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-gear-fill me-2"></i>Générer la fabrication
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Formule à droite -->
        <div class="col-md-6">
            <div class="card sticky-top" style="top: 20px;">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">Formule de fabrication</h4>
                    <i class="bi bi-journal-text text-primary"></i>
                </div>
                <div class="card-body" id="formuleDetails">
                    <div class="text-center text-muted py-5">
                        <i class="bi bi-arrow-left-circle fs-1 mb-3"></i>
                        <p>Sélectionnez un produit pour voir sa formule</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('produitSelect').addEventListener('change', async function() {
    const produitId = parseInt(this.value);
    const formuleDetails = document.getElementById('formuleDetails');
    
    console.log('Produit ID sélectionné:', produitId);
    
    if (!produitId || isNaN(produitId)) {
        formuleDetails.innerHTML = `
            <div class="text-center text-muted py-5">
                <i class="bi bi-arrow-left-circle fs-1 mb-3"></i>
                <p>Sélectionnez un produit pour voir sa formule</p>
            </div>`;
        return;
    }
    
    try {
        formuleDetails.innerHTML = '<div class="text-center py-5"><div class="spinner-border text-primary" role="status"></div></div>';
        
        // Construction de l'URL absolue
        const baseUrl = window.location.origin;
        const url = baseUrl + `/formules/api/produit/${produitId}/formules`;
        console.log('URL appelée:', url);
        
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            credentials: 'same-origin'
        });
        
        if (!response.ok) {
            const errorText = await response.text();
            console.error('Réponse du serveur:', response.status, errorText);
            throw new Error(`Erreur HTTP: ${response.status}`);
        }
        
        const formules = await response.json();
        console.log('Formules reçues:', formules);
        
        if (Array.isArray(formules) && formules.length > 0) {
            let html = '<div class="list-group">';
            formules.forEach(formule => {
                if (formule.ingredient && formule.ingredient.nomIngredient) {
                    html += `
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">${formule.ingredient.nomIngredient}</h6>
                                    <small class="text-muted">${formule.ingredient.unite ? formule.ingredient.unite.unite : ''}</small>
                                </div>
                                <span class="badge bg-primary rounded-pill">${formule.quantite}</span>
                            </div>
                        </div>`;
                }
            });
            html += '</div>';
            formuleDetails.innerHTML = html;
        } else {
            formuleDetails.innerHTML = `
                <div class="text-center text-warning py-5">
                    <i class="bi bi-exclamation-circle fs-1 mb-3"></i>
                    <p>Aucune formule trouvée pour ce produit</p>
                </div>`;
        }
    } catch (error) {
        console.error('Erreur:', error);
        formuleDetails.innerHTML = `
            <div class="text-center text-danger py-5">
                <i class="bi bi-exclamation-triangle fs-1 mb-3"></i>
                <p>Erreur lors du chargement de la formule</p>
                <small class="text-muted">${error.message}</small>
            </div>`;
    }
});
</script>

<script>
    function chargerFormules(produitId) {
        console.log("Produit ID sélectionne:", produitId);
        const url = `/formules/api/produit/${produitId}/formules`;
        console.log("URL appelée:", produitId);

        fetch(url)
            .then(response => {
                console.log("Réponse du serveur:", response.status);
                if (!response.ok) {
                    throw new Error(`Erreur HTTP: ${response.status}`);
                }
                return response.json();
            })
            .then(formules => {
                console.log("Formules reçues:", formules);
                const formuleDetails = document.getElementById('formuleDetails');
                
                if (formules && formules.length > 0) {
                    let html = '<div class="table-responsive">';
                    html += '<table class="table table-striped">';
                    html += '<thead><tr><th>Ingrédient</th><th>Quantité</th><th>Unité</th></tr></thead>';
                    html += '<tbody>';
                    
                    formules.forEach(formule => {
                        html += `<tr>
                            <td>${formule.ingredient.nomIngredient}</td>
                            <td>${formule.quantite}</td>
                            <td>${formule.ingredient.unite.unite}</td>
                        </tr>`;
                    });
                    
                    html += '</tbody></table></div>';
                    formuleDetails.innerHTML = html;
                } else {
                    formuleDetails.innerHTML = `
                        <div class="alert alert-warning" role="alert">
                            Aucune formule trouvée pour ce produit.
                        </div>`;
                }
            })
            .catch(error => {
                console.error("Erreur:", error);
                document.getElementById('formuleDetails').innerHTML = `
                    <div class="alert alert-danger" role="alert">
                        Erreur lors du chargement de la formule: ${error.message}
                    </div>`;
            });
    }
</script>

<jsp:include page="../layout/footer.jsp" /> 