// Fonction de confirmation de suppression
function confirmDelete(id) {
    if (confirm('Êtes-vous sûr de vouloir supprimer cet ingrédient ?')) {
        window.location.href = `/ingredients/delete/${id}`;
    }
}

// Recherche simple
document.addEventListener('DOMContentLoaded', function() {
    const searchSimple = document.getElementById('searchSimple');
    if (searchSimple) {
        searchSimple.addEventListener('keyup', function() {
            const searchText = this.value.toLowerCase();
            const table = document.getElementById('ingredientsTable');
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
    }

    // Recherche avancée
    const searchForm = document.getElementById('searchForm');
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const nom = document.getElementById('searchNom').value.toLowerCase();
            const unite = document.getElementById('searchUnite').value.toLowerCase();
            
            const rows = document.getElementById('ingredientsTable').getElementsByTagName('tr');
            
            for (let i = 1; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.getElementsByTagName('td');
                
                const nomIngredient = cells[1].textContent.toLowerCase();
                const uniteText = cells[2].textContent.toLowerCase();
                
                let visible = true;
                
                if (nom && !nomIngredient.includes(nom)) visible = false;
                if (unite && !uniteText.includes(unite)) visible = false;
                
                row.style.display = visible ? '' : 'none';
            }
        });
    }

    // Réinitialisation
    const resetButton = document.querySelector('button[type="reset"]');
    if (resetButton) {
        resetButton.addEventListener('click', function() {
            const rows = document.getElementById('ingredientsTable').getElementsByTagName('tr');
            for (let i = 1; i < rows.length; i++) {
                rows[i].style.display = '';
            }
        });
    }

    // Effet hover sur les boutons
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(button => {
        button.addEventListener('mouseover', function() {
            this.style.transform = 'translateY(-2px)';
            this.style.boxShadow = '0 4px 8px rgba(0,0,0,0.15)';
        });

        button.addEventListener('mouseout', function() {
            this.style.transform = '';
            this.style.boxShadow = '';
        });
    });

    // Animation des badges
    const badges = document.querySelectorAll('.badge');
    badges.forEach(badge => {
        badge.addEventListener('mouseover', function() {
            this.style.transform = 'scale(1.1)';
        });

        badge.addEventListener('mouseout', function() {
            this.style.transform = '';
        });
    });
});
