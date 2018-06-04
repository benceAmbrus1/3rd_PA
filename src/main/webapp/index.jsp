<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>App</title>
    </head>
<body>

<h1>NORTHWIND DATABASE</h1>
<h2>Employee Login</h2>
<form method="POST" action="loginServlet">
    <input type="hidden" name="type" value="employee">
    <input type="text" name="id" value="">
    <input type="submit" class="submit" value="Login">
</form>

<h2>Supplier Login</h2>
<form method="POST" action="loginServlet">
    <input type="hidden" name="type" value="supplier">
    <input type="text" name="id" value="">
    <input type="submit" class="submit" value="Login">
</form>

<div id="error" class="error">
    <p>${error}</p>
</div>

</body>
</html>
