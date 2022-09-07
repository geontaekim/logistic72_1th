<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>assign Authority Group</title>
	<script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
	<style>
		* {
			margin: 0px;
		}
		#ii{

		}
		#wrapper2{
			display: grid;
			grid-template-columns: repeat(2, 1fr);
		}
		.UserInformationGrid{
			top: 30px;
			grid-row: 1;
			grid-column: 1;
		}
		.AuthorityGroupGrid{
			grid-row: 1;
			grid-column: 2;
		}

		h5 {
			position: relative;
			top: 0;
			margin-top: 3px;
			margin-bottom: 3px;
		}

		.ag-header-cell-label {
			justify-content: center;
		}
		.ag-cell-value {
			padding-left: 50px;
		}
		body{
			color: white;
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

 #td2>h5{
	 margin-top: 0px;
 }

	</style>
</head>
<body>
<h4 style="color: black;">📃구매관리</h4>

<table>
	<tr>
		<td id="td2">
			<article class="UserInformationGrid">
				<h5 style="margin-left: 100px; color: black;">📷구매처</h5>
				<div align="center">
					<div id="myGrid1" class="ag-theme-balham" style="margin-left: 100px; height:400px; width:700px; text-align: center;"></div>
				</div>
			</article>
			<article class="UserInformationGrid">
				<h5 style="margin-left: 100px; color: black;">📷집계</h5>
				<div align="center">
					<div id="myGrid3" class="ag-theme-balham" style="margin-left: 100px; height:380px; width:700px; text-align: center;"></div>
				</div>
			</article>
		</td>
		<td>
			</div>
			<article class="AuthorityGroupGrid">
				<h5 style="color: black;">📦구매내역</h5>
				<div align="center">
					<div id="myGrid2" class="ag-theme-balham" style="height:800px; width:900px; text-align: center;"></div>
				</div>
			</article>
		</td>
	</tr>
</table>
<script>
	const myGrid1 = document.querySelector('#myGrid1');
	const myGrid2 = document.querySelector('#myGrid2');
	const myGrid3 = document.querySelector('#myGrid3');
	//사용자 그리드
	let customerColumn = [
		{headerName: "CODE", field: "customerCode"},
		{headerName: "NAME", field: "customerName"},
	];

	let customerRowData = [];
	let customerGridOptions = {
		columnDefs: customerColumn,
		rowSelection: 'single',
		rowData: customerRowData,
		defaultColDef: {editable: false},
		overlayNoRowsTemplate: "구매처 정보가 없습니다.",
		onGridReady: function (event) {
			event.api.sizeColumnsToFit();
		},
		onGridSizeChanged: function (event) {
			event.api.sizeColumnsToFit();
		},
		onRowClicked: function(event) {
			getUserAuthorityGroupData();
			getSumGroupData();
		}
	}



	//권환그룹 그리드
	let cusListColumn = [
		{headerName: "OUTSOURCING_NO", field: "outsourcingNo"},
		{headerName: "CUS_NAME", field: "customerName" , hide: "true"},
		{headerName: "IT_NAME", field: "itemName"},
		{headerName: "INST_DATE", field: "instructDate"},
		{headerName: "COM_DATE", field: "completeDate" , hide:"true"},
		{headerName: "COM_STATUS", field: "completeStatus" ,hide: "true"},
		{headerName: "CHECK_STATUS", field: "checkStatus"},
		{headerName: "Qty", field: "instructAmount"},
		{headerName: "UNIT_PRICE", field: "unitPrice"},
		{headerName: "TOTAL", field: "totalPrice"},
		{headerName: "OUT_DATE", field: "outsourcingDate" ,hide: "true"}

	];
	let cusListRowData = [];
	let customerGetGridOptions = {
		columnDefs: cusListColumn,
		rowSelection: 'multiple',
		rowData: cusListRowData,
		defaultColDef: {editable: false},
		overlayNoRowsTemplate: "BOM 정보가 없습니다.",
		rowMultiSelectWithClick: true,
		onGridReady: function (event) {
			event.api.sizeColumnsToFit();
		},
		onGridSizeChanged: function (event) {
			event.api.sizeColumnsToFit();
		}
	}


	let cusSumListSumColumn = [
		{headerName: "IT_CODE", field: "itemCode"},
		{headerName: "IT_NAME", field: "itemName"},
		{headerName: "Qty", field: "instructAmount"},
		{headerName: "TOTAL", field: "totalPrice"},

	];
	let cusSumListSumRowData = [];
	let customerSumGetGridOptions = {
		columnDefs: cusSumListSumColumn,
		rowSelection: 'multiple',
		rowData: cusSumListSumRowData,
		defaultColDef: {editable: false},
		overlayNoRowsTemplate: "BOM 정보가 없습니다.",
		rowMultiSelectWithClick: true,
		onGridReady: function (event) {
			event.api.sizeColumnsToFit();
		},
		onGridSizeChanged: function (event) {
			event.api.sizeColumnsToFit();
		}
	}


	let CusBomData;
	function getCusData(){
		let xhr = new XMLHttpRequest();
		xhr.open('GET', '${pageContext.request.contextPath}/purchase/outsourcing/list' , true);
		xhr.setRequestHeader('Accept', 'application/json');
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let txt = xhr.responseText;
				CusBomData = JSON.parse(txt).outSourcingList;
				console.log("CusBomData"+CusBomData);
				if (txt.errorCode < 0) {
					Swal.fire({
						text: '데이터를 불러들이는데 오류가 발생했습니다.',
						icon: 'error',
					});
					return;
				}
			}
		}
	}

	let customerGroupData;
	let CusROwNode;
	let CusCode;
	function getUserAuthorityGroupData(){
		CusROwNode = customerGridOptions.api.getSelectedNodes();
		CusCode = CusROwNode[0].data.customerCode;
		console.log("CusCode??"+CusCode);
		let xhr = new XMLHttpRequest();
		xhr.open('GET', '${pageContext.request.contextPath}/purchase/getOutsourcing/list?customerCode='+CusCode ,true);
		xhr.setRequestHeader('Accept', 'application/json');
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let txt = xhr.responseText;
				customerGroupData = JSON.parse(txt).getoutSourcingList;
				// console.log(customerGroupData);
				customerGetGridOptions.api.setRowData(customerGroupData);
				if (txt.errorCode < 0) {
					Swal.fire({
						text: '데이터를 불러들이는데 오류가 발생했습니다.',
						icon: 'error',
					});
					return;
				}
			}
		}
	}

	let customerSumGroupData;
	let CusSumROwNode;
	let CusSumCode;
	function getSumGroupData(){
		CusSumROwNode = customerGridOptions.api.getSelectedNodes();
		CusSumCode = CusSumROwNode[0].data.customerCode;
		console.log("CusSumCode??"+CusSumCode);
		let xhr = new XMLHttpRequest();
		xhr.open('GET', '${pageContext.request.contextPath}/purchase/getSumOutsourcing/list?customerCode='+CusSumCode ,true);
		xhr.setRequestHeader('Accept', 'application/json');
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let txt = xhr.responseText;
				customerSumGroupData = JSON.parse(txt).getSumoutSourcingList;
				// console.log(customerSumGroupData);
				customerSumGetGridOptions.api.setRowData(customerSumGroupData);
				if (txt.errorCode < 0) {
					Swal.fire({
						text: '데이터를 불러들이는데 오류가 발생했습니다.',
						icon: 'error',
					});
					return;
				}
			}
		}
	}


	function setGrid(){
		new agGrid.Grid(myGrid1, customerGridOptions);
		customerGridOptions.api.setRowData(CusBomData);
		new agGrid.Grid(myGrid2, customerGetGridOptions);
		new agGrid.Grid(myGrid3, customerSumGetGridOptions);
		
	}
	document.addEventListener('DOMContentLoaded', () => {
		getCusData();
		setTimeout("setGrid()",200);
	});

</script>
</body>
</html>