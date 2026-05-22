<%-- Component: modal-edit — user edit form --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="modal-overlay" id="modal-edit" onclick="closeOnOverlay(event, 'modal-edit')">
    <div class="modal">

        <div class="modal-header">
            <h2 class="modal-title">Edit user</h2>
            <button class="modal-close" onclick="closeModal('modal-edit')">&times;</button>
        </div>

        <%-- Validation error --%>
        <c:if test="${not empty editError}">
            <div class="alert-error">${editError}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/edit-user"
              method="post"
              class="modal-form">

            <input type="hidden" id="edit-id" name="id" value="${not empty editUser ? editUser.id : ''}" />

            <div class="form-row">
                <div class="field">
                    <label for="edit-firstName">First name</label>
                    <input type="text"
                           id="edit-firstName"
                           name="firstName"
                           value="${not empty editUser ? editUser.firstName : ''}"
                           maxlength="50"
                           required />
                </div>
                <div class="field">
                    <label for="edit-lastName">Last name</label>
                    <input type="text"
                           id="edit-lastName"
                           name="lastName"
                           value="${not empty editUser ? editUser.lastName : ''}"
                           maxlength="50"
                           required />
                </div>
            </div>

            <div class="field">
                <label for="edit-username">Username</label>
                <input type="text"
                       id="edit-username"
                       name="username"
                       value="${not empty editUser ? editUser.username : ''}"
                       minlength="3"
                       maxlength="30"
                       pattern="[a-zA-Z0-9_]+"
                       required />
            </div>

            <div class="field">
                <label for="edit-password">New password</label>
                <input type="password"
                       id="edit-password"
                       name="password"
                       minlength="4"
                       required />
            </div>

            <div class="modal-footer">
                <button type="button"
                        class="btn-cancel"
                        onclick="closeModal('modal-edit')">Cancel</button>
                <button type="submit" class="btn-submit">Save changes</button>
            </div>

        </form>
    </div>
</div>
