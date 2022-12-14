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
	    <script src="${pageContext.request.contextPath}/StaticFiles/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/StaticFiles/css/datepicker.css">
	
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
	<body>
		<article class="estimate">
		    <div class="estimate__Title">
		        <h5 style="color: black;">???? ????????????</h5>
		        <div class="menuButton">
		            <button  id="codeList" >????????????</button>
		            <button id="codeadd" onclick="addRow(this)">????????????</button>
		            <button id="batchSaveButton" style="float:right; background-color:#F15F5F"  >????????????</button>
		            <div class="menuButton__selectCode">
		            	<button id="codeDeleteButton" onclick="deleteRow(this)">????????????</button>
		   			</div>
		       </div>
		   </div>
		</article>
		<article class="estimateGrid">
		    <div align="center">
		        <div id="myGrid" class="ag-theme-balham" style="height:300px; width:auto; text-align: center;"></div>
		    </div>
		</article>
		<article class="estimateDetail">
		    <div class="estimateDetail__Title">
		        <h5 style="color: black;">???? ??????????????????</h5>
		        <div class="menuButton">
		 <button id="codeDetailInsertButton" >??????????????????</button>
		  <button id="codeadd2" onclick="addRow2(this)">????????????</button>
		  <button id="codeDeleteButton2" onclick="deleteRow2(this)">????????????
		    </button>
		    </div>
		     </div>
		</article>
		<article class="estimateDetailGrid">
		    <div align="center" class="ss">
		        <div id="myGrid2" class="ag-theme-balham" style="height:50vh;width:auto;"></div>
		    </div>
		</article>
		
		
		<div class="modal fade" id="codeSearch" role="dialog">
		    <div class="modal-dialog modal-xl">
		        <!-- Modal content-->
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title">CODE LIST</h5>
		                <button type="button" class="close" data-dismiss="modal" style="padding-top: 0.5px">&times;</button>
		            </div>
		            <div class="modal-body">
		                <div id="codeGrid" class="ag-theme-balham" style="height:600px;width:auto;">
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		            </div>
		        </div>
		    </div>
		</div>
	
	<%--Amount Modal--%>
	<script>
	  const myGrid = document.querySelector('#myGrid');
	  const myGrid2 = document.querySelector('#myGrid2');
	  const codeList = document.querySelector('#codeList');
	  const codeDetailInsertButton = document.querySelector('#codeDetailInsertButton');
	  const itemList = document.querySelector('#itemList');
	  const unitList = document.querySelector('#unitList');
	  const amountList = document.querySelector('#amountList');
	  const batchSaveButton = document.querySelector("#batchSaveButton");

	 //-----------------------------------------?????? ??????------------------------------------------// 
	  
	  // code ??????
	  let estColumn = [
	   {headerName: ' ', checkboxSelection: true,  width: 50, cellStyle: {'textAlign': 'center'}, headerCheckboxSelection: true },
	    {headerName: "????????????", field: "divisionCodeNo", editable: true},
	    {headerName: "????????????", field: "codeType", editable: true },
	    {headerName: "????????????", field: "divisionCodeName",editable: true},
	    {headerName: "??????????????????", field: "codeChangeAvailable",editable: false},
	    {headerName: "??????", field: "description", editable: true},
	    {headerName: "??????", field: "status",editable: true},
	  ];
	  let rowData = [];
	  let contractRowNode;
	  // event.colDef.field
	  let estGridOptions = {
	    columnDefs: estColumn,
	    rowSelection: 'single',
	    rowData: rowData,
	    paginationAutoPageSize: true,
	    pagination: true,
	    defaultColDef: { resizable : true},
	    overlayNoRowsTemplate: "????????? ????????? ????????????.",
	    onGridReady: function (event) {// onload ???????????? ?????? ready ?????? ????????? ????????? ????????????.
	      event.api.sizeColumnsToFit();
	    },
	    onGridSizeChanged: function (event) {
	      event.api.sizeColumnsToFit();
	    },
	    onCellValueChanged: function(event) {
           if(event.data.status != "INSERT" && event.data.status != "DELETE"){
        	  if(event.data.codeChangeAvailable != "???????????????"){
	              console.log(event.data);
	              event.data.status = "UPDATE"; 
	              estGridOptions.api.updateRowData({update: [event.data]});
        	  }
           }
         },
	    getSelectedRowData() {
	        let selectedNodes = this.api.getSelectedNodes();
	        let selectedData = selectedNodes.map(node => node.data);
	        return selectedData;
	      }
	    }                                      
	
	  codeList.addEventListener("click", () => { 
	     estDetailGridOptions.api.setRowData([]);  
	     let xhr = new XMLHttpRequest();
	       xhr.open('GET', "${pageContext.request.contextPath}/compinfo/code/list?"
	           + "method=findCodeList",
	           true);
	       xhr.setRequestHeader('Accept', 'application/json');
	       xhr.send();
	       xhr.onreadystatechange = () => {
	         if (xhr.readyState == 4 && xhr.status == 200) {
	           let txt = xhr.responseText;
	           txt = JSON.parse(txt);
	           if (txt.gridRowJson == "") {
	             swal.fire("??????????????? ????????????.");
	             return;
	           } else if (txt.errorCode < 0) {
	             swal.fire("??????", txt.erroMsg, "error");
	             return;
	           }  
	           estGridOptions.api.setRowData(txt.codeList);
	           console.log(txt.codeList);
	         }
	       }
	     });
	   
	//---------------------------------------------?????? ????????????-------------------------------------------------------------//
	///?????????????????? ?????????   
  	 let estDetailColumn = [
       {headerName: "??????????????????", field: "divisionCodeNo",checkboxSelection: true , suppressSizeToFit: true, editable: true, suppressSizeToFit: true,headerCheckboxSelection: true },
       {headerName: "????????????", field: "detailCode",editable: true},
       {headerName: "??????????????????", field: "detailCodeName",editable: true},
       {headerName: "??????????????????", field: "codeUseCheck", editable: true},
       {headerName: "????????????", field: "description",editable: true},
       {headerName: "??????", field: "status",editable: true}
     ];
     let itemRowNode;
     let estDetailRowData = [];
     let estDetailGridOptions = {
       columnDefs: estDetailColumn,
       rowSelection: 'multiple',
       rowData: estDetailRowData,
       paginationAutoPageSize: true,
       pagination: true,
       defaultColDef: {editable: false},
       overlayNoRowsTemplate: "????????? ??????????????? ????????????.",
       onGridReady: function (event) {
         event.api.sizeColumnsToFit();
       },
       onGridSizeChanged: function (event) {
         event.api.sizeColumnsToFit();
       },
       onRowSelected: function (event) { // checkbox
         console.log(event);
       },
       onSelectionChanged(event) {
          -
         console.log("onSelectionChanged" + event);
       },
       getSelectedRowData() {
           let selectedNodes = this.api.getSelectedNodes();
           let selectedData = selectedNodes.map(node => node.data);
           return selectedData;
         },
        onCellValueChanged: function(event) {
            if(event.data.status != "INSERT" && event.data.status != "DELETE"){
               console.log(event.data);
               event.data.status = "UPDATE";
               estDetailGridOptions.api.updateRowData({update: [event.data]});
            }
          }
       }  
	
	codeDetailInsertButton.addEventListener("click", () => {
      let codeDetail=estGridOptions.getSelectedRowData();
      estDetailGridOptions.api.setRowData([]);
      if (codeDetail.length == 0) {
             Swal.fire({
                text: " ??????????????? ????????????.",
                icon: "info",
             })
             return;
          }
      let xhr = new XMLHttpRequest();
        xhr.open('GET', "${pageContext.request.contextPath}/compinfo/codedetail/list"+
        "?method=findCodeDetailList"
          +"&divisionCodeNo="+codeDetail[0].divisionCodeNo,
            true)
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.send();
        xhr.onreadystatechange = () => {
          if (xhr.readyState == 4 && xhr.status == 200) {
            let txt = xhr.responseText;
            txt = JSON.parse(txt);
            if (txt.gridRowJson == "") {
              swal.fire("??????????????? ????????????.");
              return;
            } else if (txt.errorCode < 0) {
              swal.fire("??????", txt.erroMsg, "error");
              return;
            }  
            estDetailGridOptions.api.setRowData(txt.codeList);
            console.log(txt.codeList);
          }
		}
	});
	 /////////////////////////////////////////////????????? ????????????////////////////////////////////////////////////////// 
	  
	  
	  /////?????? ??????
	  function addRow(event) {
	       
	      let row = {
	       divisionCodeNo: "",
	        codeType: "",
	        divisionCodeName: "",
	        codeChangeAvailable: "????????????",
	        description:"",
	        status: "INSERT"       
	      };
	      estGridOptions.api.updateRowData({add: [row]});
	
	  } 
	  
	  ///???????????? ??????
	  function addRow2(event) {
	     let estgGrid = estGridOptions.getSelectedRowData();
	     let code =   estGridOptions.getSelectedRowData();
	      let row = {
	       divisionCodeNo:estgGrid[0].divisionCodeNo,
	       detailCode: "",
	       detailCodeName: "",
	       codeUseCheck: "",
	       description:"",
	        status: "INSERT"       
	      };
	      estDetailGridOptions.api.updateRowData({add: [row]});      
	    }
	      
	
	//?????? ??????
	  function deleteRow(event) {       
	     if (event.id =="codeDeleteButton"){
	        let estGrid = estGridOptions.getSelectedRowData();
	        estGrid.forEach(function(estGrid,index){                   
	          console.log(estGrid);
	         if(estGrid.status == 'INSERT')
	            estGridOptions.api.updateRowData({remove: [estGrid]});
	         else{
	          estGrid.status = 'DELETE'
	             estGridOptions.api.updateRowData({update: [estGrid]});
	          console.log(estGridOptions);
	         }
	       });          
	     }
	  } 
	  
	   //??????????????????
	  function deleteRow2(event){
	  if (event.id =="codeDeleteButton2"){
	    let estDetailGrids = estDetailGridOptions.getSelectedRowData();
	    estDetailGrids.forEach(function(estDetailGrids,index){
	      if(estDetailGrids.status == 'INSERT')
	         estDetailGridOptions.api.updateRowData({remove: [estDetailGrids]});
	      else{
	         estDetailGrids.status = 'DELETE'
	            estDetailGridOptions.api.updateRowData({update: [estDetailGrids]});
	         }
	      });
	  }
	}
	   
	/////////////////////////////////////////////????????????//////////////////////////////////////////////////////
	
	let newcodeRowValues=[];
	  // ???????????? <= ????????? ????????? ??????
	  batchSaveButton.addEventListener("click", () => {
		newcodeRowValues=[];
	    if(estDetailGridOptions.api.getSelectedRows()==0){
	       Swal.fire({
	            text: "??????????????? ???????????????????????????.",
	            icon: "info",
	          })
	       return;
	    }
	    else if (estGridOptions.getSelectedRowData() == "") {
	      Swal.fire({
	        text: "????????? ???????????????????????????.",
	        icon: "info",
	      })
	      return;
	    }
	
	    newcodeRowValues.push(estGridOptions.getSelectedRowData()[0]);
	    let selectRows = estDetailGridOptions.api.getSelectedRows();
	    console.log(selectRows);
	  /*  estDetailGridOptions.api.forEachNode(function(eachRow){
	            if (eachRow.data.divisionCodeNo == "") {
	               flag = 1;
	               Swal.fire({
	                  text: "?????? ?????? ?????? ???????????? ????????????.",
	                  icon: "info",
	               })
	               return;
	            }
	            selectRows.push(eachRow.data);
	         }); */
	    newcodeRowValues[0].codeDetailTOList=selectRows;
	    console.log(newcodeRowValues);
	    Swal.fire({
	      title: "?????????????????????????",
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#3085d6',
	      cancelButtonColor: '#d33',
	      cancelButtonText: '??????',
	      confirmButtonText: '??????',
	    }).then( (result) => {
	      if (result.isConfirmed) {
	      let xhr = new XMLHttpRequest();
	      xhr.open('POST', "${pageContext.request.contextPath}/compinfo/codeInfo?method=addCodeInFormation&newCodeInfo="
	            + encodeURI(JSON.stringify(newcodeRowValues)),
	          true);
	      xhr.setRequestHeader('Accept', 'application/json');
	      xhr.send();
	      xhr.onreadystatechange = () => {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	          // ????????? 
	          estGridOptions.api.setRowData([]);
	          estDetailGridOptions.api.setRowData([]);
	          let txt = xhr.responseText;
	          txt = JSON.parse(txt);
	          Swal.fire({
	            title: "????????? ?????????????????????.",
	            icon: "success",
	          });
	        }
	      };
	    }})
	  })
	  // O Button Click evenet
	  // o ListModal Click 
	 
	  document.addEventListener('DOMContentLoaded', () => {
	       new agGrid.Grid(myGrid, estGridOptions);
	       new agGrid.Grid(myGrid2, estDetailGridOptions);
	     })
	  // O setup the grid after the page has finished loading
	</script>
</body>
</html>