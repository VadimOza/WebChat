var cMess = 0;
var webSocket;
var messages = document.getElementById("messages");
var usrnm;

$(document).ready(function () {
    document.getElementById("pcount").innerHTML = "already " + cMess + " messages";
    openSocket();
});

function openSocket() {
    // Ensures only one connection is open at a time
    if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
        writeResponse("WebSocket is already opened.");
        return;
    }
    // Create a new instance of the websocket
    var nick = localStorage.getItem("_nick");
    document.getElementById("usernameepta").innerHTML = nick;
    var url = "ws://localhost:27015/server/" + nick;
    webSocket = new WebSocket(url);
    usrnm = nick;
    /**
     * Binds functions to the listeners for the websocket.
     */
    webSocket.onopen = function (event) {
        if (event.data === undefined)
            return;
        if (event.data === "NO!") {
            webSocket.close();
            window.location = "http://localhost:27015/login.jsp";
        }
        writeResponse(event.data);
    };

    webSocket.onmessage = function (event) {
        writeResponse(event.data);
    };

    webSocket.onclose = function (event) {
        writeResponse("Connection closed");
    };
};
function closeSocket() {
    webSocket.close();
};
function writeResponse(text) {

    if (~text.indexOf("{{newuser}}")) {
        var template = Handlebars.compile($("#joinuser").html());
        var u = text.substring(text.indexOf('{{newuser}}') + 11, text.indexOf('{{/newuser}}'));
        var d = text.substring(text.indexOf('{{date}}') + 8, text.indexOf('{{/date}}'));
        var context = {
            username: u + ' has joined the chat',
            jointime: d
        };
        this.$chatHistory = $('.chat-history');
        this.$chatHistoryList = this.$chatHistory.find('ul');

        this.$chatHistoryList.append(template(context));
        this.$chatHistory.scrollTop(this.$chatHistory[0].scrollHeight);
    } else {
        var user = text.substr(text.indexOf('{{username}}') + 12, text.indexOf('{{/username}}') - 12);
        var message = text.substring(text.indexOf('{{mes}}') + 7, text.indexOf('{{mesend}}'));
        var time = text.substring(text.indexOf('{{time}}') + 8, text.indexOf('{{timeend}}'));
        var day = text.substring(text.indexOf('{{day}}') + 7, text.indexOf('{{dayend}}'));

        if (user.localeCompare(usrnm)) {
            var templateResponse = Handlebars.compile($("#message-response-template").html());
        } else {
            var templateResponse = Handlebars.compile($("#message-template").html());
        }
        var contextResponse = {
            user: user,
            message: message,
            time: time,
            day: day
        };


        this.$chatHistory = $('.chat-history');
        this.$chatHistoryList = this.$chatHistory.find('ul');

        this.$chatHistoryList.append(templateResponse(contextResponse));
        this.$chatHistory.scrollTop(this.$chatHistory[0].scrollHeight);
    }
}
;

(function () {
    var chat = {
        messageToSend: '',
        init: function () {
            this.cacheDOM();
            this.bindEvents();
            this.render();
        },
        cacheDOM: function () {
            this.$chatHistory = $('.chat-history');
            this.$button_s = $('#send_button');
            this.$button_l = $('#log_button');
            this.$textarea = $('#message-to-send');
            this.$chatHistoryList = this.$chatHistory.find('ul');
        }
        ,
        bindEvents: function () {
            this.$button_l.on('click', this.logOut.bind(this));
            this.$button_s.on('click', this.addMessage.bind(this));
            this.$textarea.on('keyup', this.addMessageEnter.bind(this));
        },
        render: function () {
            if (this.messageToSend.trim().toLowerCase() == 'та да') {
                this.playTaDa();
            }
            if (this.messageToSend.trim().toLowerCase() == 'я сильно удивлен') {
                this.playDaNu();
            }
            if (this.messageToSend.trim().toLowerCase() == 'согласен') {
                this.playOch();
            }
        },
        countMessages: function (cMess) {
            document.getElementById("pcount").innerHTML = "already " + cMess + " messages";
        },
        playTaDa: function () {
            document.getElementById("sound").innerHTML = '<audio ' +
                'autoplay="autoplay"><source src="tada.mp3" type="audio/mpeg" />' +
                '<embed hidden="true" autostart="true" loop="false" src="tada.mp3" />' +
                '</audio>';
        },
        playDaNu: function () {
            document.getElementById("sound").innerHTML = '<audio ' +
                'autoplay="autoplay"><source src="danu.mp3" type="audio/mpeg" />' +
                '<embed hidden="true" autostart="true" loop="false" src="danu.mp3" />' +
                '</audio>';
        },
        playOch: function () {
            document.getElementById("sound").innerHTML = '<audio ' +
                'autoplay="autoplay"><source src="och.mp3" type="audio/mpeg" />' +
                '<embed hidden="true" autostart="true" loop="false" src="och.mp3" />' +
                '</audio>';
        },
        logOut: function () {
            this.$button_l.alertBox({href: 'login.jsp'})
        },
        addMessage: function () {
            this.messageToSend = this.$textarea.val();
            if (this.messageToSend.trim() !== '') {
                this.render();
                // this.joinUser();
                this.$textarea.val('')
                webSocket.send(this.messageToSend + "{{mesend}}{{time}}" + this.getCurrentTime() + "{{timeend}}" + "{{day}}" + this.getCurrentDay() + "{{dayend}}");
                cMess++;
                this.countMessages(cMess);
            }
        },
        addMessageEnter: function (event) {
            // enter was pressed
            if (event.keyCode === 13) {
                this.addMessage();
            }
        },
        scrollToBottom: function () {
            this.$chatHistory.scrollTop(this.$chatHistory[0].scrollHeight);
        },
        getCurrentTime: function () {
            return new Date().toLocaleTimeString().replace(/([\d]+:[\d]{2})(:[\d]{2})(.*)/, "$1$3");
        },
        getCurrentDay: function () {
            var d = new Date();
            var weekday = new Array(7);
            weekday[0] = "Sunday";
            weekday[1] = "Monday";
            weekday[2] = "Tuesday";
            weekday[3] = "Wednesday";
            weekday[4] = "Thursday";
            weekday[5] = "Friday";
            weekday[6] = "Saturday";

            var name = weekday[d.getDay()];

            return name;
        }
    };

    chat.init();

    var searchFilter = {
        options: {valueNames: ['name']},
        init: function () {
            var userList = new List('people-list', this.options);
            var noItems = $('<li id="no-items-found">No items found</li>');

            userList.on('updated', function (list) {
                if (list.matchingItems.length === 0) {
                    $(list.list).append(noItems);
                } else {
                    noItems.detach();
                }
            });
        }
    };

    searchFilter.init();

})();

(function ($) {

    $.fn.extend({

        alertBox: function (settings) {

            var defaults = {
                href: null
            };

            var settings = $.extend(defaults, settings);

            return this.each(function () {

                var s = settings;
                var load = 'alert.html';

                $(this).click(function (e) {

                    e.preventDefault();

                    $('body').append('<div id="overlay" />');
                    $('#overlay').fadeIn(300, function () {
                        $('body').append('<div id="alertModalOuter"><div id="alertModal"></div></div>');
                        var outer = $('#alertModalOuter');
                        var modal = $('#alertModal');
                        var defWidth = outer.outerWidth();
                        var defHeight = outer.outerHeight();
                        modal.load(load + ' #alert', function () {

                            var alertBoxContent = $('#alert');

                            var alertWidth = alertBoxContent.outerWidth();
                            var alertHeight = alertBoxContent.outerHeight();

                            var widthCombine = -((defWidth + alertWidth) / 2);
                            var heightCombine = -((defHeight + alertHeight) / 2);

                            modal.animate({width: alertWidth, height: alertHeight}, 200);
                            outer.animate({marginLeft: widthCombine, marginTop: heightCombine}, 200, function () {
                                alertBoxContent.fadeIn(200, function () {
                                    $('#yes').click(function (e) {
                                        e.preventDefault();
                                        window.location.href = s.href;
                                    });
                                    $('#no').click(function (e) {
                                        e.preventDefault();
                                        $('#overlay, #alertModalOuter').fadeOut(400, function () {
                                            $(this).remove();
                                        });
                                    });
                                });
                            });

                        });
                    });
                });
            });
        }
    });
})(jQuery);
