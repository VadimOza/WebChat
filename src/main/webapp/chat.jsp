<%--
  Created by IntelliJ IDEA.
  User: maksy
  Date: 26-Mar-16
  Time: 7:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>

</style>
<head>
    <link rel="stylesheet" type="text/css" href="Style/ChatStyle.css">
    <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="chatScripts.js"></script>
    <title>Chat</title>
</head>
<body>

<div style="text-align: center; align-items: flex-start">
    <form class="main">
        <h1>
            <div class="topbox">
                <div class="container-2">
                    <img id="userphoto" width="80" height="80"
                         src="http://cs8.pikabu.ru/post_img/big/2016/03/28/7/1459160229186915267.jpg">
                </div>
                <div class="container-4">
                    <label id="username">UserName</label>
                </div>
                <!-- <form action="LogoutServlet" method="post"> -->
                <div class="container-3">
                    <button id="logout" onclick="form.action='LogoutServlet'">Logout</button>
                </div>
                <!-- </form> -->
            </div>
        </h1>
        <h2>
            <div class="downbox">
                <div class="container-5">
                    <input id="msgline" name="message" type="text" placeholder="Input message..." autocomplete="off">
                </div>
                <div class="container-6">
                    <!-- <form action="SendServlet" method="post"> -->
                    <button id="send" onclick="form.action='Server';form.method='post'">Send</button>
                    <!-- </form> -->
                </div>
            </div>
        </h2>
    </form>
    <form class="online">
        <h1>
            <div class="box">
                <div class="container-1">
                    <input type="search" id="search" placeholder="&#x2004;&#x2004;&#x1F50E;" autocomplete="off"/>
                </div>
            </div>
        </h1>
        <iframe class="useronline" scrolling="auto">

        </iframe>
    </form>
</div>
</body>
</html>
