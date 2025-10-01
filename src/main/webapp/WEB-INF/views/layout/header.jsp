<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Boulangerie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="/static/css/style.css" rel="stylesheet">
    <style>
        :root {
        --sidebar-width: 280px;
        --sidebar-width-mobile: 70px;
        --primary-color: #8B4513; /* Marron */
        --secondary-color: #D2691E; /* Marron clair */
        --hover-color: #F5DEB3; /* Beige */
        --bg-light: #FFF8DC; /* Crème */
        --text-primary: #2c3e50;
        --text-secondary: #7f8c8d;
            }

        @keyframes gradientAnimation {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(
                135deg,
                var(--primary-color),
                #2b353f,
                #33648b,
                #896b97,
                var(--primary-color)
            );
            background-size: 400% 400%;
            animation: gradientAnimation 15s ease infinite;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            z-index: 1000;
            padding-top: 1rem;
            transition: all 0.3s ease;
            overflow-y: auto;
        }

        .sidebar .navbar-brand {
            padding: 1.5rem;
            color: white;
            font-weight: 600;
            font-size: 1.4rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 1rem;
            display: block;
            text-decoration: none;
        }

        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            transition: all 0.3s;
            border-radius: 0 25px 25px 0;
            margin: 0.2rem 0;
            margin-right: 1rem;
        }

        .sidebar .nav-link:hover {
            color: white;
            background-color: rgba(255,255,255,0.1);
            transform: translateX(5px);
        }

        .sidebar .nav-link.active {
            color: white;
            background: linear-gradient(90deg, var(--secondary-color), var(--hover-color));
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .sidebar .nav-link i {
            margin-right: 12px;
            font-size: 1.2rem;
            width: 24px;
            text-align: center;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
            transition: all 0.3s ease;
            min-height: 100vh;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            border-radius: 15px 15px 0 0 !important;
            padding: 1.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--secondary-color), var(--hover-color));
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--hover-color), var(--secondary-color));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* Animations pour les éléments du menu */
        .nav-item {
            opacity: 0;
            animation: fadeIn 0.5s ease forwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateX(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Animation délai pour chaque élément du menu */
        .nav-item:nth-child(1) { animation-delay: 0.1s; }
        .nav-item:nth-child(2) { animation-delay: 0.2s; }
        .nav-item:nth-child(3) { animation-delay: 0.3s; }  
        .nav-item:nth-child(4) { animation-delay: 0.4s; }
        .nav-item:nth-child(5) { animation-delay: 0.5s; }
        .nav-item:nth-child(6) { animation-delay: 0.6s; }
        .nav-item:nth-child(7) { animation-delay: 0.7s; }
        .nav-item:nth-child(8) { animation-delay: 0.8s; }
        .nav-item:nth-child(9) { animation-delay: 0.9s; }

        .sortable {
            cursor: pointer;
        }
        .sortable:hover {
            background-color: #f8f9fa;
        }
        .sortable::after {
            content: '↕️';
            margin-left: 5px;
            opacity: 0.3;
        }
        .sortable.asc::after {
            content: '↑';
            opacity: 1;
        }
        .sortable.desc::after {
            content: '↓';
            opacity: 1;
        }

        /* Styles pour la pagination */
        .pagination-container {
            margin-top: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pagination-info {
            color: var(--text-secondary);
        }

        .pagination-controls {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .pagination-controls select {
            padding: 0.375rem 0.75rem;
            border-radius: 0.25rem;
            border: 1px solid #ced4da;
        }

        .pagination-controls button {
            padding: 0.375rem 0.75rem;
            border-radius: 0.25rem;
            border: 1px solid #ced4da;
            background-color: white;
            cursor: pointer;
            transition: all 0.2s;
        }

        .pagination-controls button:hover:not(:disabled) {
            background-color: var(--primary-color);
            color: white;
        }

        .pagination-controls button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Styles pour les tableaux responsifs */
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            margin-bottom: 1rem;
        }

        .table {
            min-width: 100%;
            white-space: nowrap;
        }

        /* Styles pour la pagination responsive */
        .pagination-container {
            flex-direction: row;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .pagination-controls {
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        /* Menu burger pour mobile */
        .menu-toggle {
            display: none;
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 1001;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0.5rem;
            border-radius: 4px;
            cursor: pointer;
        }

        /* Media Queries */
        @media (max-width: 1200px) {
            :root {
                --sidebar-width: 220px;
            }
        }

        @media (max-width: 992px) {
            .card {
                margin-bottom: 1rem;
            }
            
            .table {
                font-size: 0.9rem;
            }
            
            .btn {
                padding: 0.5rem 1rem;
            }
        }

        @media (max-width: 768px) {
            .menu-toggle {
                display: block;
            }

            .sidebar {
                transform: translateX(-100%);
                width: 100%;
                max-width: 300px;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

            .pagination-container {
                flex-direction: column;
                align-items: stretch;
            }

            .pagination-info {
                text-align: center;
                margin-bottom: 0.5rem;
            }

            .pagination-controls {
                justify-content: center;
            }

            .table-responsive {
                margin: 0 -1rem;
                padding: 0 1rem;
            }

            .nav-link span {
                display: none;
            }

            .nav-link i {
                font-size: 1.5rem;
                margin: 0;
            }

            .navbar-brand {
                font-size: 1.2rem;
                text-align: center;
                padding: 1rem 0.5rem;
            }
        }

        @media (max-width: 576px) {
            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }

            .d-flex {
                flex-direction: column;
            }

            .card-body {
                padding: 1rem;
            }
        }

        /* Styles pour le menu burger */
        .menu-toggle {
            width: 40px;
            height: 40px;
            display: none;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 6px;
            background: var(--primary-color);
            border: none;
            border-radius: 4px;
            cursor: pointer;
            padding: 8px;
        }

        .menu-toggle span {
            display: block;
            width: 24px;
            height: 2px;
            background: white;
            transition: all 0.3s ease;
        }

        .menu-toggle.active span:nth-child(1) {
            transform: rotate(45deg) translate(5px, 5px);
        }

        .menu-toggle.active span:nth-child(2) {
            opacity: 0;
        }

        .menu-toggle.active span:nth-child(3) {
            transform: rotate(-45deg) translate(5px, -5px);
        }
    </style>

    <script>
    // Ajouter le code JavaScript pour le menu burger
    document.addEventListener('DOMContentLoaded', function() {
        const menuToggle = document.createElement('button');
        menuToggle.className = 'menu-toggle';
        menuToggle.innerHTML = '<span></span><span></span><span></span>';
        document.body.appendChild(menuToggle);

        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');

        menuToggle.addEventListener('click', () => {
            sidebar.classList.toggle('active');
            menuToggle.classList.toggle('active');
        });

        // Fermer le menu au clic en dehors
        document.addEventListener('click', (e) => {
            if (!sidebar.contains(e.target) && !menuToggle.contains(e.target) && window.innerWidth <= 768) {
                sidebar.classList.remove('active');
                menuToggle.classList.remove('active');
            }
        });

        // Gérer le redimensionnement de la fenêtre
        window.addEventListener('resize', () => {
            if (window.innerWidth > 768) {
                sidebar.classList.remove('active');
                menuToggle.classList.remove('active');
            }
        });
    });

    function initTableSort() {
        document.querySelectorAll('table').forEach(table => {
            const headers = table.querySelectorAll('th');
            headers.forEach((header, index) => {
                if (header.textContent !== 'Actions' && header.textContent !== 'Image') {
                    header.classList.add('sortable');
                    header.addEventListener('click', () => {
                        const direction = header.classList.contains('asc') ? 'desc' : 'asc';
                        headers.forEach(h => h.classList.remove('asc', 'desc'));
                        header.classList.add(direction);
                        
                        const tbody = table.querySelector('tbody');
                        const rows = Array.from(tbody.querySelectorAll('tr'));
                        
                        rows.sort((a, b) => {
                            const aValue = a.cells[index].textContent.trim();
                            const bValue = b.cells[index].textContent.trim();
                            
                            if (!isNaN(aValue) && !isNaN(bValue)) {
                                return direction === 'asc' 
                                    ? parseFloat(aValue) - parseFloat(bValue)
                                    : parseFloat(bValue) - parseFloat(aValue);
                            }
                            
                            return direction === 'asc'
                                ? aValue.localeCompare(bValue, 'fr')
                                : bValue.localeCompare(aValue, 'fr');
                        });
                        
                        rows.forEach(row => tbody.appendChild(row));
                        
                        // Mettre à jour la pagination après le tri
                        if (table.updatePagination) {
                            table.updatePagination();
                        }
                    });
                }
            });
        });
    }

    function initTablePagination() {
        document.querySelectorAll('table').forEach(table => {
            // Créer les éléments de pagination
            const paginationContainer = document.createElement('div');
            paginationContainer.className = 'pagination-container';
            
            const paginationInfo = document.createElement('div');
            paginationInfo.className = 'pagination-info';
            
            const controls = document.createElement('div');
            controls.className = 'pagination-controls';
            
            // Sélecteur du nombre d'éléments par page
            const select = document.createElement('select');
            [5, 10, 25, 50].forEach(value => {
                const option = document.createElement('option');
                option.value = value;
                option.text = `${value} par page`;
                if (value === 10) option.selected = true;
                select.appendChild(option);
            });
            
            const prevButton = document.createElement('button');
            prevButton.textContent = 'Précédent';
            
            const nextButton = document.createElement('button');
            nextButton.textContent = 'Suivant';
            
            controls.appendChild(select);
            controls.appendChild(prevButton);
            controls.appendChild(nextButton);
            
            paginationContainer.appendChild(paginationInfo);
            paginationContainer.appendChild(controls);
            
            // Insérer après le tableau
            table.parentNode.insertBefore(paginationContainer, table.nextSibling);
            
            // État de la pagination
            let currentPage = 1;
            let rowsPerPage = 10;
            
            // Fonction pour mettre à jour l'affichage
            function updateTable() {
                const tbody = table.querySelector('tbody');
                const rows = Array.from(tbody.querySelectorAll('tr'));
                const totalRows = rows.length;
                const totalPages = Math.ceil(totalRows / rowsPerPage);
                
                // Mettre à jour les boutons
                prevButton.disabled = currentPage === 1;
                nextButton.disabled = currentPage === totalPages || totalRows === 0;
                
                // Mettre à jour l'info de pagination avec vérification des valeurs
                if (totalRows === 0) {
                    paginationInfo.textContent = "Aucun élément";
                } else {
                    const debut = ((currentPage - 1) * rowsPerPage) + 1;
                    const fin = Math.min(currentPage * rowsPerPage, totalRows);
                    paginationInfo.textContent = `Éléments ${debut} à ${fin} sur ${totalRows}`;
                }
                
                // Afficher les lignes appropriées
                rows.forEach((row, index) => {
                    const shouldShow = index >= (currentPage - 1) * rowsPerPage && index < currentPage * rowsPerPage;
                    row.style.display = shouldShow ? '' : 'none';
                });
            }
            
            // Gestionnaires d'événements
            select.addEventListener('change', (e) => {
                rowsPerPage = parseInt(e.target.value);
                currentPage = 1;
                updateTable();
            });
            
            prevButton.addEventListener('click', () => {
                if (currentPage > 1) {
                    currentPage--;
                    updateTable();
                }
            });
            
            nextButton.addEventListener('click', () => {
                const totalRows = table.querySelector('tbody').querySelectorAll('tr').length;
                const totalPages = Math.ceil(totalRows / rowsPerPage);
                if (currentPage < totalPages) {
                    currentPage++;
                    updateTable();
                }
            });
            
            // Initialisation
            updateTable();
            
            // Exposer updateTable pour pouvoir l'appeler après le tri
            table.updatePagination = updateTable;
        });
    }

    // Modifier la fonction de tri pour mettre à jour la pagination
    const originalInitTableSort = initTableSort;
    initTableSort = function() {
        document.querySelectorAll('table').forEach(table => {
            const headers = table.querySelectorAll('th');
            headers.forEach((header, index) => {
                if (header.textContent !== 'Actions' && header.textContent !== 'Image') {
                    header.classList.add('sortable');
                    header.addEventListener('click', () => {
                        const direction = header.classList.contains('asc') ? 'desc' : 'asc';
                        headers.forEach(h => h.classList.remove('asc', 'desc'));
                        header.classList.add(direction);
                        
                        const tbody = table.querySelector('tbody');
                        const rows = Array.from(tbody.querySelectorAll('tr'));
                        
                        rows.sort((a, b) => {
                            const aValue = a.cells[index].textContent.trim();
                            const bValue = b.cells[index].textContent.trim();
                            
                            if (!isNaN(aValue) && !isNaN(bValue)) {
                                return direction === 'asc' 
                                    ? parseFloat(aValue) - parseFloat(bValue)
                                    : parseFloat(bValue) - parseFloat(aValue);
                            }
                            
                            return direction === 'asc'
                                ? aValue.localeCompare(bValue, 'fr')
                                : bValue.localeCompare(aValue, 'fr');
                        });
                        
                        rows.forEach(row => tbody.appendChild(row));
                        
                        // Mettre à jour la pagination après le tri
                        if (table.updatePagination) {
                            table.updatePagination();
                        }
                    });
                }
            });
        });
    };

    // Initialiser le tri et la pagination quand le DOM est chargé
    document.addEventListener('DOMContentLoaded', () => {
        initTableSort();
        initTablePagination();
    });
    </script>
</head>
<body>
    <div class="sidebar">
        <a class="navbar-brand" href="/shop">
            <i class="bi bi-shop"></i> Boulangerie
        </a>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/fabrication') ? 'active' : ''}" href="/fabrication">
                    <i class="bi bi-gear"></i> Fabrication
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/typeproduits') ? 'active' : ''}" href="/typeproduits">
                    <i class="bi bi-tags"></i> Types de Produits
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/produits') ? 'active' : ''}" href="/produits">
                    <i class="bi bi-box"></i> Produits
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/produits-du-mois') ? 'active' : ''}" href="/produits-du-mois">
                    <i class="fas fa-star"></i> Produits du Mois
                </a>
                <ul class="nav flex-column ms-3">
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.requestURI.contains('/produits-du-mois/add') ? 'active' : ''}" href="/produits-du-mois/add">
                            <i class="fas fa-plus"></i> Nouvelle Promotion
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.view == 'expiring' ? 'active' : ''}" href="/produits-du-mois?view=expiring">
                            <i class="fas fa-clock"></i> Promotions Expirantes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.view == 'expired' ? 'active' : ''}" href="/produits-du-mois?view=expired">
                            <i class="fas fa-history"></i> Historique
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/clients') ? 'active' : ''}" href="/clients">
                    <i class="bi bi-people"></i> Clients
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/stocks') ? 'active' : ''}" href="/stocks">
                    <i class="bi bi-archive"></i> Stocks
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/ingredients') ? 'active' : ''}" href="/ingredients">
                    <i class="bi bi-egg"></i> Ingrédients
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/unites') ? 'active' : ''}" href="/unites">
                    <i class="bi bi-rulers"></i> Unités
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/formules') ? 'active' : ''}" href="/formules">
                    <i class="bi bi-journal-text"></i> Formules
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('/ventes') ? 'active' : ''}" href="/ventes">
                    <i class="bi bi-cash-coin"></i> Ventes
                </a>
            </li>
        </ul>
    </div>
    
    <div class="main-content"> 