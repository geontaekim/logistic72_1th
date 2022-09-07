<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="decorator"
           uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html>
<head>
    <title>Estimulo71</title>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
            href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap"
            rel="stylesheet">
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/StaticFiles/css/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/StaticFiles/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/StaticFiles/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/popper.js"></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/bootstrap.min.js"></script>
    <style type="text/css">
        h5 {
            font-family: 'Noto Sans KR', sans-serif;
        }

        .img {
            margin-bottom: 15px !important;
        }
        .music_box {
            width: 50%;
            height: 30%;
            text-align: center;
            display: inline-block;
        }
        #music_select{
            border-radius: 40px;
            width: 250px;
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
        .inputTable th{
            padding: 5px;
        }
        .inputTable input{
            width: 330px;
            height: 25px;
        }
    </style>
    <sitemesh:write property='head' />
</head>
<body>
<c:if test="${sessionID != null }">

    <script>
        var audio = new Audio('${pageContext.request.contextPath}/music/cool.mp3');

        /*추가된 부분: 종료되면 처음부터 다시 재생*/
        audio.addEventListener('ended', function() {
            this.currentTime = 0;
            this.play();
        }, false);

    </script>

    <script>

        $(document).ready(function () {
            $("#music_start").click(start);
        });

        function start() {
            const music_title = document.querySelector("#music_list").value;

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



    <div class="wrapper d-flex align-items-stretch">
        <nav id="sidebar">
            <div class="p-4 pt-5">
                <a href="/hello3/view" class="img logo rounded-circle mb-5"
                   style="background-image: url('${pageContext.request.contextPath}/StaticFiles/img/myung.png')"></a>

                <p style="text-align: center">👩🏻‍💼
                        ${sessionScope.empName}${sessionScope.positionName}님 환영합니다.</p>

                <!-- 메뉴 -->
                <div>${sessionScope.allMenuList}</div>

                <div class="music_box">
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
                    <%--<embed src='${pageContext.request.contextPath}/music/cool.mp3' hidden="true" autostart="true" loop="infinite" ><embed>--%>
                    <button id="music_start">▶</button>
                    <br/>
                    <div id="music_bar"></div>
                    <div id="music_title"></div>
                </div>
                <div class="footer">
                    <p>
                        경상남도 진주시 가좌길 74-6 <br />혜람빌딩 7층
                    </p>
                    <p>
                        Tel : 010 - 4606 - 4283 <br />Email: wleek2@gmail.com
                    </p>
                </div>
            </div>
        </nav>



        <!-- Page Content  -->
        <div id="content" class="p-1 p-md-3">
                ${sessionScope.allMenuList_b}
            <nav class="navbar navbar-expand-sm navbar-light bg-light">
                <div class="container-fluid">
                    <button type="button" id="sidebarCollapse" class="btn btn-primary">
                        <i class="fa fa-bars"></i> <span class="sr-only">Toggle
								Menu</span>
                    </button>
                    <button class="btn btn-dark d-inline-block d-lg-none ml-auto"
                            type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent" aria-expanded="false"
                            aria-label="Toggle navigation">
                        <i class="fa fa-bars"></i>
                        <!-- 메뉴 토글 버튼  -->
                    </button>

                    <!-- nav 메뉴 -->
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            ${sessionScope.navMenuList}</div>
                    <div class="navbar-header">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/hr/logout">로그아웃</a>
                    </div>
                </div>
            </nav>

            <sitemesh:write property='body' />
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            let menuList = new Array();
            <c:forEach var="menu" items="${sessionScope.authorityGroupMenuList}">
            menuList.push("${menu}");
            </c:forEach>

            $(".m").on('click', function (event) {

                if(!menuList.includes(this.id)){
                    swal.fire({
                        text: "접근권한이 없습니다.",
                        icon: "error",
                    });
                    return false;
                }
            });
        });
    </script>
</c:if>
<c:if test="${sessionID == null}">
    <script>
        location.href="${pageContext.request.contextPath}/hr/loginForm/view"
    </script>
</c:if>
<script src="${pageContext.request.contextPath}/StaticFiles/js/main.js"></script>
</body>




</html>