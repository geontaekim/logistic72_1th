<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Grobal Electornic</title>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/StaticFiles/img/camera.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/StaticFiles/css/loginForm.css">
    <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/loginForm.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/timeDisplay.js" defer></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body style="background-color: white;">

<%session.invalidate();%> <!-- session 만료 -->
<%--O avatar--%>

<section id="home">
    <div class="home__avatar">
        <img src="${pageContext.request.contextPath}/StaticFiles/img/sample1.jpg" style="width: 800px;height: 400px;">
    </div>
    <div class="time__display" style="font-size: 45px; font-style: oblique; color: black; ">
        <div class="time-text">16:54</div>
        <div class="date-text">Sunday, November 03</div>
    </div>
</section>
<%--O loginForm--%>
<section id="loginForm">
    <div class="loginForm__content">
        <form id="form">
            <h2 class="title" style="color: black;  font-style: oblique;">72th Project</h2>
				<div><input type ="hidden" class="input" name="companyCode" id="companyCode" autocomplete="off"></div>
<!--             <div class="input-div company">
                <div class="i">
                    <i class="fas fa-building"></i>
                </div>
                <div class="div">
                    <h5>Company Code</h5>
                    <input type="text" class="input" name="companyCode" id="companyCode" autocomplete="off">
                    <button type="button" class="search" id="companyList"data-toggle="modal" data-target="#myModal">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div> -->
            <div class="input-div workplace">
                <div class="i">
                    <i class="fas fa-industry"></i>
                </div>
                <div class="div">
                    <h5>Workplace Code</h5>
                    <input type="text" class="input" name="workplaceCode" id="workplaceCode" autocomplete="off" style="color: black;  font-style: oblique;">
                    <button type="button" class="search" id="workplaceList" data-toggle="modal" data-target="#myModal2" style="background-color: white;">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="input-div user">
                <div class="i">
                    <i class="fas fa-user"></i>
                </div>
                <div class="div">
                    <h5>Username</h5>
                    <input type="text" class="input" name="userId" autocomplete="off" style="color: black;  font-style: oblique;">
                </div>
            </div>
            <div class="input-div pass">
                <div class="i">
                    <i class="fas fa-lock"></i>
                </div>
                <div class="div">
                    <h5>Password</h5>
                    <input type="password" class="input" name="userPassword" autocomplete="off" style="color: black;  font-style: oblique;">
                </div>
            </div>
            <div class="check">
                <input id="checkId" type="checkbox" name="rmb">
                <label for="checkId" style="color: black;  font-style: oblique;">ID 기억하기</label>
            </div>
            <button type="button" class="btn btn-primary" id="login" style="background-color: #006600; outline: none">LOGIN</button>
        </form>
    </div>
</section>
<%--O companyModal--%><!-- 
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

        Modal content
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">COMPANY</h4>
            </div>
            <div class="modal-body">
                <div id="companyListGrid" class="ag-theme-balham"  style="height:500px;width:auto;" >
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div> -->
<%--O workplaceModal--%>
<div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">WORKPLACE</h4>
            </div>
            <div class="modal-body">
                <div id="workplaceListGrid" class="ag-theme-balham"  style="height:500px;width:auto;" >
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>

