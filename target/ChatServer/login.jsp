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
    <link rel="stylesheet" type="text/css" href="css/LoginStyle.css">
    <title>Login</title>
</head>

<body onload="setDefaultImage();">

<form class="attachmentsUpload">
    <h2>Login</h2>
    <div class="user-img">
        <input type="file" id="upload" class="file" name="upload"
               style="visibility: hidden; margin: 0px 0px 0px 0px; width: 0px; height: 0px"/>
        <img id="userphoto" onclick="getphoto();" class="centered-and-cropped" width="100" height="100"
             style="border-radius:50%; cursor: hand; box-shadow: 0 3px 6px 0 rgba(0, 0, 0, 0.2)">
        <div></div>
    </div>
    <input id="username" class="username" name="username" placeholder="Username" type="text" required>
    <label hidden>Male</label>
    <button onclick="openSocket();"> Login</button>

    <script type="text/javascript">
        function setDefaultImage() {
            var img = document.getElementById("userphoto");
            img.src = 'images/default_photo.png';
        }

        function getphoto() {
            document.getElementById("upload").click();
        }
    </script>

    <script type="text/javascript">

        var webSocket;
        var messages = document.getElementById("username");
        var nick;


        function openSocket() {
            // Ensures only one connection is open at a time
            if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
                alert("WebSocket is already opened.");
                return;
            }
            nick = document.getElementById("username").value;
            // Create a new instance of the websocket
            var url = "ws://localhost:27015/login/" + nick;
            webSocket = new WebSocket(url);
            alert(url);//-Без этого тупо не работает, но нужно это исправить

            /**
             * Binds functions to the listeners for the websocket.
             */
            webSocket.onopen = function (event) {
                if (event.data === undefined)
                    return;
            };

            webSocket.onmessage = function (event) {
//                alert(event.data);
                if (event.data === "OK") {
                    localStorage.setItem("_nick", nick);
                    window.location = "http://localhost:27015/chat.jsp";
                } else {
                    alert("Error!");
                }

            };

            webSocket.onclose = function (event) {
                alert("Connection closed");
            };
        }

        /**
         * Sends the value of the text input to the server
         */

        function closeSocket() {
            webSocket.close();
        }


    </script>

</form>

</body>

</html>