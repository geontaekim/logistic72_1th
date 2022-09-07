<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <script src="${pageContext.request.contextPath}/StaticFiles/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/datepicker.js" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/StaticFiles/css/datepicker.css">
    <script>
        // O 날짜 설정
        $(function() {
            // set default dates
            let start = new Date();
            start.setDate(start.getDate() - 365);
            // set end date to max one year period:
            let end = new Date(new Date().setYear(start.getFullYear() + 1));
            // o set searchDate
            $('#datepicker').datepicker({
                todayHiglght: true,
                autoHide: true,
                autoaShow: true,
            });
            // o set searchRangeDate
            $('#fromDate').datepicker({
                startDate: start,
                endDate: end,
                minDate: "-10d",
                todayHiglght: true,
                autoHide: true,
                autoaShow: true,
                // update "toDate" defaults whenever "fromDate" changes
            })
            $('#toDate').datepicker({
                startDate: start,
                endDate: end,
                todayHiglght: true,
                autoHide: true,
                autoaShow: true,
            })
            $('#fromDate').on("change", function() {
                //when chosen from_date, the end date can be from that point forward
                var startVal = $('#fromDate').val();
                $('#toDate').data('datepicker').setStartDate(startVal);
            });
            $('#toDate').on("change", function() {
                //when chosen end_date, start can go just up until that point
                var endVal = $('#toDate').val();
                $('#fromDate').data('datepicker').setEndDate(endVal);
            });

        });
    </script>
    <style>
        .fromToDate {
            display: inline-block;
            margin-bottom: 7px;
        }

        #searchCustomerBox {
            display: none;
            margin-bottom: 7px;
        }

        #datepicker {
            margin-bottom: 7px;
        }

        button {
            background-color: #006600;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            border-radius: 3px;
            margin-bottom: 10px;
        }

        .ag-header-cell-label {
            justify-content: center;
        }
        .ag-cell-value {
            padding-left: 5px;
        }
    </style>
</head>
<body>
<article class="delivery">
    <div class="delivery__Title" style="color: black">
        <h5 style="color: black;">🚚 미수채권집계</h5>
        
        <div>
            <label for="searchByPeriodRadio" style="color: black;">기간 검색</label>
            <input type="radio" name="searchCondition" value="searchByDate" id="searchByPeriodRadio" checked>
            &nbsp;<label for="searchByCustomerRadio" style="color: black;">거래처 검색</label>
            <input type="radio" name="searchCondition" value="searchByCustomer" id="searchByCustomerRadio">
        </div>

        <form autocomplete="off">
            <select name='searchCustomerBox' id='searchCustomerBox' style='width: 152px; height:26px;'>
            </select>
            <div class="fromToDate">
                <input type="text" id="fromDate" placeholder="YYYY-MM-DD 📅" size="15" style="text-align: center">
                &nbsp; ~ &nbsp;<input type="text" id="toDate" placeholder="YYYY-MM-DD 📅" size="15"
                                      style="text-align: center">
            </div>
        </form>
        <button id="manageOfRecSearchButton">미수채권집계</button>
    </div>
</article>
<article class="contractGrid">
    <div align="center">
        <div id="myGrid" class="ag-theme-balham" style="height:60vh; width:auto; text-align: center;"></div>
    </div>
</article>

<script>
    const myGrid = document.querySelector("#myGrid");
    const searchByPeriodRadio = document.querySelector("#searchByPeriodRadio");     // 기간검색
    const searchByCustomerRadio = document.querySelector("#searchByCustomerRadio"); // 거래처검색
    const searchCustomerBox = document.querySelector("#searchCustomerBox");
    const fromToDate = document.querySelector(".fromToDate");
    const startDatePicker = document.querySelector("#fromDate"); //  시작일자
    const endDatePicker = document.querySelector("#toDate");     //  종료일자
    const manageOfRecSearchBtn = document.querySelector("#manageOfRecSearchButton"); // 납품 가능 수주 조회



    // O setup the grid after the page has finished loading
    document.addEventListener('DOMContentLoaded', () => {
        getCustomerCode(); // 거래처 select태그 세팅
        new agGrid.Grid(myGrid, manageOfRecGridOptions);
    })

    // 기간 검색, 거래처 검색 ==============================================
    searchByPeriodRadio.addEventListener("click", () => {
        fromToDate.style.display = "inline-block";
        searchCustomerBox.style.display = "none";
    });
    searchByCustomerRadio.addEventListener("click", () => {
        searchCustomerBox.style.display = "inline-block";
        fromToDate.style.display = "none";
    });
    const getCustomerCode = () => {
        getListData("CL-01");
        setTimeout(() => {
            let data = jsonData;
            let target = searchCustomerBox;
            for (let index of data.detailCodeList) {
                let node = document.createElement("option");
                node.value = index.detailCode;
                let textNode = document.createTextNode(index.detailCodeName);
                node.appendChild(textNode);
                target.appendChild(node);
            }
        }, 100)
    }
    // ===============================================================
    // O manageOfRec Grid 첫번째 그리드
    let manageOfRecColumn = [
        {headerName: "거래처코드", field: "customerCode"},
        { headerName: "거래처명", field: "customerName"},
        { headerName: '전기(월)이월', field: 'amountCarriedOver' },
        { headerName: '당기발생', field: 'netIncome'},
        { headerName: '당기수금', field: 'comAccReceivable' },
        { headerName: '잔액', field: 'balance'},

    ];

    // o 첫번째 그리드 옵션들
    let manageOfRecRowData = [];
    let manageOfRecGridOptions = {
        columnDefs: manageOfRecColumn,
        rowSelection: 'single',
        rowData: manageOfRecRowData,
        getRowNodeId: function(data) {
            return data.contractNo;
        },
        defaultColDef: {editable: false, resizable : true},
        overlayNoRowsTemplate: "수주 가능 리스트가 없습니다.",
        onGridReady: function(event) {// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
            event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function(event) {
            event.api.sizeColumnsToFit();
        },
        getRowStyle: function (param) {
            return {'text-align': 'center'};
        },
    }
    //=================================================================

    // O 납품 가능 수주 조회 버튼
    const manageOfRec = (searchCondition, startDate, endDate, customerCode) => {

        manageOfRecGridOptions.api.setRowData([]);
        managerRecInfo = {"searchCondition":searchCondition,"startDate":startDate,"endDate":endDate,"customerCode":customerCode};
        managerRecInfo=encodeURI(JSON.stringify(managerRecInfo));
        console.log("searchCondition : "+searchCondition);
        console.log("startDate : "+startDate);
        console.log("endDate : "+endDate);
        console.log("customerCode : "+customerCode);
        let xhr = new XMLHttpRequest();
        xhr.open('GET', "${pageContext.request.contextPath}/receiv/receivelist?"
            + "managerRecInfo=" + managerRecInfo,
            true);
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.send();
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let txt = xhr.responseText;
                txt = JSON.parse(txt);
                if (txt.gridRowJson == "") {
                    Swal.fire("알림", "조회 가능 리스트가 없습니다.", "info");
                    return;
                } else if (txt.errorCode < 0) {
                    Swal.fire("알림", txt.errorMsg, "error");
                    return;
                }
                console.log("txt??"+txt);
                console.log("txt.salesList??"+txt.salesList);
                manageOfRecGridOptions.api.setRowData(txt.salesList.receivelist);
            }
        }
    }
    // 납품 가능 수주 조회 클릭메서드
    manageOfRecSearchBtn.addEventListener("click", () => {
        let searchCondition = (searchByPeriodRadio.checked) ? searchByPeriodRadio.value : searchByCustomerRadio.value;
        let startDate = "";
        let endDate = "";
        let customerCode = "";
        if (searchCondition == 'searchByDate') {
            if (startDatePicker.value == "" || endDatePicker.value == "") {
                Swal.fire("입력", "시작일과 종료일을 입력하십시오.", "info");
                return
            } else {
                startDate = startDatePicker.value;
                endDate = endDatePicker.value;
            }
        } else if (searchCondition == 'searchByCustomer'){
            customerCode = searchCustomerBox.value;
        }
        manageOfRec(searchCondition, startDate, endDate, customerCode);
    });
    //==================================================
    // O 납품 가능 상세조회

</script>
</body>
</html>