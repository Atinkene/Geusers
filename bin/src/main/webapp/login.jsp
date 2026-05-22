<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GEUSERS — Sign in</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --black:   #0a0a0a;
            --white:   #f5f5f0;
            --gray:    #8a8a8a;
            --border:  #d4d4d0;
            --error:   #c0392b;
        }

        body {
            font-family: 'DM Mono', monospace;
            background: var(--white);
            color: var(--black);
            height: 100vh;
            display: grid;
            grid-template-columns: 1fr 1fr;
        }

        /* Left panel */
        .panel-left {
            background: var(--black);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 48px;
            position: relative;
            overflow: hidden;
        }

        .panel-left::before {
            content: 'GEUSERS';
            position: absolute;
            font-family: 'Syne', sans-serif;
            font-size: 120px;
            font-weight: 800;
            color: rgba(255,255,255,0.04);
            bottom: -20px;
            left: -10px;
            line-height: 1;
            pointer-events: none;
        }

        .brand {
            font-family: 'Syne', sans-serif;
            font-size: 28px;
            font-weight: 800;
            color: var(--white);
            letter-spacing: -0.5px;
        }

        .brand span { color: var(--gray); }

        .tagline {
            color: var(--gray);
            font-size: 13px;
            line-height: 1.8;
            max-width: 280px;
        }

        .tagline strong {
            display: block;
            color: var(--white);
            font-size: 22px;
            font-family: 'Syne', sans-serif;
            margin-bottom: 12px;
            line-height: 1.2;
        }

        /* Right panel */
        .panel-right {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px;
        }

        .form-wrapper {
            width: 100%;
            max-width: 360px;
        }

        .form-title {
            font-family: 'Syne', sans-serif;
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 8px;
            letter-spacing: -1px;
        }

        .form-subtitle {
            color: var(--gray);
            font-size: 13px;
            margin-bottom: 40px;
        }

        /* Error message */
        .alert-error {
            background: #fdf2f2;
            border-left: 3px solid var(--error);
            color: var(--error);
            padding: 12px 16px;
            font-size: 13px;
            margin-bottom: 24px;
            border-radius: 0 4px 4px 0;
        }

        /* Form fields */
        .field {
            margin-bottom: 20px;
        }

        .field label {
            display: block;
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: var(--gray);
            margin-bottom: 8px;
        }

        .field input {
            width: 100%;
            padding: 12px 16px;
            border: 1.5px solid var(--border);
            border-radius: 6px;
            font-family: 'DM Mono', monospace;
            font-size: 14px;
            background: white;
            color: var(--black);
            transition: border-color 0.2s;
        }

        .field input:focus {
            outline: none;
            border-color: var(--black);
        }

        /* Submit button */
        .btn-submit {
            width: 100%;
            padding: 14px;
            background: var(--black);
            color: var(--white);
            border: 1.5px solid var(--black);
            border-radius: 6px;
            font-family: 'DM Mono', monospace;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            letter-spacing: 0.5px;
            transition: background 0.2s, color 0.2s;
            margin-top: 8px;
        }

        .btn-submit:hover {
            background: transparent;
            color: var(--black);
        }

        /* Footer links */
        .form-footer {
            margin-top: 28px;
            display: flex;
            justify-content: center;
            gap: 20px;
            font-size: 12px;
            color: var(--gray);
        }

        .form-footer a {
            color: var(--gray);
            text-decoration: none;
            transition: color 0.2s;
        }

        .form-footer a:hover { color: var(--black); }

        .form-footer span { color: var(--border); }

        @media (max-width: 768px) {
            body { grid-template-columns: 1fr; }
            .panel-left { display: none; }
        }
    </style>
</head>
<body>

    <%-- Left decorative panel --%>
    <div class="panel-left">
        <div class="brand">GE<span>USERS</span></div>
        <div class="tagline">
            <strong>User management,<br>simplified.</strong>
            Secure access to your user directory.
        </div>
    </div>

    <%-- Right login panel --%>
    <div class="panel-right">
        <div class="form-wrapper">

            <h1 class="form-title">Sign in</h1>
            <p class="form-subtitle">Enter your credentials to continue</p>

            <%-- Error message via EL --%>
            <c:if test="${not empty error}">
                <div class="alert-error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">

                <div class="field">
                    <label for="username">Username</label>
                    <input type="text"
                           id="username"
                           name="username"
                           placeholder="your_username"
                           value="${not empty param.username ? param.username : ''}"
                           required
                           autocomplete="username" />
                </div>

                <div class="field">
                    <label for="password">Password</label>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="••••••••"
                           required
                           autocomplete="current-password" />
                </div>

                <button class="btn-submit" type="submit">Sign in &rarr;</button>

            </form>

            <div class="form-footer">
                <a href="#">Forgot password</a>
                <span>|</span>
                <a href="#">No account yet</a>
            </div>

        </div>
    </div>

</body>
</html>
