<%-- Component: header --%>
<%-- Expects: no specific attributes --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="app-header">

    <%-- Brand --%>
    <div class="header-brand">
        <span class="brand-logo">GE</span><span class="brand-name">USERS</span>
    </div>

    <%-- Search --%>
    <div class="header-search">
        <form action="${pageContext.request.contextPath}/list" method="get">
            <div class="search-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
                </svg>
                <input type="text"
                       name="search"
                       placeholder="Search users..."
                       value="${not empty param.search ? param.search : ''}"
                       autocomplete="off" />
            </div>
        </form>
    </div>

    <%-- Actions --%>
    <div class="header-actions">
        <span class="current-user">
            &#9675; &nbsp;${sessionScope.currentUser.fullName}
        </span>
        <button class="btn-add" onclick="openModal('modal-add')">
            + Add user
        </button>
        <a class="btn-logout" href="${pageContext.request.contextPath}/logout">
            Sign out
        </a>
    </div>

</header>
