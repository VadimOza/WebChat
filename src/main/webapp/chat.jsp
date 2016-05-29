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
    <script src="Moment.js"></script>
    <script>moment().format();</script>
    <script type="text/javascript" src="chatScripts.js"></script>
    <title>Chat</title>
</head>

<body onload="first()">
<script>
    var sDate;
    var cUser;
    $(window).load(function () {
        sDate = moment();
        cUser = 'Tom';
    });

    function sMessage(){
        var msgText = $('#msgline').val();
        var cDate = moment().format('h:mm A');
        $("ol").append("<li class='me'><div class='avatar-icon'><img src='icon2.jpg'></div><div class='messages'><p align='left'>"+msgText+"</p><time>"+cUser+" - "+cDate+"</time></div></li>");
        return false;
    }

    function runScript(e) {
        if (e.keyCode == 13) {
            sMessage();
            return false;
        }
    }

    $(document).ready(function(){
        $("#send").click(function(){
            sMessage();
            return false;
        });
    });
</script>

<div style="text-align: center; align-items: flex-start">
    <form class="main">
        <h1>
            <div class="topbox">
                <div class="container-2">
                    <img id="userphoto" width="80" height="80"
                         src="http://cs8.pikabu.ru/post_img/big/2016/03/28/7/1459160229186915267.jpg">
                </div>
                <div class="container-4">
                    <label id="username"></label>
                </div>
                <!-- <form action="LogoutServlet" method="post"> -->
                <div class="container-3">
                    <button id="logout" onclick="form.action='LogoutServlet'">Logout</button>
                </div>
                <!-- </form> -->
            </div>
        </h1>
        <h3>
            <div class="chatbox">
                <!--  -->
                <section class='chat-container'>
                    <ol class='chat-box'>
                        <li class='another'>
                            <div class='avatar-icon'>
                                <img src='icon2.jpg'>
                            </div>
                            <div class='messages'>
                                <p>Hi</p>
                                <time datetime='2009-11-13T20:00'>Tom - 51 min</time>
                            </div>
                        </li>
                    </ol>
                </section>
                <!--  -->
            </div>
        </h3>
        <div>
            <h2>
                <div class="downbox">
                    <div class="container-5">
                        <input id="msgline" name="message" type="text" placeholder="Input message..."
                               autocomplete="off" onkeypress="return runScript(event)">
                    </div>
                    <div class="container-6">
                        <!-- <form action="SendServlet" method="post"> -->
                        <button id="send" onclick="">Send</button>
                        <!-- </form> -->
                    </div>
                </div>
            </h2>
        </div>
    </form>
    <!-- <form class="online">
        <h1>
        <div class="box">
            <div class="container-1">
                <input type="search" id="search" placeholder="&#x2004;&#x2004;&#x1F50E;" autocomplete="off"/>
            </div>
        </div>
    </h1>
        <iframe class="useronline" scrolling="auto">

        </iframe>
    </form> -->
</div>
<script type="text/javascript">
    var webSocket;
    function first() {
        var nick =  localStorage.getItem("_nick");
        document.getElementById("username").innerHTML = nick;
        webSocket = localStorage.getItem("_webSocket");
    }
//
//    function send() {
//        var message = document.getElementById("msgline").value;
//        webSocket.send(message);
//    }
</script>
</body>

</html>
