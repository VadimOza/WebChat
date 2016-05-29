<%--
  Created by IntelliJ IDEA.
  User: Вадим
  Date: 5/29/2016
  Time: 3:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Echo Chamber</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
</head>
<body onload="openSocket();">

<div>
    <textarea rows="20" cols="40" id="textarea"></textarea>
    <input type="text" id="message"/>
</div>
<div>
    <
    <button type="button" onclick="send();" >Send</button>

</div>
<!-- Server responses get written here -->
<div id="messages"></div>

<!-- Script to utilise the WebSocket -->
<script type="text/javascript">

    var webSocket;
    var messages = document.getElementById("messages");


    function openSocket(){
        // Ensures only one connection is open at a time
        if(webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED){
            writeResponse("WebSocket is already opened.");
            return;
        }
        // Create a new instance of the websocket
        var nick = localStorage.getItem("_nick");
        var url = "ws://localhost:27015/server/"+nick;
        webSocket = new WebSocket(url);

        /**
         * Binds functions to the listeners for the websocket.
         */
        webSocket.onopen = function(event){
            // For reasons I can't determine, onopen gets called twice
            // and the first time event.data is undefined.
            // Leave a comment if you know the answer.
            if(event.data === undefined)
                return;
            if(event.data === "NO!"){
                webSocket.close();
                window.location="http://localhost:27015/login.jsp";
            }
            writeResponse(event.data);
        };

        webSocket.onmessage = function(event){
            writeResponse(event.data);
        };

        webSocket.onclose = function(event){
            writeResponse("Connection closed");
        };
    }

    /**
     * Sends the value of the text input to the server
     */
    function send(){
        var text = document.getElementById("message").value;
        document.getElementById("message").value = "";
        webSocket.send(text);
    }

    function closeSocket(){
        webSocket.close();
    }

    function writeResponse(text){
        document.getElementById("textarea").value += text;
    }

</script>

</body>
</html>
