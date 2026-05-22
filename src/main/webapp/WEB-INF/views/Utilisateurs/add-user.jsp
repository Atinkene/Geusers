<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un utilisateur</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }
        .form-container {
            width: 400px;
            margin: 60px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            background: black;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background: gray;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Ajouter un utilisateur</h2>

    <form method="post">

        <input type="text" name="prenom" placeholder="Prénom" required />

        <input type="text" name="nom" placeholder="Nom" required />

        <input type="text" name="login" placeholder="Login" required />

        <input type="password" name="password" placeholder="Mot de passe" required />

        <button type="submit">Enregistrer</button>

    </form>
</div>

</body>
</html>
