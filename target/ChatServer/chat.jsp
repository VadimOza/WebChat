<%--
  Created by IntelliJ IDEA.
  User: maksy
  Date: 26-Mar-16
  Time: 7:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/alertbox.css">
</head>

<body onload="openSocket()">
<div id="sound"></div><!-- Ta Da -->

<div class="container clearfix">
    <div class="people-list" id="people-list">
        <div class="search">
            <input type="text" placeholder="search"/>
            <i class="fa fa-search"></i>
        </div>
        <div id="user_list">
            <ul class="list">
                <li class="clearfix">
                    <img style="border-radius: 50% 50% 50% 50%" src="images/o.png" alt="avatar"/>
                    <div class="about">
                        <div class="name">Olia Porter</div>
                        <div class="status">
                            <i class="fa fa-circle online"></i>online
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <div class="chat">
        <div class="chat-header clearfix">
            <img style="border-radius: 50% 50% 50% 50%" src="images/o.png" alt="avatar"/>
            <div class="chat-about">
                <div class="chat-with">Olia Porter</div>
                <div id="chat-num-messages" class="chat-num-messages"><p id="pcount"></p></div>
            </div>
        </div> <!-- end chat-header -->

        <div class="chat-history">
            <ul>

                <!-- не я -->
                <li class="clearfix">
                    <div class="message-data align-right">
                        <span class="message-data-time">10:10 AM, Today</span> &nbsp; &nbsp;
                        <span class="message-data-name">Olia</span> <i class="fa fa-circle me"></i>
                    </div>
                    <div class="message my-message float-right">
                        Hi Vincent
                    </div>
                </li>

                <!-- я -->
                <li>
                    <div class="message-data">
                        <span class="message-data-name"><i class="fa fa-circle online"></i> Vincent</span>
                        <span class="message-data-time">10:12 AM, Today</span>
                    </div>
                    <div class="message other-message">
                        Hi
                    </div>
                </li>

            </ul>

        </div> <!-- end chat-history -->

        <div class="chat-message clearfix">
            &nbsp;&nbsp;&nbsp;
            <textarea name="message-to-send" id="message-to-send" placeholder="Type your message"
                      rows="3"></textarea>
            <div style="float:left;">
                <button style="color: orange;" id="log_button">Log out</button>
            </div>
            <div style="float:right;">
                <button style="padding-right: 0px" id="send_button" onclick="send();">Send</button>
            </div>

        </div> <!-- end chat-message -->

    </div> <!-- end chat -->

</div> <!-- end container -->

<script>
    elements = document.querySelector("#user_list")
            .querySelector("ul")
            .querySelectorAll("li")

    chng = function () {
        for (var i = 0; i < elements.length; i++) {
            elements[i].getElementsByClassName('name')[0].innerHTML;
        }
        alert(this.getElementsByClassName('name')[0].innerHTML);
    };
    [].forEach.call(elements, function (el) {
        el.onclick = chng;
    })
</script>

<script id="message-template" type="text/x-handlebars-template">
    <li class="clearfix">
        <div class="message-data align-right">
            <span id="dt" class="message-data-time">{{time}}, {{day}}</span> &nbsp; &nbsp;
            <span class="message-data-name">Olia</span> <i class="fa fa-circle me"></i>
        </div>
        <div class="message my-message float-right">
            <!--тут вст. текст-->
            {{messageOutput}}
        </div>
    </li>
</script>

<script id="joinuser" type="text/x-handlebars-template">
    <li>
        <div>
            <center>
                <hr style="width:60%;">
                <span class="join-date">{{jointime}}</span>
                <hr style="width:5%;">
                <br>
                <span class="join-name">{{username}}</span>
                <br><br>
            </center>
        </div>
    </li>
</script>

<script id="message-response-template" type="text/x-handlebars-template">
    <li>
        <div class="message-data">
            <span class="message-data-name"><i class="fa fa-circle online"></i> Vincent</span>
            <span class="message-data-time">{{time}}, {{day}}</span>
        </div>
        <div class="message other-message">
            {{response}}
        </div>
    </li>
</script>

<div id="messages"></div>

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
        webSocket.onOpen = function(event){
            if(event.data === undefined)
                return;
            if(event.data === "NO!"){
                webSocket.close();
                window.location="http://localhost:27015/login.jsp";
            }
            writeResponse(event.data);
        };

        webSocket.onMessage = function(event){
            alert("Boo")
            writeResponse(event.data);
        };

        webSocket.onClose = function(event){
            writeResponse("Connection closed");
        };
    }

    /**
     * Sends the value of the text input to the server
     */
    function send(){
        alert("S")
        var text = document.getElementById("message-to-send").value;
        document.getElementById("message-to-send").value = "";
        webSocket.send(text);
    }

    function closeSocket(){
        alert("CS")
        webSocket.close();
    }

    function writeResponse(text){
        alert("WR "+text)
        var templateResponse = Handlebars.compile($("#message-response-template").html());
        var contextResponse = {
            response: text,
            time: 0,
            day: 0
        };


        this.$chatHistory = $('.chat-history');
        this.$chatHistoryList = this.$chatHistory.find('ul');

        this.$chatHistoryList.append(templateResponse(contextResponse));
        this.$chatHistory.scrollTop(this.$chatHistory[0].scrollHeight);
    }
</script>

<script src='js/jquery.min.js'></script>
<script src='js/handlebars.min.js'></script>
<script src='js/list.min.js'></script>
<script src="js/index.js"></script>
</body>
</html>
