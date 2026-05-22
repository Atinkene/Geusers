<%-- Component: modal-add — user creation form --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="modal-overlay" id="modal-add" onclick="closeOnOverlay(event, 'modal-add')">
    <div class="modal">

        <div class="modal-header">
            <h2 class="modal-title">New user</h2>
            <button class="modal-close" onclick="closeModal('modal-add')">&times;</button>
        </div>

        <%-- Validation error --%>
        <c:if test="${not empty addError}">
            <div class="alert-error">${addError}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/add-user"
              method="post"
              class="modal-form">

            <div class="form-row">
                <div class="field">
                    <label for="add-firstName">First name</label>
                    <input type="text"
                           id="add-firstName"
                           name="firstName"
                           value="${not empty addFirstName ? addFirstName : ''}"
                           maxlength="50"
                           required />
                </div>
                <div class="field">
                    <label for="add-lastName">Last name</label>
                    <input type="text"
                           id="add-lastName"
                           name="lastName"
                           value="${not empty addLastName ? addLastName : ''}"
                           maxlength="50"
                           required />
                </div>
            </div>

            <div class="field">
                <label for="add-username">Username</label>
                <input type="text"
                       id="add-username"
                       name="username"
                       value="${not empty addUsername ? addUsername : ''}"
                       minlength="3"
                       maxlength="30"
                       pattern="[a-zA-Z0-9_]+"
                       title="Letters, digits and underscores only"
                       required />
            </div>

            <div class="field">
                <label for="add-password">Password</label>
                <input type="password"
                       id="add-password"
                       name="password"
                       minlength="4"
                       required />
            </div>

            <div class="modal-footer">
                <button type="button"
                        class="btn-cancel"
                        onclick="closeModal('modal-add')">Cancel</button>
                <button type="submit" class="btn-submit">Create user</button>
            </div>

        </form>
    </div>
</div>
