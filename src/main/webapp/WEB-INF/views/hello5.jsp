<%--
  Created by IntelliJ IDEA.
  User: tjdwl
  Date: 2022-07-06
  Time: 오후 2:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body{
            background-color: white;
        }
        .music_box {
            border: 1px solid white;
            width: 50%;
            height: 30%;
            text-align: center;
            display: inline-block;
        }

        .music_box h2 {
            margin-top: 40px;
        }


        #music_select{
            border-radius: 40px;
        }

        .container{
            border: 1px solid white;
            color: #FFBB00;
            display: inline-block;
            text-align: left;
        }
        .container h1{
            text-align: left;
            padding: 5px 5px 5px 15px;
            color: pink;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .roomContainer{
            background-color: #F6F6F6;
            width: 500px;
            height: 500px;
            overflow: auto;
        }
        .roomList{
            border: none;
        }
        .roomList th{
            border: 1px solid #FFBB00;
            background-color: #fff;
            color: #FFBB00;
        }
        .roomList td{
            border: 1px solid #FFBB00;
            background-color: #fff;
            text-align: left;
            color: #FFBB00;
        }
        .roomList .num{
            width: 75px;
            text-align: center;
        }
        .roomList .room{
            width: 350px;
        }
        .roomList .go{
            width: 71px;
            text-align: center;
        }
        button{
            background-color: #FFBB00;
            font-size: 14px;
            color: #000;
            border: 1px solid #000;
            border-radius: 5px;
            padding: 3px;
            margin: 3px;
        }
        .inputTable th{
            padding: 5px;
        }
        .inputTable input{
            width: 330px;
            height: 25px;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <script>

        $(document).ready(function () {
            $("#music_start").click(start);
        });

        function start() {
            const music_title = document.querySelector("#music_list").value;
            $("#music_title").html(
                "<h1 style='color:white'>" + music_title + "</h1>"
            );
            $("#music_bar").html(
                "<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_title + ".mp3' autoplay controls>" +
                "<source src='https://cdn.jsdelivr.net/gh/sh20raj/AudiPlay/Ark.mp3' type='audio/mp3'/></audio>"
            );
            const music_id = document.getElementById("music_select");
            music_id.addEventListener("ended", function () {
                let cnt = 0;
                nextMusic();
                cnt++;
            });
        }

        function nextMusic() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[1] + ".mp3' autoplay controls onended='nextMusic2()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[1] + "</h1>"
            );


        }

        function nextMusic2() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[2] + ".mp3' autoplay controls onended='nextMusic3()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[2] + "</h1>"
            );
        }

        function nextMusic3() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[3] + ".mp3' autoplay controls onended='nextMusic4()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[3] + "</h1>"
            );
        }

        function nextMusic4() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[4] + ".mp3' autoplay controls onended='nextMusic5()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[4] + "</h1>"
            );
        }

        function nextMusic5() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[5] + ".mp3' autoplay controls onended='nextMusic6()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[5] + "</h1>"
            );
        }

        function nextMusic6() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[6] + ".mp3' autoplay controls onended='nextMusic7()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[6] + "</h1>"
            );
        }

        function nextMusic7() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[7] + ".mp3' autoplay controls onended='nextMusic8()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[7] + "</h1>"
            );
        }

        function nextMusic8() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[8] + ".mp3' autoplay controls onended='nextMusic9()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[8] + "</h1>"
            );
        }

        function nextMusic9() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[9] + ".mp3' autoplay controls onended='nextMusic10()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[9] + "</h1>"
            );
        }

        function nextMusic10() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[10] + ".mp3' autoplay controls onended='nextMusic11()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'> " + music_list[10] + "</h1>"
            );
        }

        function nextMusic11() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[11] + ".mp3' autoplay controls onended='nextMusic12()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'> " + music_list[11] + "</h1>"
            );
        }

        function nextMusic12() {
            $("#music_bar").html("<audio id ='music_select' src='${pageContext.request.contextPath}/mp3/" + music_list[0] + ".mp3' autoplay controls onended='nextMusic()'></audio>");
            $("#music_title").html(
                "<h1 style='color:white'>" + music_list[0] + "</h1>"
            );
        }


    </script>
</head>
<body>
<div class="music_box">
    <h2 style="color: white;">음악감상</h2>
    <select name="music_list" id="music_list">
        <script>
            const music_list = [
                "송이한-안녕이라는 말", "양다일-미안해"
                , "전우성-축가", "경서예지-사실 나는"
                , "트와이스-Fancy", "아이브-Love Dive"
                , "숀-Way back home", "빅나티-낭만교향곡"
                , "조유리-러브 쉿", "브레이브걸스-롤린"
                , "빅나티-벤쿠버", "우원재-향수"
            ];
            music_list.forEach(element => {
                document.write("<option value='" + element + "'>" + element + "</option>");
            });
        </script>
    </select>

    <button id="music_start">재생</button>
    <br/>
    <div id="music_bar"></div>
    <div id="music_title"></div>
</div>

<div class="container">
    <h1>채팅방</h1>
    <div id="roomContainer" class="roomContainer">
        <table id="roomList" class="roomList"></table>
    </div>
    <div>
        <table class="inputTable">
            <tr>
                <th>방 제목</th>
                <th><input type="text" name="roomName" id="roomName"></th>
                <th><button id="createRoom">방 만들기</button></th>
            </tr>
        </table>
    </div>
</div>
</body>
</html>


