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

		h5 {
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

	</style>
</head>
<body>
<h4 style="color: black;">📃BOM 자재명세서</h4>

<table>
	<tr>
		<td>
			<article class="UserInformationGrid">
				<h5 style="margin-left: 200px; color: black;">📷ITEM</h5>
				<div align="center">
					<div id="myGrid1" class="ag-theme-balham" style="margin-left: 100px; height:500px; width:700px; text-align: center;"></div>
				</div>
			</article>
		</td>
		<td>
			</div>
			<article class="AuthorityGroupGrid">
				<h5 style="color: black;">📦소요자재</h5>
				<div align="center">
					<div id="myGrid2" class="ag-theme-balham" style="height:500px; width:700px; text-align: center;"></div>
				</div>
			</article>
		</td>
	</tr>
</table>

<script>
	const myGrid1 = document.querySelector('#myGrid1');
	const myGrid2 = document.querySelector('#myGrid2');
	//사용자 그리드
	let parentBomColumn = [
		{headerName: "CODE", field: "itemCode"},
		{headerName: "NAME", field: "itemName"},
		{headerName: "LEAD_TIME", field: "leadTime",hide:"true"},
		{headerName: "PRICE", field: "standardUnitPrice",hide:"true"},
		{headerName: "P_CODE", field: "parentItemCode",hide:"true"},
		{headerName: "LEVEL", field: "no"},
		{headerName: "N_QTY", field: "netAmount", hide:"true"}
	];

	let parentBomRowData = [];
	let parentBomGridOptions = {
		columnDefs: parentBomColumn,
		rowSelection: 'single',
		rowData: parentBomRowData,
		defaultColDef: {editable: false},
		overlayNoRowsTemplate: "BOM 정보가 없습니다.",
		onGridReady: function (event) {
			event.api.sizeColumnsToFit();
		},
		onGridSizeChanged: function (event) {
			event.api.sizeColumnsToFit();
		},
		onRowClicked: function(event) {
			getUserAuthorityGroupData();
		}
	}



	//권환그룹 그리드
	let childBomColumn = [
		{headerName: "CODE", field: "itemCode"},
		{headerName: "NAME", field: "itemName"},
		{headerName: "LEAD_TIME", field: "leadTime",hide:"true"},
		{headerName: "PRICE", field: "standardUnitPrice"},
		{headerName: "P_CODE", field: "parentItemCode"},
		{headerName: "LEVEL", field: "no"},
		{headerName: "N_QTY", field: "netAmount"}
	];
	let childBomRowData = [];
	let childBomGridOptions = {
		columnDefs: childBomColumn,
		rowSelection: 'multiple',
		rowData: childBomRowData,
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

	let ParentBomData;
	function getEmployeeData(){
		let xhr = new XMLHttpRequest();
		xhr.open('GET', '${pageContext.request.contextPath}/bom/parent/list' , true);
		xhr.setRequestHeader('Accept', 'application/json');
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let txt = xhr.responseText;
				ParentBomData = JSON.parse(txt).bomList;
				console.log(ParentBomData);
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

	let childBomGroupData;
	let BomRowNode;
	let itemCode;
	function getUserAuthorityGroupData(){
		BomRowNode = parentBomGridOptions.api.getSelectedNodes();
		itemCode = BomRowNode[0].data.itemCode;
		console.log("itemCode??"+itemCode);
		let xhr = new XMLHttpRequest();
		xhr.open('GET', '${pageContext.request.contextPath}/bom/child/bomlist?itemCode='+itemCode ,true);
		xhr.setRequestHeader('Accept', 'application/json');
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let txt = xhr.responseText;
				childBomGroupData = JSON.parse(txt).bomChildList;
				// console.log(childBomGroupData);
				childBomGridOptions.api.setRowData(childBomGroupData);
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
		new agGrid.Grid(myGrid1, parentBomGridOptions);
		parentBomGridOptions.api.setRowData(ParentBomData);
		new agGrid.Grid(myGrid2, childBomGridOptions);
	}
	document.addEventListener('DOMContentLoaded', () => {
		getEmployeeData();
		setTimeout("setGrid()",200);
	});

</script>
</body>
</html>