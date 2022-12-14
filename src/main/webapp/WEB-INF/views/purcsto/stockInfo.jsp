<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>purchase</title>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <script src="${pageContext.request.contextPath}/StaticFiles/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/datepicker.js" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/StaticFiles/css/datepicker.css">

    <script>
      // O setting datapicker
      $(function() {
        // set default dates
        let start = new Date();
        start.setDate(start.getDate() - 20);
        // set end date to max one year period:
        let end = new Date(new Date().setYear(start.getFullYear() + 1));
        // o set searchDate
        $('[data-toggle="datepicker"]').datepicker({
          autoHide: true,
          zIndex: 2048,
        });
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
            padding-left: 25px;
        }

        .form-control {
            display: inline;
        !important;
        }
        #orderModal {
            position: absolute !important;
            z-index: 3000;
        }
      .btnContainer{
         display:flex;
         flex-direction:row;
      }
      .checkBtn{
         margin-right:10px;
      }
        @media (min-width: 768px) {
            .modal-xl {
                width: 90%;
                max-width: 1200px;
            }
        }
    </style>
</head>
<body>
<article class="warehousing">
    <div class="warehousing__Title" style="color: black">
        <h5 style="color: black;">??????? ??????</h5>
        <b style="color: black;">??????</b><br/>
        <form autocomplete="off" style="display: inline-block">
            <input type="text" data-toggle="datepicker" id="warehousingDate" placeholder="?????? ?????? ????" size="15"
                   autocomplete="off" style="text-align: center">&nbsp;&nbsp;
        </form>
        <button id="warehousingModalButton">??????</button>
        <button id="extraImportButton">?????? ??????</button>
    </div>
</article>
<article class="myGrid">
    <div align="center">
        <div id="myGrid" class="ag-theme-balham" style="height:70vh; width:auto; text-align: center;"></div>
    </div>
</article>
<%--O WAREHOUSING MODAL--%>
<div class="modal fade" id="warehousingModal" role="dialog">
    <div class="modal-dialog modal-xl">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">
                    <h5>MRP SIMULATION</h5>
                    <div class="btnContainer">
                       <button id="checkingButton" class="checkBtn">???????????? ??????</button>
                       <button id="warehousingButton">???????????? ??????</button>
                    </div>
                </div>
                <button type="button" class="close" data-dismiss="modal" style="padding-top: 0.5px">&times;</button>
            </div>
            <div class="modal-body">
                <div id="warehousingGrid" class="ag-theme-balham" style="height: 40vh;width:auto;">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<!-- INSERT MODAL-->

<div class="modal fade" id="extraInsertModal" role="dialog">
    <div class="modal-dialog modal-xl">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">
                    <h5>?????? ??????</h5>
                    <div class="btnContainer"></div>
                </div>
                <button type="button" class="close" data-dismiss="modal"
                        style="padding-top:0.5px">&times;</button>
            </div>
            <div class="modal-body">
                <div id="warehousingGrid2" class="ag-theme-balham"
                     style="height: 50vh; font-size:20px; width: auto";>

                    ????????????:<select name="camera" id="camera">
                    <option value="">::::::  ??????  :::::</option>
                    <option value='DK-01'>?????????????????? NO.1</option>
                    <option value='DK-02'>?????????????????? NO.2</option>
                    <option value='DK-BC01'>?????????-100</option>
                    <option value='DK-FC01'>KC-10P</option>
                    <option value='MM-01'>??????????????? 2.5 TFT</option>
                    <option value='MC-KP01'>?????????-66</option>
                    <option value='LN-01'>??????-400</option>
                    <option value='JL-01'>?????????-66</option>
                    <option value='HA-01'>??????-22</option>
                    <option value='JL-02'>?????????-77</option>
                    <option value='HA-02'>??????-55</option>
                    <option value='MM-02'>??????????????? 2.0 TFT</option>
                    <option value='DK-BC02'>?????????-200</option>
                    <option value='DK-FC02'>KC-20P</option>
                    <option value='LN-02'>??????-900</option>
                    <option value='MC-KP02'>?????????-77</option>
                    <option value='DK-AP01'>????????? ?????? NO.1</option>
                    <option value='DK-AP02'>????????? ?????? NO.2</option>
                </select></br>

                    ????????? AMOUNT:<select name="stock" id="stock">
                    <option value="">:::::: ???????????? :::::</option>
                    <option value='STOCK_AMOUNT'>STOCK_AMOUNT</option>
                    <option value='ORDER_AMOUNT'>ORDER_AMOUNT</option>
                    <option value='INPUT_AMOUNT'>INPUT_AMOUNT</option>
                    <option value='DELIVERY_AMOUNT'>DELIVERY_AMOUNT</option>
                    <option value='TOTAL_STOCK_AMOUNT'>TOTAL_STOCK_AMOUNT</option>
                </select></br>
                    ??????:<input type="text" name="quantity" id="quantity" />

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" id=insertStock class="btn btn-default" data-dismiss="modal">????????????</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>

<script>
  const myGrid = document.querySelector("#myGrid");
  const warehousingModalBtn = document.querySelector("#warehousingModalButton");
  const extraImportButton = document.querySelector("#extraImportButton");
  const warehousingDate = document.querySelector("#warehousingDate");
  const warehousingBtn = document.querySelector("#warehousingButton");
  const checkingBtn = document.querySelector("#checkingButton");
  const warehousingGrid2 = document.querySelector("#warehousingGrid2");

  const stockColumn = [
    {headerName: "????????????", field: "warehouseCode",},
    {headerName: "????????????", field: "itemCode",},
    {headerName: '?????????', field: "itemName",},
    {headerName: '??????', field: 'unitOfStock',},
    {headerName: '???????????????', field: 'totalStockAmount',},
    {headerName: '???????????????', field: 'safetyAllowanceAmount',},
    {headerName: '???????????????', field: 'stockAmount',},
    {headerName: '?????????????????????', field: 'orderAmount',},
    {headerName: '?????????????????????', field: 'inputAmount',},
    {headerName: '?????????????????????', field: 'deliveryAmount',},
      {headerName: '?????????????????????', field: 'tempQuoAmount',}
  ];
  let stockRowData = [];
  const stockGridOptions = {
    defaultColDef: {
      flex: 1,
      minWidth: 100,
      resizable: true,
    },
    columnDefs: stockColumn,
    rowSelection: 'multiple',
    rowData: stockRowData,
    getRowNodeId: function(data) {
      return data.itemCode;
    },
    defaultColDef: {editable: false, resizable : true},
    overlayNoRowsTemplate: "????????? ?????? ???????????? ????????????.",
    onGridReady: function(event) {// onload ???????????? ?????? ready ?????? ????????? ????????? ????????????.
      event.api.sizeColumnsToFit();
    },
    onRowSelected: function(event) { // checkbox
      console.log(event);
    },
    onGridSizeChanged: function(event) {
      event.api.sizeColumnsToFit();
    },
    getRowStyle: function(param) {
      return {'text-align': 'center'};
    },
  }
  const showStockGrid = () => {
    let xhr = new XMLHttpRequest();
    xhr.open('GET', '${pageContext.request.contextPath}/stock/sto/list' +
        "?method=searchStockList",
        true)
    xhr.setRequestHeader('Accept', 'application/json');
    xhr.send();
    xhr.onreadystatechange = () => {
      if (xhr.readyState == 4 && xhr.status == 200) {
        let txt = xhr.responseText;
        txt = JSON.parse(txt);
        if (txt.errorCode < 0) {
          swal.fire("??????", txt.errorMsg, "error");
          return;
        }
        console.log(txt);
        stockGridOptions.api.setRowData(txt.gridRowJson);
      }
    }
  }
  // O warehousing modal
  let _setWarehousingModal = (function() {
    let executed = false;
    return function() {
      if (!executed) {
        executed = true;
        setWarehousingModal();
      }
    };
  })();
  
  warehousingModalBtn.addEventListener("click", () => {
    if (warehousingDate.value == "") {
      Swal.fire("??????", "?????? ????????? ??????????????????.", "info");
      return;
    }
    _setWarehousingModal();
    getWarehousingModal();
    $("#warehousingModal").modal('show');
  });

  extraImportButton.addEventListener("click", () => {

      $("#extraInsertModal").modal('show');
  });

  insertStock.addEventListener("click", () => {  //modal??? ?????? ?????? Save??? ????????? ?????????
      Swal.fire({
          title: '?????????????????????????',
          icon: 'question',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          cancelButtonText: '??????',
          confirmButtonText: '??????',
      }).then((result)=>{
          if (result.isConfirmed) {
              let xhr = new XMLHttpRequest();
              xhr.open('POST', '${pageContext.request.contextPath}/stock/sto/insertStock?'
                  + "quantity=" + $('#quantity').val()
                  + "&camera="+$("select[name=camera]").val()
                  + "&stock="+$("select[name=stock]").val(),
                  true)
              xhr.setRequestHeader('Accept', 'application/json');
              xhr.send();
              xhr.onreadystatechange = () => {
                  if (xhr.readyState == 4 && xhr.status == 200) {
                      let txt = JSON.parse(xhr.responseText);
                      console.log(txt);
                      if (txt.errorCode < 0) {
                          swal.fire("??????", txt.errorMsg, "error");
                          return;
                      }
                      Swal.fire(
                          '??????!',
                          '?????? ???????????? ??????.',
                          'success'
                      )

                  }
              }
          }
      })
  })



  // o warehousing modal warehousing
  let orderNoList = [];
  checkingBtn.addEventListener("click",()=>{
     orderNoList = [];
     let checkedItem=false;
     let selectedRows = warehousingGridOptions.api.getSelectedRows();
       if (selectedRows == "") {
         Swal.fire("??????", "????????? ?????? ????????????.", "info");
         return;
       }
       selectedRows.forEach(function(selectedRow, index) {
        if(selectedRow.inspectionStatus=='Y'){
           checkedItem=true;
        }
         orderNoList.push(selectedRow.orderNo);
         console.log(selectedRow);
       });
       if(checkedItem==true){
          orderNoList=[];
          Swal.fire("??????", "????????? ????????? ????????? ????????????.", "info");
          return;
       }
       
       console.log(selectedRows);
       Swal.fire({
           title: '?????????????????????????',
           html: '????????????</br>'+ '<b>' + orderNoList + '</b>'+ '</br>???????????? ?????????.',
           icon: 'warning',
           showCancelButton: true,
           confirmButtonColor: '#3085d6',
           cancelButtonColor: '#d33',
           cancelButtonText: '??????',
           confirmButtonText: '??????',
         }).then((result)=>{
            if (result.isConfirmed) {
                  let xhr = new XMLHttpRequest();
                  xhr.open('GET', '${pageContext.request.contextPath}/purchase/order' +
                      "?method=checkOrderInfo"
                      + "&orderNoList=" + encodeURI(JSON.stringify(orderNoList)),
                      true)
                  xhr.setRequestHeader('Accept', 'application/json');
                  xhr.send();
                  xhr.onreadystatechange = () => {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                      let txt = JSON.parse(xhr.responseText);
                      console.log(txt);
                      if (txt.errorCode < 0) {
                        swal.fire("??????", txt.errorMsg, "error");
                        return;
                      }
                      Swal.fire(
                          '??????!',
                          '???????????? ????????????.',
                          'success'
                      )
                      warehousingGridOptions.api.updateRowData({ update: selectedRows });
                      _setWarehousingModal();
                      getWarehousingModal();
                      $("#warehousingModal").modal('show');
                    }
                  }
                }
         })
  })
  warehousingBtn.addEventListener('click', () => {
    let selectedRows = warehousingGridOptions.api.getSelectedRows();
    if (selectedRows == "") {
      Swal.fire("??????", "????????? ?????? ????????????.", "info");
      return;
    }
    orderNoList=[];
    selectedRows.forEach(function(selectedRow, index) {
      orderNoList.push(selectedRow.orderNo);
      console.log(selectedRow);
    });
    Swal.fire({
      title: '?????????????????????????',
      html: '????????????</br>'+ '<b>' + orderNoList + '</b>'+ '</br>?????????????????????.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      cancelButtonText: '??????',
      confirmButtonText: '??????',
    }).then((result) => {
      if (result.isConfirmed) {
        let xhr = new XMLHttpRequest();
        xhr.open('POST', '${pageContext.request.contextPath}/stock/sto/warehousing' +
            "?method=warehousing"
            + "&orderNoList=" + encodeURI(JSON.stringify(orderNoList)),
            true)
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.send();
        xhr.onreadystatechange = () => {
          if (xhr.readyState == 4 && xhr.status == 200) {
            let txt = JSON.parse(xhr.responseText);
            console.log(txt);
            if (txt.errorCode < 0) {
              swal.fire("??????", txt.errorMsg, "error");
              return;
            }
            Swal.fire(
                '??????!',
                '??????????????? ???????????? ???????????????.',
                'success'
            )
            selectedRows.forEach(function(selectedRow, index) {
              warehousingGridOptions.api.updateRowData({remove: [selectedRow]});
            });
            console.log(txt);
            showStockGrid();
          }
        }
      }
    })
  });
   
  document.addEventListener('DOMContentLoaded', () => {
    showStockGrid();
    new agGrid.Grid(myGrid, stockGridOptions);
  });
</script>
</body>
</html>