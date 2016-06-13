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
    <%--<meta name="viewport" content="width=device-width">--%>
</head>

<body>

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
                <div class="chat-with"><p id="usernameepta"></p></div>
                <div id="chat-num-messages" class="chat-num-messages"><p id="pcount"></p></div>
            </div>
        </div> <!-- end chat-header -->

        <div class="chat-history">
            <ul id="m">
                <%--Message--%>
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
                <button style="padding-right: 0px" id="send_button">Send</button>
            </div>

        </div> <!-- end chat-message -->

    </div> <!-- end chat -->

</div> <!-- end container -->

<!-- Server responses get written here -->
<div id="messages"></div>

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
            <span class="message-data-name">{{user}}</span> <i class="fa fa-circle me"></i>
        </div>
        <div class="message my-message float-right">
            <!--тут вст. текст-->
            {{message}}
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
            <span class="message-data-name"><i class="fa fa-circle online"></i>{{user}}</span>
            <span class="message-data-time">{{time}}, {{day}}</span>
        </div>
        <div class="message other-message">
            {{message}}
        </div>
    </li>
</script>
<script src='js/jquery.min.js'></script>
<script src='js/handlebars.min.js'></script>
<script src='js/list.min.js'></script>
<script src="js/index.js"></script>
<script src="//twemoji.maxcdn.com/twemoji.min.js"></script>

<script type="text/javascript">
//    var div = document.createElement('div');
//    div.textContent = 'I \u2764\uFE0F emoji!';
//    document.body.appendChild(div);
//
//    twemoji.parse(document.body);
//
//    var img = div.querySelector('img');
//
//    // note the div is preserved
//    img.parentNode === div; // true
//
//    img.src;        // abs.twimg.com/emoji/v1/36x36/2764.png
//    img.alt;        // \u2764\uFE0F
//    img.class;      // emoji
//    img.draggable;  // false
</script>

</body>
</html>
