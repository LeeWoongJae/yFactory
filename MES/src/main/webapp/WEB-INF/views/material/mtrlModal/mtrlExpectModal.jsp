<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 자재명모달  -->
	<div id="myModal" class="modal fade" tabindex="-1" >
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header"
					style="background-color: #2c3e50; color: white; font-size: small; padding: 10px;">
					<h5 class="modal-title" style="font-size: 17px;">품목코드</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- 모달 내용 -->
				<div class="modal-body">
					<div style="padding-bottom: 20px;">
						<h4>입고예정 목록</h4>
						<div id="expectGrid"></div>
						<div style="padding-right: 10px;">
							<button class="btn1"  type="button" id="select"style="float: left; padding:0px 20px 0px 20px;">선택</button>
						</div>
					</div>
					
				</div>
				<!-- 내용끝 -->
				
			</div>
		</div>
	</div>
	<!-- 모달끝 -->

	<script>
		//자재명 전체조회
		$.ajax({
			url : "expectList",
			method : "GET",
			dataType : "JSON",
			success : function(result) {
				mtrlExpectList.resetData(result);
			}
		});

		var mtrlExpectList = new tui.Grid({
			el : document.getElementById('expectGrid'),
 	       bodyWidth: 600,
			columns : [ {
				header : '원자재발주코드',
				name : '원자재발주코드'
			}, {
				header : '원자재코드',
				name : '원자재코드'
			}, {
				header : '원자재명',
				name : '원자재명'
			}, {
				header : '업체명',
				name : '업체명'
			}, {
				header : '입고량',
				name : '입고량'
			}, {
				header : '검사일자',
				name : '검사일자'
			}
			
			],
			rowHeaders : [ 'checkbox' ],
			pageOptions : {
				useClient : true,
				perPage : 5
			}
		});
		
		 
		  
		  $('body').css("overflow", "hidden");
		  
		  var myModal = document.getElementById('myModal')


		  myModal.addEventListener('shown.bs.modal', function () {
			  //ajax 호출
			  //grid.resetData(data)
			  
		      mtrlExpectList.refreshLayout(); // success 시에 리프레쉬 안되면 이 코드를  대신 넣기
		  })
		  //입고예정등록버튼
  //발주등록버튼
   $("#select").on("click", function(){
        	  let pocd = mtrlExpectList.getCheckedRows();
        	  for (var i = 0; i < pocd.length; i++) {  
        		  /* 원자재발주코드 */
      			    let poCd = pocd[i].원자재발주코드;
        		  /* 원자재코드 */
        			let mtCd = pocd[i].원자재코드;
        		  /* 원자재명  */
        		  	let mtNm = pocd[i].원자재명;
        		  /* 업체명 */
        		  	let vdrNm = pocd[i].업체명;
        		  /* 입고량 */
        		  	let mtWrqty = pocd[i].입고량;	  
        		    console.log(poCd,mtCd,mtNm,vdrNm,mtWrqty);
        		}; 
  });

	</script>
</body>
</html>