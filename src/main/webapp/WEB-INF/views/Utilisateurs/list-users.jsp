<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GEUSERS — Users</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --black:    #0a0a0a;
            --white:    #f5f5f0;
            --gray:     #8a8a8a;
            --gray-lt:  #e8e8e4;
            --border:   #d4d4d0;
            --success:  #1a6b3c;
            --error:    #c0392b;
            --accent:   #0a0a0a;
        }

        body {
            font-family: 'DM Mono', monospace;
            background: var(--white);
            color: var(--black);
            min-height: 100vh;
        }

        /*  Header  */
        .app-header {
            position: sticky;
            top: 0;
            z-index: 100;
            background: var(--black);
            color: var(--white);
            display: grid;
            grid-template-columns: 200px 1fr auto;
            align-items: center;
            padding: 0 32px;
            height: 60px;
            gap: 24px;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 2px;
        }

        .brand-logo {
            font-family: 'Syne', sans-serif;
            font-size: 22px;
            font-weight: 800;
            color: var(--white);
        }

        .brand-name {
            font-family: 'Syne', sans-serif;
            font-size: 22px;
            font-weight: 800;
            color: var(--gray);
        }

        .header-search .search-box {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 6px;
            padding: 8px 14px;
            max-width: 400px;
            margin: 0 auto;
        }

        .header-search svg { color: var(--gray); flex-shrink: 0; }

        .header-search input {
            background: transparent;
            border: none;
            outline: none;
            color: var(--white);
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            width: 100%;
        }

        .header-search input::placeholder { color: var(--gray); }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .current-user {
            font-size: 12px;
            color: var(--gray);
            white-space: nowrap;
        }

        .btn-add {
            background: var(--white);
            color: var(--black);
            border: none;
            border-radius: 6px;
            padding: 8px 16px;
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            white-space: nowrap;
            transition: opacity 0.2s;
        }

        .btn-add:hover { opacity: 0.85; }

        .btn-logout {
            font-size: 12px;
            color: var(--gray);
            text-decoration: none;
            transition: color 0.2s;
        }

        .btn-logout:hover { color: var(--white); }

        /*  Main content  */
        .main {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 32px;
        }

        /*  Alerts  */
        .alert {
            padding: 12px 18px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 24px;
        }

        .alert-success {
            background: #edfaf3;
            border-left: 3px solid var(--success);
            color: var(--success);
        }

        .alert-error {
            background: #fdf2f2;
            border-left: 3px solid var(--error);
            color: var(--error);
        }

        /*  Toolbar (sort + count)  */
        .toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .toolbar-left {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .toolbar-label {
            font-size: 11px;
            color: var(--gray);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-right: 4px;
        }

        .sort-btn {
            background: transparent;
            border: 1.5px solid var(--border);
            border-radius: 5px;
            padding: 6px 12px;
            font-family: 'DM Mono', monospace;
            font-size: 12px;
            cursor: pointer;
            color: var(--black);
            display: flex;
            align-items: center;
            gap: 5px;
            transition: border-color 0.2s, background 0.2s;
            text-decoration: none;
        }

        .sort-btn:hover,
        .sort-btn.active {
            background: var(--black);
            color: var(--white);
            border-color: var(--black);
        }

        .sort-arrow { font-size: 10px; }

        .toolbar-count {
            font-size: 12px;
            color: var(--gray);
        }

        /*  Table ─ */
        .table-wrapper {
            background: white;
            border-radius: 10px;
            border: 1.5px solid var(--border);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead th {
            background: var(--black);
            color: var(--white);
            padding: 14px 20px;
            text-align: left;
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        tbody tr {
            border-bottom: 1px solid var(--gray-lt);
            transition: background 0.15s;
        }

        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #fafaf8; }

        tbody td {
            padding: 14px 20px;
            font-size: 13px;
            vertical-align: middle;
        }

        .td-id {
            color: var(--gray);
            font-size: 12px;
            width: 60px;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            background: var(--black);
            color: var(--white);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 500;
            margin-right: 10px;
            vertical-align: middle;
        }

        .td-actions {
            text-align: right;
            white-space: nowrap;
        }

        .action-btn {
            background: transparent;
            border: 1.5px solid var(--border);
            border-radius: 5px;
            padding: 5px 12px;
            font-family: 'DM Mono', monospace;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
            color: var(--black);
        }

        .action-btn:hover {
            background: var(--black);
            color: var(--white);
            border-color: var(--black);
        }

        .action-btn.danger:hover {
            background: var(--error);
            border-color: var(--error);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--gray);
            font-size: 13px;
        }

        /*  Pagination ─ */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 28px;
        }

        .page-btn {
            min-width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1.5px solid var(--border);
            border-radius: 5px;
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            cursor: pointer;
            text-decoration: none;
            color: var(--black);
            transition: all 0.2s;
            padding: 0 10px;
        }

        .page-btn:hover,
        .page-btn.active {
            background: var(--black);
            color: var(--white);
            border-color: var(--black);
        }

        .page-btn.disabled {
            opacity: 0.35;
            pointer-events: none;
        }

        /*  Modal ─ */
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(10,10,10,0.55);
            z-index: 200;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(3px);
        }

        .modal-overlay.open { display: flex; }

        .modal {
            background: white;
            border-radius: 12px;
            width: 100%;
            max-width: 480px;
            padding: 32px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            animation: slideUp 0.2s ease;
        }

        @keyframes slideUp {
            from { transform: translateY(16px); opacity: 0; }
            to   { transform: translateY(0);    opacity: 1; }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .modal-title {
            font-family: 'Syne', sans-serif;
            font-size: 22px;
            font-weight: 800;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 22px;
            cursor: pointer;
            color: var(--gray);
            line-height: 1;
            padding: 4px;
        }

        .modal-close:hover { color: var(--black); }

        .modal-form .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .modal-form .field {
            margin-bottom: 16px;
        }

        .modal-form label {
            display: block;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--gray);
            margin-bottom: 6px;
        }

        .modal-form input {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid var(--border);
            border-radius: 6px;
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            transition: border-color 0.2s;
        }

        .modal-form input:focus {
            outline: none;
            border-color: var(--black);
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 8px;
        }

        .btn-cancel {
            background: transparent;
            border: 1.5px solid var(--border);
            border-radius: 6px;
            padding: 10px 20px;
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            border-color: var(--black);
        }

        .btn-submit {
            background: var(--black);
            color: white;
            border: 1.5px solid var(--black);
            border-radius: 6px;
            padding: 10px 20px;
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            cursor: pointer;
            transition: opacity 0.2s;
        }

        .btn-submit:hover { opacity: 0.8; }
    </style>
</head>
<body>

<%--  Header component ─ --%>
<jsp:include page="components/_header.jsp" />

<main class="main">

    <%--  Flash messages ─ --%>
    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success">${sessionScope.success}</div>
        <c:remove var="success" scope="session" />
    </c:if>

    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-error">${sessionScope.error}</div>
        <c:remove var="error" scope="session" />
    </c:if>

    <%--  Toolbar ─ --%>
    <div class="toolbar">

        <div class="toolbar-left">
            <span class="toolbar-label">Sort</span>

            <a class="sort-btn ${param.sort == 'firstName' ? 'active' : ''}"
               href="?sort=firstName&order=${param.sort == 'firstName' && param.order == 'asc' ? 'desc' : 'asc'}&search=${param.search}&page=${param.page}">
                First name
                <span class="sort-arrow">
                    ${param.sort == 'firstName' ? (param.order == 'asc' ? '↑' : '↓') : '↕'}
                </span>
            </a>

            <a class="sort-btn ${param.sort == 'lastName' ? 'active' : ''}"
               href="?sort=lastName&order=${param.sort == 'lastName' && param.order == 'asc' ? 'desc' : 'asc'}&search=${param.search}&page=${param.page}">
                Last name
                <span class="sort-arrow">
                    ${param.sort == 'lastName' ? (param.order == 'asc' ? '↑' : '↓') : '↕'}
                </span>
            </a>

            <a class="sort-btn ${param.sort == 'username' ? 'active' : ''}"
               href="?sort=username&order=${param.sort == 'username' && param.order == 'asc' ? 'desc' : 'asc'}&search=${param.search}&page=${param.page}">
                Username
                <span class="sort-arrow">
                    ${param.sort == 'username' ? (param.order == 'asc' ? '↑' : '↓') : '↕'}
                </span>
            </a>
        </div>

        <span class="toolbar-count">
            ${fn:length(users)} user${fn:length(users) != 1 ? 's' : ''}
        </span>

    </div>

    <%--  User table  --%>
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>First name</th>
                    <th>Last name</th>
                    <th>Username</th>
                    <th style="text-align:right">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td class="td-id">${u.id}</td>
                                <td>
                                    <span class="user-avatar">
                                        ${fn:substring(u.firstName, 0, 1)}${fn:substring(u.lastName, 0, 1)}
                                    </span>
                                    ${u.firstName}
                                </td>
                                <td>${u.lastName}</td>
                                <td>${u.username}</td>
                                <td class="td-actions">
                                    <button class="action-btn"
                                            onclick="openEditModal(
                                                ${u.id},
                                                '${u.firstName}',
                                                '${u.lastName}',
                                                '${u.username}'
                                            )">
                                        Edit
                                    </button>
                                    <a class="action-btn danger"
                                       href="${pageContext.request.contextPath}/delete-user?id=${u.id}"
                                       onclick="return confirmDelete('${u.fullName}')">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="empty-state">
                                No users found. Click "+ Add user" to get started.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <%--  Pagination  --%>
    <c:if test="${totalPages > 1}">
        <div class="pagination">

            <%-- Previous --%>
            <a class="page-btn ${currentPage <= 1 ? 'disabled' : ''}"
               href="?page=${currentPage - 1}&sort=${param.sort}&order=${param.order}&search=${param.search}">
                &larr;
            </a>

            <%-- Page numbers --%>
            <c:forEach begin="1" end="${totalPages}" var="p">
                <a class="page-btn ${p == currentPage ? 'active' : ''}"
                   href="?page=${p}&sort=${param.sort}&order=${param.order}&search=${param.search}">
                    ${p}
                </a>
            </c:forEach>

            <%-- Next --%>
            <a class="page-btn ${currentPage >= totalPages ? 'disabled' : ''}"
               href="?page=${currentPage + 1}&sort=${param.sort}&order=${param.order}&search=${param.search}">
                &rarr;
            </a>

        </div>
    </c:if>

</main>

<%--  Modals  --%>
<jsp:include page="components/_modal-add.jsp" />
<jsp:include page="components/_modal-edit.jsp" />

<script>
    //  Modal controls 
    function openModal(id)
    {
        document.getElementById(id).classList.add('open');
    }

    function closeModal(id)
    {
        document.getElementById(id).classList.remove('open');
    }

    function closeOnOverlay(event, id)
    {
        if (event.target === document.getElementById(id)) closeModal(id);
    }

    //  Prefill edit modal 
    function openEditModal(id, firstName, lastName, username)
    {
        document.getElementById('edit-id').value        = id;
        document.getElementById('edit-firstName').value = firstName;
        document.getElementById('edit-lastName').value  = lastName;
        document.getElementById('edit-username').value  = username;
        document.getElementById('edit-password').value  = '';
        openModal('modal-edit');
    }

    //  Delete confirmation 
    function confirmDelete(fullName)
    {
        return confirm('Delete user "' + fullName + '"?\nThis action cannot be undone.');
    }

    //  Auto-open modal on validation error 
    <c:if test="${not empty addError}">
        openModal('modal-add');
    </c:if>

    <c:if test="${not empty editError}">
        openModal('modal-edit');
    </c:if>

    //  Escape key closes modals 
    document.addEventListener('keydown', function(e)
    {
        if (e.key === 'Escape')
        {
            closeModal('modal-add');
            closeModal('modal-edit');
        }
    });
</script>

</body>
</html>
