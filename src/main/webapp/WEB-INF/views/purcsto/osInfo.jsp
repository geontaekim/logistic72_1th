<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="GI68" tagdir="/WEB-INF/tags" %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>search outsourcing</title>
	<script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <script src="${pageContext.request.contextPath}/StaticFiles/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <script src="${pageContext.request.contextPath}/StaticFiles/js/datepicker.js" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/StaticFiles/css/datepicker.css">
    <script src="${pageContext.request.contextPath}/StaticFiles/js/jquery-3.3.1.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" data-auto-replace-svg="nest"></script>
    <style>
    	.fromToDate {
            margin-bottom: 7px;
        }
        .title{
        	color: white;
        	text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;
        	margin-bottom:20px;
        }
        .headerContainer{
        	display:flex;
        	flex-direction:row;
        	padding:6px 0 0 0;
        	justify-content:space-between;
        }
        .searchBtn{
        	margin-left:20px;
        	height:30px;
        	padding:0 5px 0 5px;
        	text-shadow: 2px 2px 4px #000000;
        }
        .itemCon{
        	height:30px;
        	padding:0 5px 0 5px;
        	text-shadow: 2px 2px 4px #000000;
        	margin-bottom:5px;
        }
        .itemText{
        	margin-left:27px;
        }
        .meterialChoice{
        	margin-left:0;
        }
        .custTxt{
        	margin-left:13px;
        }
		body{
			color: white;
		}
    </style>
    <script>
    $(function () {
        // set default dates
        // set end date to max one year period:
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
            todayHiglght: true,
            autoHide: true,
            autoaShow: true,
            // update "toDate" defaults whenever "fromDate" changes
        })
        $('#toDate').datepicker({
            todayHiglght: true,
            autoHide: true,
            autoaShow: true,
        })
        $('#fromDate').on("change", function () {
            //when chosen from_date, the end date can be from that point forward
            var startVal = $('#fromDate').val();
            $('#toDate').data('datepicker').setStartDate(startVal);
        });
        $('#toDate').on("change", function () {
            //when chosen end_date, start can go just up until that point
            var endVal = $('#toDate').val();
            $('#fromDate').data('datepicker').setEndDate(endVal);
        });
		
    });
    </script>
    <script>
    const osWorkData=[];
	    $().ready(function(){
	    	createOSWorkGrids();
	    	$("#searchBtn").click(searchFunc);
	    	$("#itemCondition").click(conditionClickFunc);
	    })
	    function conditionClickFunc(){
	    			// ????????????
	               getOSListData("ITEM");
	               setOSListModal();
	               $("#listModalTitle").text("ITEM BY CUSTOMER");
	         }
	    function searchFunc(){
	    	if($("#fromDate").val()==""){
	    		Swal.fire("??????", "???????????? ????????? ??????????????????.", "info");
	    	}else if($("#toDate").val()==""){
	    		Swal.fire("??????", "???????????? ????????? ??????????????????.", "info");
	    	}
	    	const fromDate = $("#fromDate").val();
	    	const toDate = $("#toDate").val();
	    	const customerCode = $("#customerCode").val();
            const itemCode=$("#itemCode").val();
            const selectValue=$("#materialStatus").val();
            console.log(selectValue);
            $.ajax({
            	method:"GET",
     		   url:"/purchase/outsourcing/list",
	    		data:{
	    			method:"searchOutSourcingList",
	    			fromDate:fromDate,
	    			toDate:toDate,
	    			customerCode:customerCode,
	    			itemCode:itemCode,
	    			materialStatus:selectValue
	    		},
	    		dataType:"json",
	    		success:function(jsonData){
	    			osWorkOptions.api.setRowData(jsonData.outSourcingList);
	    		}
     	   })
	    }
	    let osWorkOptions;
	    
	    function createOSWorkGrids(){
	    	//??????????????? ?????????
		    const osWorksColumn=[
		    	{headerName: "??????????????????", field: "outsourcingNo"},
		    	{headerName: "??????????????????", field: "materialStatus"},
		    	{headerName: "???????????????", field: "customerName"},
		    	{headerName: "?????????", field: "instructDate"},
		    	{headerName: "?????????", field: "completeDate"},
		    	{headerName: "??????", field: "itemCode"},
		    	{headerName: "??????", field: "itemName"},
		    	{headerName: "??????", field: "unitPrice"},
		    	{headerName: "????????????", field: "instructAmount"},
		    	{headerName: "??????", field: "unitPrice"},
		    	{headerName: "??????", field: "totalPrice"},
		    	{headerName: "??????", field: "completeStatus"},
		    	{headerName: "??????", field: "checkStatus"}
		    ];
		  //??????grid options
		    osWorkOptions={
		    	defaultColDef:{
		    		width:150,
		    		resizable:true,
		    		editable:false
		    	},
		    	columnDefs: osWorksColumn,
		    	rowSelection:'single',
		    	rowData:null
		    };
	        const osWorksContainer = document.querySelector("#osWorks"); //osWork grid div
	        new agGrid.Grid(osWorksContainer,osWorkOptions)
	    }
    </script>
</head>
<body>
	<div>
		<h6 class="title">???? ????????????</h6>
		<!-- ???????????????????????? ??? -->
		<div class="conditionContainer">
			<div class="meterialChoice">
				<label for="materialStatus">????????????</label> 
				<select class="mdb-select md-form colorful-select dropdown-primary"
					id="materialStatus">
					<option value="">--????????????--</option>
					<option>?????????</option>
					<option>????????????</option>
				</select>
			</div>
			<div class="customerCondition">
				????????? <input id="customerTxt" class="custTxt" type="text" placeholder="???????????????" readonly="readonly"/>
				<input type="hidden" id="customerCode"/>
			</div>
		</div>
		<div class="headerContainer">
			<div>
				?????? <input id="itemTxt" type="text" class="itemText" placeholder="????????????" readonly="readonly"/>
				<input type="hidden" id="itemCode"/>															<!-- ???????????? ???????????? value??? ????????????. -->
				<button id="itemCondition" class="btn btn-primary itemCon" data-toggle="modal" data-target="#listModal">
					<i class="fas fa-search"></i>
				</button>
			</div>
			<div class="fromToDate">
				???????????? <input type="text" id="fromDate" placeholder="YYYY-MM-DD ????"
					size="15" style="text-align: center"> &nbsp; ~ &nbsp;<input
					type="text" id="toDate" placeholder="YYYY-MM-DD ????" size="15"
					style="text-align: center">
				<button id="searchBtn" type="button"
					class="searchBtn btn btn-primary">
					??????<i class="fas fa-search"></i>
				</button>
			</div>
		</div>
	</div>
	
	<div style="height: 400px; width:100%;" id="osWorks" class="ag-theme-balham">
	</div>
	
<GI68:listModal/> <!-- ??????????????? -->
</body>
</html>