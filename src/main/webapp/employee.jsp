<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="utils.js"></script>
        <script type="text/javascript" src="employee.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>App</title>
    </head>
<body>
<div id="employee-content" class="employee content">
    <h1>Profile</h1>

    <p>Employee id: ${user.id}</p>
    <p>First name: ${user.fName}</p>
    <p>Last name: ${user.lName}</p>
    <p>Title: ${user.title}</p>
</div>


<div id="territories-content" class="hidden content">
</div>

<div id="terr-button-content" class="hidden content">
    <button id="territories-button">View territories</button>
</div>

<div id="subordinates-content" class="hidden content">
</div>

<div id="sub-button-content" class="hidden content">
    <button id="subordinates-button">Subordinates</button>
</div>

<div id="logout-content" class="hidden content">
    <button id="logout-button">Logout</button>
</div>

<div id="goBack-content" class="hidden content">
    <button id="goBack-button">Go Back</button>
</div>


</body>
</html>
