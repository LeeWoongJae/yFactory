<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>YAFS EQUIPMENT MANAGE PAGE</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/toast/css/tui-grid.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/toast/css/tui-pagination.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/toast/css/tui-chart.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>


<style>
.inSearch {
	background-color: #555555;
	color: white;
	font-family: "Audiowide", sans-serif;

}

.inSearch:hover {
	color: black;
	background-color: white;
}



</style>

</head>
<body>
	<h1>설비 관리</h1>
	<div id="in/out"></div>
	<div style="background-color: #e0e0e0; padding: 8px;">
		<div class="mainTitle" style="padding-bottom: 15px; color:;">
			<h3>설비 데이터</h3>
			<div style="padding-right: 10px;" align="right">
			<button type="button" id="eqUpd" class="inSearch">설비 수정</button>
			</div>
			<hr style="border: solid 1px gray;">
			
		</div>



		<div id="grid"></div>
		<div id="grid1"></div>
		

	</div>
	<script type="text/javascript">
	// 지역변수로 윈도우에 선언이되있으니까 자식에서 못쳐가지고오는거죠~ 
	// 그래서 전역으로 돌려야함 숙지하도록 ㅅㄱ 
	var grid;
	var rowKey;
	var gridRowCell;
		window.onload = function() {
			const url = "getEqMngList";
			$.ajax(url, {
				dataType : "JSON",
				method : "GET"
			}).done(function(result) {
				grid.resetData(result);
				console.log(result);
			})

			 grid = new tui.Grid({
				el : document.getElementById('grid'),
				scrollX : false,
				scrollY : false,
				columns : [ {
					header : '설비코드',
					name : '설비코드',
				}, {
					header : '설비명',
					name : '설비명',
				}, {
					header : '공정코드',
					name : '공정코드',
				}, {
					header : '공정명',
					name : '공정명',
					editor : "text"
				}, {
					header : '최저온도',
					name : '최저온도',
					editor : "text"
				}, {
					header : '최고온도',
					name : '최고온도',
					editor : "text"
				}, {
					header : '구매일자',
					name : '구매일자',
					editor : {
						type : 'datePicker',
						options : {
							format : 'yyyy-MM-dd'
						}
					}
				},

				{
					header : '사용여부',
					name : '사용여부',
					 editor: {
	                     type: 'select',
	                     options: {
	                       listItems: [
	                         {
	                           text: 'Y',
	                           value: 'USE01'
	                         },
	                         {
	                           text: 'N',
	                           value: 'USE02'
	                         }
	                    ]
	                 }
	            }
				}, ],
				 rowHeaders: [ { type: 'checkbox' },{ type: 'rowNum' }],
				pageOptions : {
					useClient : true,
					perPage : 10
				}
			});
			
			
			
			
			grid.on("dblclick",function(e) {
				//debugger
				//let eqCd = grid.getValue(e.rowKey, '설비코드');
				console.log("Parent_e.rowKey: "+e.rowKey);
				rowKey = e.rowKey;
				gridRowCell = grid.getFocusedCell().rowKey;
				
				let eqCdCol = grid.getFocusedCell('설비코드');
				let eqPrcCol = grid.getFocusedCell('공정코드');
					if(eqCdCol.columnName == '설비코드'){ // 설비코드 컬럼을 클릭했다면
						$("#grid1").load("mngmodal", function(){

							const mngModal = new bootstrap.Modal('#myModal');
							mngModal.show();
							console.log("gridRowCell"+gridRowCell);
							
							
						
							});
					}
					else if(eqCdCol.columnName == '공정코드'){ // 설비코드 컬럼을 클릭했다면
						$("#grid1").load("eqPrcmodal", function(){
							const mngModal = new bootstrap.Modal('#myModal');
							mngModal.show();
							
							});
					}
				
				
			});
		
		
		
		  $("#eqUpd").click(function () {
			  
			var chkRows = grid.getCheckedRows();
			var updRowArr = [];
			var data = {};
			console.log(chkRows);
			console.log(JSON.stringify(chkRows));
			for (var i = 0; i < chkRows.length; i++) {
				data = {
						eq_cd : chkRows[i].설비코드 , 
						eq_nm : chkRows[i].설비명 ,
						proc_cd : chkRows[i].공정코드 ,
						proc_nm : chkRows[i].공정명 ,
						eq_min : chkRows[i].최저온도 ,
						eq_max : chkRows[i].최고온도 ,
						eq_purdt : chkRows[i].구매일자 ,
						eq_actst : chkRows[i].사용여부 
				};
				updRowArr.push(data);
			}
			  
		        Swal.fire({
		            title: '정말 수정 하시겠습니까?',
		            icon: 'warning',
		            showCancelButton: true,
		            confirmButtonColor: '#3085d6',
		            cancelButtonColor: '#d33',
		            confirmButtonText: '수정',
		            cancelButtonText: '취소'
		        }).then((result) => {
		        	console.log(result);
		        	console.log(result.isConfirmed); // 승인시 FALSE / 취소시 TRUE
		            if (result.isConfirmed) {
		            	
		            	 $.ajax({
			            	   url : "eqMngUpdateAjax",
			            	   method: "POST",
			            	   traditional : true,
			            	   data : data,
			            	   dataType : "JSON",
			            	   contentType : "application/json; charset=utf-8"
			            	   
			            	   
			               }).done(function(){
			            	   toastr.success('수정완료!');
			            	   Swal.fire(
					                    '수정이 완료되었습니다.',
					                    '',
					                    'success'
					                		);
			               }); 
		            }else{
		            	Swal.fire(
		                        '수정이 취소되었습니다.',
		                        '',
		                        'error'
		                    )
		            }
		        })
		    });
		
		
		}	
		
		
	</script>



</body>
<%-- <script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/toast/js/tui-pagination.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/toast/js/tui-grid.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/toast/data/dummy.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/toast/js/tui-chart.js"></script> --%>



</html>