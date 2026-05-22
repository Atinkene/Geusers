<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="beans.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
    String erreur = (String) request.getAttribute("erreur");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un utilisateur</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .form-container {
            width: 400px;
            margin: 60px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }
        input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
            box-sizing: border-box;
        }
        input:focus {
            outline: none;
            border-color: #333;
        }
        input:disabled {
            background: #f0f0f0;
            cursor: not-allowed;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }
        button {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button[type="submit"] {
            background: #000;
            color: white;
        }
        button[type="submit"]:hover {
            background: #333;
        }
        button[type="button"] {
            background: #6c757d;
            color: white;
        }
        button[type="button"]:hover {
            background: #5a6268;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            border: 1px solid #f5c6cb;
        }
        .required {
            color: red;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Modifier un utilisateur</h2>

    <% if (erreur != null) { %>
        <div class="error"><%= erreur %></div>
    <% } %>

    <form method="post" action="modifier">
    
        <input type="hidden" name="id" value="<%= utilisateur != null ? utilisateur.getId() : "" %>" />

        <div class="form-group">
            <label for="prenom">Prénom</label>
            <input type="text" 
                   id="prenom" 
                   name="prenom" 
                   value="<%= utilisateur != null ? utilisateur.getPrenom() : "" %>" 
                   required 
                   maxlength="50" />
        </div>

        <div class="form-group">
            <label for="nom">Nom</label>
            <input type="text" 
                   id="nom" 
                   name="nom" 
                   value="<%= utilisateur != null ? utilisateur.getNom() : "" %>" 
                   required 
                   maxlength="50" />
        </div>

        <div class="form-group">
            <label for="login">Login</label>
            <input type="text" 
                   id="login" 
                   name="login" 
                   value="<%= utilisateur != null ? utilisateur.getLogin() : "" %>" 
                   required 
                   maxlength="30" />
        </div>

        <div class="form-group">
            <label for="password">Mot de passe</label>
            <input type="password" 
                   id="password" 
                   name="password" 
                   value="<%= utilisateur != null ? utilisateur.getPassword() : "" %>" 
                   required 
                   minlength="4" />
        </div>

        <div class="button-group">
            <button type="button" onclick="window.location.href='list'">Annuler</button>
            <button type="submit">Enregistrer</button>
        </div>
    </form>
</div>

</body>
</html>