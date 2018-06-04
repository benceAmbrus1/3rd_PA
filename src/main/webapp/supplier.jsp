<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="main.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>App</title>
    </head>
<body>

<div id="supplier-content" class="employee content">
    <h1>Profile</h1>

    <p>Supplier id: ${supplier.id}</p>
    <p>Company name: ${supplier.companyName}</p>
    <p>Contact name: ${supplier.contactName}</p>
    <p>Contact Title: ${supplier.contactTitle}</p>

<div>

<div id="logout-content" class="hidden content">
    <button id="logout-button">Logout</button>
</div>

</body>
</html>
