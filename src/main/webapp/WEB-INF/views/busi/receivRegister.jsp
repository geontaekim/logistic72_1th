<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="J2H" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <script src="${pageContext.request.contextPath}/StaticFiles/js/datepicker.js" defer></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/datepickerUse.js" defer></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/StaticFiles/css/datepicker.css">
    <!--   ========datepicker style 적용=====================================================================    -->
    <script>
        $(function () {
            let end = new Date();
            let year = end.getFullYear();              //yyyy
            let month = (1 + end.getMonth());          //M
            month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
            let day = end.getDate();                   //d
            day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
            end =   year + '' + month + '' + day;
            //$('#datepicker').text(year + '-' + month + '-' + day);
            // o set searchDate
            $('#datepicker').datepicker({
                startDate: '-1d',
                endDate: end,
                todayHiglght: true,
                autoHide: true,
                autoaShow: true,
            })
        })

    </script>
    <style>
        * {
            margin: 0px;
        }

        h5 {
            margin-top: 3px;
            margin-bottom: 3px;
        }

        input {
            padding: 2px 0 2px 0;
            text-align: center;
            border-radius: 3px;
        }

        .ag-header-cell-label {
            justify-content: center;
        }
        .ag-cell-value {
            padding-left: 50px;
        }

        .estimate {
            margin-bottom: 10px;
        }

        .estimateDetail {
            margin-bottom: 10px;
        }

        .menuButton {
            margin-top: 10px;
        }

        .menuButton button {
            background-color: #006600;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            border-radius: 3px;
        }

        .menuButton__selectCode {
            display: inline-block;
        }
    </style>
</head>
<!--   =============================================================================================================    -->
<body>
<article class="estimate">
    <div class="estimate_Title">
        <h5 style="color: black;">📋 수금등록</h5>
        <span style="color: black">수금등록일자</span><br/>
        <input type="text" id="datepicker" placeholder="YYYY-MM-DD👀" size="15" autocomplete="off" style="text-align: center">
        <div class="menuButton">
            <button id="estimateInsertButton" onclick="addRow(this)">수금추가</button>
            <button id="estimateDeleteButton" onclick="deleteRow(this)">견적삭제</button>
            <button id="batchSaveButton" style=" float:right;  background-color:#F15F5F"  >수금등록</button>
            <div class="menuButton__selectCode">
                <button class="search" id="customerList" data-toggle="modal"
                        data-target="#listModal">거래처코드
                </button>
            </div>
        </div>
    </div>
</article>
<article class="estimateGrid">
    <div align="center">
        <div id="myGrid" class="ag-theme-balham" style="height:100px; width:auto; text-align: center;"></div>
    </div>
</article>
<article class="estimateDetail">
    <div class="estimateDetail__Title">
        <h5 >📋 수금내역</h5>
        <div class="menuButton">
            <button id="estimateDetailInsertButton" onclick="addRow(this)">수금상세추가</button>
            <button id="estimateDetailDeleteButton" onclick="deleteRow(this)">수금상세삭제</button>
            <div class="menuButton__selectCode">
                <button id="checkstock">재고확인</button>
                <button class="search" id="deliveryList" data-toggle="modal"
                        data-target="#listModal">증빙번호</button>
                <button class="search" id="divReceivList" data-toggle="modal"
                        data-target="#listModal">수급구분</button>
            </div>
        </div>
    </div>
</article>
<article class="estimateDetailGrid">
    <div align="center" class="ss">
        <div id="myGrid2" class="ag-theme-balham" style="height:50vh;width:auto;"></div>
    </div>
</article>

<J2H:listModal/>    <!-- 조회 모달 --> <!-- 견적상세등록 제목 바로 밑에 있는 버튼이 아니라 ag-Grid 큰 표에 있는 컬럼명? 이라고 볼 수 있다. -->

<!----------------------- 재고확인 모달 ------------------------------------->
<div class="modal fade" id="warehousingModal" role="dialog">
    <div class="modal-dialog modal-xl">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">
                    <h5>STOCK</h5>

                </div>
                <button type="button" class="close" data-dismiss="modal" style="padding-top: 0.5px">&times;</button>
            </div>
            <div class="modal-body">
                <div id="warehousingGrid3" class="ag-theme-balham" style="height: 40vh;width:auto;">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%--Amount Modal--%>
<div class="modal fade" id="amountModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">AMOUNT</h5>
                <button type="button" class="close" data-dismiss="modal" style="padding-top: 0.5px">&times;</button>
            </div>
            <div class="modal-body">
                <div style="width:auto; text-align:left">
                    <label style='font-size: 20px; margin-right: 10px'>견적수량</label>
                    <input type='text' id='estimateAmountBox'  autocomplete="off"/><br>
                    <label for='unitPriceOfEstimateBox' style='font-size: 20px; margin-right: 10px'>견적단가</label>
                    <input type='text' id='unitPriceOfEstimateBox' autocomplete="off"/><br>
                    <label for='sumPriceOfEstimateBox' style='font-size: 20px; margin-right: 30px'>합계액  </label>
                    <input type="text" id='sumPriceOfEstimateBox' autocomplete="off"></input>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id ="amountSave" class="btn btn-default" data-dismiss="modal">Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!--  ============================================================================================================ -->
<script>
    const myGrid = document.querySelector('#myGrid');
    const myGrid2 = document.querySelector('#myGrid2');
    const checkstock = document.querySelector('#checkstock');
    const datepicker = document.querySelector('#datepicker');
    const customerList = document.querySelector('#customerList');
    const deliveryList = document.querySelector('#deliveryList');
    const batchSaveButton = document.querySelector("#batchSaveButton");
    const divReceivList = document.querySelector('#divReceivList');


    // O setup the grid after the page has finished loading
    document.addEventListener('DOMContentLoaded', () => { // 브라우저가 로드되기 전에 밑에 agGrid가 먼저 로드된다. 이것이 DOMContentLoaded
        new agGrid.Grid(myGrid, divGridOptions); // 첫번째 Grid에 divGridOptions이  걸려있다고 보면 된다.
        new agGrid.Grid(myGrid2, div2GridOptions);  // 두번째 Grid에 estDetailGridOptions가 걸린다.*/
        showReceivGrid();
    })
    //================================================================================
    // O DATEPICKER    => dbClick 하면 할 수 있게끔
    function getDatePicker(paramFmt) {
        let _this = this;
        _this.fmt = "yyyy-mm-dd";
        console.log("_this???"+_this);

        // function to act as a class
        function Datepicker() {
        }

        // gets called once before the renderer is used
        Datepicker.prototype.init = function (params) {
            // create the cell
            this.autoclose = true;
            this.eInput = document.createElement('input');
            this.eInput.style.width = "100%";
            this.eInput.style.border = "0px";
            this.cell = params.eGridCell;
            this.oldWidth = this.cell.style.width;
            this.cell.style.width = this.cell.previousElementSibling.style.width;
            this.eInput.value = params.value;
            // Setting startDate and endDate
            console.log("paramFmt???"+paramFmt);
            let _startDate = datepicker.value;
            let _endDate = new Date(_startDate);
            let days = 14; // 유효 일자는 현재일자 + 14일
            if (paramFmt == "dueDateOfEstimate") {
                _startDate = new Date(_startDate)
                days = 9;
                _startDate.setTime(_startDate.getTime() + days * 86400000);
                let dd = _startDate.getDate();
                let mm = _startDate.getMonth() + 1; //January is 0!
                let yyyy = _startDate.getFullYear();
                _startDate = yyyy + '-' + mm + '-' + dd;
                console.log(_startDate);
                _endDate = new Date(_startDate);
                days = 19;
            }
            _endDate.setTime(_endDate.getTime() + days * 86400000);
            let dd = _endDate.getDate();
            let mm = _endDate.getMonth() + 1; //January is 0!
            let yyyy = _endDate.getFullYear();
            _endDate = yyyy + '-' + mm + '-' + dd;

            $(this.eInput).datepicker({
                dateFormat: _this.fmt,
                startDate: _startDate,
                endDate: _endDate,
            }).on('change', function () {
                divGridOptions.api.stopEditing();
                estDetailGridOptions.api.stopEditing();
                $(".datepicker-container").hide();
            });
        };
        // gets called once when grid ready to insert the element
        Datepicker.prototype.getGui = function () {
            return this.eInput;
        };
        // focus and select can be done after the gui is attached
        Datepicker.prototype.afterGuiAttached = function () {
            this.eInput.focus();
            console.log(this.eInput.value);
        };

        // returns the new value after editing
        Datepicker.prototype.getValue = function () {
            console.log(this.eInput);
            return this.eInput.value;
        };

        // any cleanup we need to be done here
        Datepicker.prototype.destroy = function () {
            divGridOptions.api.stopEditing();
        };

        return Datepicker;
    }

    // ======= myGridoptions ===========================================================
    // O customerList Grid
    let divColumn = [
        {headerName: "수금일자", field: "estimateDate" ,hide:true },
        {headerName: "거래처명", field: "customerName", editable: true},
        {headerName: "거래처코드", field: "customerCode", editable: true ,hide:true },
        {headerName: "견적담당자코드", field: "personCodeInCharge", hide: true},
        {headerName: "견적요청자", field: "estimateRequester", editable: true},
        {headerName: "증빙번호", field: "deliveryNo", editable: true},
        {headerName: "수급구분", field: "divReceive", editable: true },
        {headerName: "선수금", field: "advRecived", editable: true }
    ];
    let divRowData = [];
    // event.colDef.field
    let divGridOptions = {
        columnDefs: divColumn,
        rowSelection: 'single',
        rowData: divRowData,
        getRowNodeId: function (data) {
            return data.estimateDate;
        },
        defaultColDef: {editable: false},
        overlayNoRowsTemplate: "추가된 견적이 없습니다.",
        onGridReady: function (event) {// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
            event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
            event.api.sizeColumnsToFit();
        },
        onCellEditingStarted: (event) => { // 거래처명을 클릭했을 때 걸려있는 이벤트
            if (event.colDef.field == "customerName") { //만약 필드이름이 cutomerName거래처명인 경우 밑의 click메서드 실행
                customerList.click();
            }else if (event.colDef.field == "deliveryNo"){
                deliveryList.click();
            }else if (event.colDef.field == "divReceive"){
                divReceivList.click();
            }
        },
        getSelectedRowData() {
            let selectedNodes = this.api.getSelectedNodes();
            let selectedData = selectedNodes.map(node => node.data);
            return selectedData;
        },
        components: {
            datePicker1: getDatePicker("effectiveDate"),
        }
    }

    checkstock.addEventListener("click", () => {
        _setStockModal();
        getStockModal();
        $("#warehousingModal").modal('show');
    });

    let _setStockModal = (function() {
        let executed = false;
        return function() {
            if (!executed) {
                executed = true;
                setStockModal();
            }
        };
    })();


    let div2Column = [
        {headerName: "수금일자", field: "estimateDate" },
        {headerName: "거래처명", field: "customerName", editable: true},
        {headerName: "견적담당자코드", field: "personCodeInCharge", hide: true},
        {headerName: "견적요청자", field: "estimateRequester", editable: true},
        {headerName: "증빙번호", field: "deliveryNo", editable: true},
        {headerName: "수급구분", field: "divReceive", editable: true },
        {headerName: "선수금", field: "advRecived", editable: true }
    ];
    let div2RowData = [];
    // event.colDef.field
    let div2GridOptions = {
        columnDefs: div2Column,
        rowSelection: 'single',
        rowData: div2RowData,
        getRowNodeId: function (data) {
            return data.estimateDate;
        },
        defaultColDef: {editable: false},
        overlayNoRowsTemplate: "추가된 견적이 없습니다.",
        onGridReady: function (event) {// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
            event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
            event.api.sizeColumnsToFit();
        }

    }

    const showReceivGrid = () => {
        let xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/receiv/receivedCashlist'
            ,true)
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.send();
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let txt = xhr.responseText;
                txt = JSON.parse(txt);
                if (txt.errorCode < 0) {
                    swal.fire("오류", txt.errorMsg, "error");
                    return;
                }
                console.log(txt);
                div2GridOptions.api.setRowData(txt.gridRowJson);
            }
        }
    }


    // ====================================================================================================================
    // O add and Delete function 추가,삭제버튼 함수
    function addRow(event) {  // o 견적추가버튼
        if (event.id == "estimateInsertButton") {
            if (datepicker.value == "") { // 예외처리와 흡사
                Swal.fire({
                    text: "수금일자를 등록하셔야합니다.",
                    icon: "info",
                });
                // datepicker.value 가 빈문자열이라면 견적일자 등록 문구를 띄우고 함수를 빠져나옴
                return;
            }  else if (divGridOptions
                .api.getDisplayedRowCount() > 0) {   // 견적추가를 제대로 하나 하지 않고 버튼을 또 누를 경우
                Swal.fire({ //아직 처리하지 않은 견적이 있으면 그리드에 행이 남아있기 때문이다.
                    text: "처리하지 않은 수금이 있습니다.",
                    icon: "info",
                });
                return;
            }

            let row = {     // 그냥 견적추가, 값을 받아오는 아이
                estimateDate: datepicker.value,  // estimateDate: 견적일자
                personCodeInCharge: "${sessionScope.empCode}",  // personCodeInCharge: 견적담당자코드  위에서 선언되어 있는 거 찾아오면 됨.
                personNameCharge: "${sessionScope.empName}",   // 'ag-Grid에 띄워지는 아이들의 값을 받아온다'고 볼 수 있다.
                estimateRequester: "${sessionScope.empName}",
                description: "",
                advRecived:""
            };
            divGridOptions.api.updateRowData({add: [row]});  // 위에서 받아온 값을 updateRowData에 추가시킨다. 이렇게 되면 agGrid의 형태가띄워지게 된다.
            // 이 위까지는 견적추가 이벤트
        }
    }
    //---------------------------------------------------------------------------------------
    function deleteRow(event) { // o 견적삭제 버튼
        let selected = divGridOptions.api.getFocusedCell();                   // 견적
        if (selected == undefined) {
            Swal.fire({
                text: "선택한 행이 없습니다.",
                icon: "info",
            })
            return;
        }
        if (event.id == "estimateDeleteButton") {
            divGridOptions.rowData.splice(selected.rowIndex, 1);
            divGridOptions.api.setRowData(divGridOptions.rowData);
        } else if (event.id == "estimateDetailDeleteButton"){
            console.log("견적상세삭제");
            let selectedRows = estDetailGridOptions.api.getSelectedRows();
            console.log("선택된 행" + selectedRows );
            selectedRows.forEach( function(selectedRow, index) {
                console.log(selectedRow);
                //     detailItemCode.splice(detailItemCode.indexOf(selectedRow.itemCode), 1); // 배열요소 제거
                estDetailGridOptions.api.updateRowData({remove: [selectedRow]});
            });
        }
    }
    //=========================견적추가, 견적삭제 버튼 끝===========================================================
    //O Button Click event
    // o ListModal Click

    customerList.addEventListener('click', () => { // customerList 을 클릭했을 때 실행되는 메서드
        getListData("CL-01"); // ()안에 있는 값을 인자값으로 들고 getListData메서드를 찾으러 출발~
        $("#listModalTitle").text("CUSTOMER CODE");
    });

    divReceivList.addEventListener('click', () => { // customerList 을 클릭했을 때 실행되는 메서드
        getListData("DIV-RECEIV"); // ()안에 있는 값을 인자값으로 들고 getListData메서드를 찾으러 출발~
        $("#listModalTitle").text("DIV_RECEIVED");
    });

    deliveryList.addEventListener('click', () => {
        console.log("딜리버리에서cusCode???"+cusCode);
        getListData2(cusCode);
        $("#listModalTitle").text("DELIVERY DATA");
    });
    //--------------------------------------------------------------------------------------------

    $("#listModal").on('hide.bs.modal', function () {
        if( $("#listModalTitle").text() == "CUSTOMER CODE"){
            divGridOptions.api.stopEditing();
            let rowNode = divGridOptions.api.getRowNode(datepicker.value);
            console.log("rowNode???"+rowNode);
            if (rowNode != undefined) { // rowNode가 없는데 거래처 코드 탐색시 에러
                setDataOnCustomerName();
            }
        }else if($("#listModalTitle").text() == "DELIVERY DATA" ){
            divGridOptions.api.stopEditing();
            let rowNode = divGridOptions.api.getRowNode(datepicker.value);
            console.log("rowNode???"+rowNode);
            if (rowNode != undefined) { // rowNode가 없는데 거래처 코드 탐색시 에러
                setDataOnDeliveryNo();
            }
        }else if($("#listModalTitle").text() == "DIV_RECEIVED"){
            divGridOptions.api.stopEditing();
            let rowNode = divGridOptions.api.getRowNode(datepicker.value);
            if (rowNode != undefined) { // rowNode가 없는데 거래처 코드 탐색시 에러
                setDataOnDivReceive();
            }
        }
    });


    let cusCode="";
    function setDataOnCustomerName() {
        let rowNode = divGridOptions.api.getRowNode(datepicker.value);
        let to = transferVar();
        rowNode.setDataValue("customerName", to.detailCodeName);
        cusCode=to.detailCode;
        console.log("cusCode??"+cusCode);
        let newData = rowNode.data;
        rowNode.setData(newData);
    }

    function setDataOnDeliveryNo() {
        let rowNode = divGridOptions.api.getRowNode(datepicker.value);
        let to = transferVar();
        rowNode.setDataValue("deliveryNo", to.deliveryNo);
        let newData = rowNode.data;
        rowNode.setData(newData);
    }

    function setDataOnDivReceive() {
        let rowNode = divGridOptions.api.getRowNode(datepicker.value);
        let to = transferVar();
        rowNode.setDataValue("divReceive", to.detailCodeName);                  //칼럼이름 = 키 ,밸류 = to.detailcodename
        let newData = rowNode.data;
        rowNode.setData(newData);
    }

    //  let detailItemCode = [];
    //-------------------------------------------------------------------------------------------------


    // 모달이 띄워졌을때, 기존의 값을 to에 세팅
    $("#listModal").on('show.bs.modal', function () {
        let existingData;
        if( $("#listModalTitle").text() == "CUSTOMER CODE" ){
            if(divGridOptions.api.getDisplayedRowCount()!=0){
                let rowNode = divGridOptions.api.getRowNode(datepicker.value);
                existingData = {"detailCode":rowNode.data.customerCode, "detailCodeName":rowNode.data.customerName};
            }
        } else if( $("#listModalTitle").text() == "ITEM CODE" ){
            if (itemRowNode != undefined) { // rowNode가 없는데 거래처 코드 탐색시 에러
                existingData = {"deliveryNo": itemRowNode.data.itemCode, "detailCodeName": itemRowNode.data.itemName};
            }
            }else if($("#listModalTitle").text() == "DELIVERY DATA" ){
                if(divGridOptions.api.getDisplayedRowCount()!=0){
                    let rowNode = divGridOptions.api.getRowNode(datepicker.value);
                    existingData = {"deliveryNo":rowNode.data.deliveryNo};
                    console.log("existingData??"+existingData);
                }
            }else if($("#listModalTitle").text() == "DIV_RECEIVED" ){
            if(divGridOptions.api.getDisplayedRowCount()!=0){
                let rowNode = divGridOptions.api.getRowNode(datepicker.value);
                existingData = {"detailCode":rowNode.data.customerCode, "detailCodeName":rowNode.data.customerName};
                console.log("existingData??"+existingData);
            }
        }

        to = existingData;
    });


    // ================================================================================================================
    //  ======================일괄저장======================================================================
    // 일괄저장 <= 선택된 항목만 저장
    batchSaveButton.addEventListener("click", () => {
        let newReceivRowValue = divGridOptions.getSelectedRowData();
        console.log("newReceivRowValue????"+newReceivRowValue); //
        newReceivRowValue = divGridOptions.getSelectedRowData()[0];  // 일단 견적상세(divGridOptions)그리드에서 첫번째 선택된 행의 데이터를 newEstimateRowValue에 담는다. 구길이 소스: newEstimateRowValue=newEstimateRowValue[0];
        console.log("newReceivRowValue??"+newReceivRowValue);
        newReceivRowValue = JSON.stringify(newReceivRowValue);  // 받아온 값들을 JSON형태로 바꾸어준다고 생각=> 문자열로 변환
        console.log("스트링으로newReceivRowValue??"+newReceivRowValue);
        Swal.fire({
            title: "수금을 등록하시겠습니까?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: '취소',
            confirmButtonText: '확인',
        }).then( (result) => {  // 위 SWAL창이 뜬 다음
            if (result.isConfirmed) {  //결과가 컨펌이 되었을 경우
                let xhr = new XMLHttpRequest();
                console.log("인코더"+encodeURI(newReceivRowValue));
                xhr.open('POST', "${pageContext.request.contextPath}/receiv/addReceive?estimateDate=" // 위의 값들을 addNewEstimate.do를 호출시켜서 던질거임
                    + datepicker.value + "&newReceivRowValue=" + encodeURI(newReceivRowValue),
                    true);
                xhr.setRequestHeader('Accept', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
                xhr.send();
                xhr.onreadystatechange = () => {  //callback함수 사용
                    if (xhr.readyState == 4 && xhr.status == 200) { // 숫자값에 따라 처리상태가 달라지는 것. xhr.readyState == 4 : 데이터를 전부 받은 상태,완료되었다.xhr.status == 200 : 서버로부터의 응답상태가 요청에 성공하였다는 의미.
                        divGridOptions.api.setRowData([]);
                        let txt = xhr.responseText;
                        txt = JSON.parse(txt);
                        let resultMsg =// 초기화가 완료되었으면 이 결과 메세지를 반환
                            "<h5>< 수금 등록 내역 ></h5>"
                            + "수금번호 : <b>" + txt.result.recivSeq + "</b></br>"
                            + "위와 같이 작업이 처리되었습니다";
                        Swal.fire({
                            title: "수금등록이 완료되었습니다.",
                            html: resultMsg,
                            icon: "success",
                        });
                    }
                };
            }})
    })
</script>
</body>
</html>