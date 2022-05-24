<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>

   <div style="padding-bottom:15px; color: ;">

      <h3>생산지시조회</h3>


   </div>
   
   <div class="min1">
			<div class="mainTitle" style="padding: 15px;">
				<!-- 구분 -->				
				<fieldset class="col-md-5" style="padding-bottom: 10px;">				
                  	<div class="input-group">
                  		<p style="padding-right: 30px;">구분</p>
	                    <div class="form-check">

	                      <input class="form-check-input" type="radio" name="radios" id="radioA" value="전체" checked>
	                      <label class="form-check-label" for="gridRadios1" style="padding-right: 10px;">
	                        전체
	                      </label>
	                    </div>
	                    <div class="form-check">
	                      <input class="form-check-input" type="radio" name="radios" id="radioB" value="진행">
	                      <label class="form-check-label" for="gridRadios2" style="padding-right: 10px;">
	                        진행
	                      </label>
	                    </div>
	                    <div class="form-check">
	                      <input class="form-check-input" type="radio" name="radios" id="radioC" value="완료">
	                      <label class="form-check-label" for="gridRadios3" style="padding-right: 10px;">
	                        완료

	                      </label>
	                    </div>        
                    </div>                              
                </fieldset>
                <form>


				<!-- 납품일자 -->
				<div class="col-md-12">
					<div class="input-group">
						<label for="inputText" class="col-form-label"

							style="padding-right: 10px;">지시일자</label>
						<div class="col-sm-2">
							<input type="date" class="form-control" id="dateA">

						</div>

						<div style="padding: 0px 15px 0px 15px;">
							<p>~</p>
						</div>
						<div class="col-sm-2" style="padding-right: 20px;">

							<input type="date" class="form-control" id="dateB">
						</div>

						<div style="padding-right: 10px;">
							<button type="button" id="btnSearch" class="btn1">검색</button>							
						</div>

						<div>
							<button type="reset" id="btnReset" class="btn1">초기화</button>

						</div>
					</div>
				</div>
					</form>

			</div>
			<hr style="border: solid 1px gray;">

			<!-- 테이블 -->

			<div id="procOrderGrid"></div>


            </div>


<script type="text/javascript">

/* document.getElementById('dateA').value = new Date().toISOString().substring(0, 10);
document.getElementById('dateB').value = new Date().toISOString().substring(0, 10);  */

//업체명 modal


/* 주문서 전체 조회 */
window.onload = function (){
		
   const url = "procOrderSelect";
   let date1 = '';
	let date2 = ''; 
   let state = ''; 
	var data = {
   	date1 : date1,
   	date2 : date2,
   	state : state
   }
   $.ajax(url,{
      dataType : "JSON",
      data : JSON.stringify(data),
      type : "POST",
      contentType : "application/json; charset=utf-8"
   }).done(function(result){
	   procOrderGrid.resetData(result);
     console.log(result);
   })
   
   var procOrderGrid = new tui.Grid({
       el: document.getElementById('procOrderGrid'),

       scrollX: false,
       scrollY: false,
       columns: [
         {

           header: '생산지시코드',
           name: '생산지시코드',
         },
         {
             header: '제품코드',
             name: '제품코드',
           },
           {
               header: '제품명',
               name: '제품명',
             },
             {
                 header: '생산수량',
                 name: '생산수량',
               },
             {
                 header: '라인코드',
                 name: '라인코드',
               },
               {
                   header: '지시우선순위',
                   name: '지시우선순위',
                 },
                 {
                     header: '진행구분',
                     name: '진행구분',
                   },
                   {
                       header: '비고',
                       name: '비고',

                     }],
                  rowHeaders: ['rowNum'],
                     pageOptions: {
                         useClient: true,
                         perPage: 5
                    }
     });


   $("#btnSearch").on("click", function() { 

		 date1 = $("#dateA").val();
		 date2 = $("#dateB").val();
	     state = $("input[name=radios]:checked").val();
		   	var data = {
		        	date1 : date1,
		        	date2 : date2,
		        	state : state
		        }
	    $.ajax({
	        url : "procOrderSelect",
	        data : JSON.stringify(data),
	        dataType: 'JSON',
	        type : 'POST',
	        contentType : "application/json; charset=utf-8"
	     }).done(function(result){
	    	 procOrderGrid.resetData(result);
	         console.log(result);
	          
	     });
	    

	   
	});
   

	setTimeout(function(){
		
		procOrderGrid.refreshLayout();
	},300);

/* $('#btnReset').on('click',function(){

	const url = "salesOrder";
	   $.ajax(url,{
	      dataType : "JSON",
	      method: "GET"
	   }).done(function(result){
	      grid.resetData(result);
	     console.log(result);
	   });

}) */

}
  </script>

</body>



</html>