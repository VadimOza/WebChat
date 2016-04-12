<%--
  Created by IntelliJ IDEA.
  User: maksy
  Date: 26-Mar-16
  Time: 12:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<style>

</style>

<head>
    <link rel="stylesheet" type="text/css" href="Style/LoginStyle.css">
    <title>Login</title>
</head>

<body>

<form action="LoginServlet" method="get">
    <h2>Login</h2>
    <input id="username" name="username" placeholder="Username" type="text" required>
    <input type="file" name="file1">
    <label hidden>Male</label>
    <button> Login  </button>
</form>

</body>

</html>