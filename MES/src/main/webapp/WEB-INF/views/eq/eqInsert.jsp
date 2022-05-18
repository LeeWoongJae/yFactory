<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
input {
	vertical-align: middle;
	margin : 3px  2px;
}

input.img-button {
	background: url( "assets/img/glass.png" ) no-repeat; border : none;
	width: 32px;
	height: 32px;
	cursor: pointer;
	border: none;
}

.btnpart {
	background-color: #555555;
	color: white;
}

#title {
	font-size: 30px;
}



</style>
</head>
<body>
<div class="container">
	<form name="frm" id="frm" method="post" enctype="multipart/form-data">
	<div class="row">
	<div class="col-8">
	
		<hr  />
		<div align="right">
			<button type="reset" class="button btnpart">초기화</button>
			&nbsp;&nbsp;
			<button type="submit" id="btnok" class="button btnpart">저장</button>
		</div>
		<hr />
		설비명*
					<input id="eq_mdnm" name="eq_mdnm"size=10 maxlength=8>
							
					사용여부
						Y<input	type="radio" id="yes" name="chk" value="Y" checked>
						N<input type="radio" id="no" name="chk" value="N">
			
			<br/><br/>
					구분코드<input id="vdr_cd" name="vdr_cd" size=10 	maxlength=8>
					<input type="button" id="eqdiv" value="조회">
					<input id="eq_nm" size=10 maxlength=8>
					모델번호<input id="eq_mdno" size=10 maxlength=8>
				
		<br /><br/>
		
				
				제작업체<input id="vdr_cd" size=10 	maxlength=8>
				
				UPH*<input id="uph" size=10 maxlength=8>

		 <br /><br/> 
		
					가용온도<input id="eq_min" size=10 maxlength=8>
					<input id="eq_max" size=10 maxlength=8> ℃ 
					점검주기<input 	id="eq_chkcyc" size=10 maxlength=8>
					
		<br/><br/>
		
			등록인<input	id="eq_inster" size=10 maxlength=8>
			구매일자<input type="date"	id="eq_purdt" size=10 maxlength=8>
	
	
	
	
	
	</div>
	
	<div class="col-4">
	<img id="prevu" src="#" onError="this.style.visibility='hidden'" />
	<div class="input-file">
	 	<input type="text" id="imgNm" readonly="readonly" class="file-name" /> 
		<label for="upload02" class="file-label"></label> 
		<input type="file" name="file" id="upldfile" class="file-upload" onchange="readURL(this)" accept="assets/img/*" />

	</div>
	</div>
	
	
	</div>
	</form>

		<hr />
		<div id="modalDiv"></div>

</div>
</body>
<script>
console.log(  $("input[name='chk']:checked").val()  ); // 사용여부 실시간 체크 Y or N



// 이미지 파일 업로드 구현 시도중
function readURL(input) {
    	if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.readAsDataURL(input.files[0]);
		
        //파일이름 가져옴
        var imgNm = input.files[0].name;
        console.log(imgNm);
    
        reader.onload = function (e) {
    	
        	var tempImage=new Image();
        	tempImage.src=reader.result;
        	
        	console.log(tempImage.src);
        	
        	
        	
        	tempImage.onload=function(){
        		var canvas=document.createElement('canvas');
        		var canvasContext=canvas.getContext("2d");
        		
        		
            	var img = new Image();
	        	img.src = e.target.result;
	        	
	        	
        		canvas.width=img.width*0.7;
        		canvas.height=img.height*0.7;
        		
        		canvasContext.drawImage(this,0,0,canvas.width,canvas.height);
        		
        		var dataURI=canvas.toDataURL("image/png");
        		
        		document.querySelector("#prevu").src=dataURI;
        		document.querySelector("#prevu").style.visibility="visible"; 
        	}
        };
    
    	}
	}
	
	
$("#btnok").on("click" , function(){
	//makeUUID(file_nm);
	
	
	 var url = "insertAjax";
	 $.ajax(url , {
		 method : "POST",
		 data: $("#frm").serialize(),
		 dataType:'json',
		 success : function(){alert("DB 접속 완료");}
		 
	 }).done(function(result){
		 // 처리 완료시
		 console.log(result);
		 // 처리후 리턴 페이지 지정
		 $("form").attr('action' , '/eq/eqMng');
		 // submit 진행
		 $("form").submit();
	 })
	/* var bytes, blob; 
	bytes = new Uint8Array(data.blob); 
	blob = new Blob([bytes], {type:'image/bmp'}); 
	data['imgSrc'] = URL.createObjectURL(blob);
	console.log(data['imgSrc']); */
	

	
			
	
})


// UUID 생성 부 - 미사용 중
// 참고 : https://developyo.tistory.com/110
function makeUUID(file_nm){
	   function s4() {
	     return ((1 + Math.random()) * 0x10000 | 0).toString(16).substring(1);
	   }
	   return s4() + s4() + s4() + s4() + s4() + s4() + s4() + s4() + file_nm.substr(file_nm.indexOf("."), file_nm.length-1);
	}




	//console.log($("#upload02").html());

	/* $("#upldfile").change(function(){
		var formData = new FormData($("#frm"));
		$.ajax({
			method:"post",
			url : "/eqinsert",
			data : formData,
			processData : false,
		    dataType : "json",
		    contentType : false,
		    async    : false,
		    success : function(data) {
		            alert("파일 업로드 성공.");
		    },
		    error : function(error) {
		            alert("파일 업로드에 실패하였습니다.");
		           
		        }
		});
	}); */
	
	// 조회 버튼을 클릭시  > 모달 호출
	eqdiv.addEventListener("click" , function(){
		
		//모달 페이지 호출 부
		$("#modalDiv").load("eqdvmodal" , function(){
			const myModal = new bootstrap.Modal('#myModal');
			myModal.show();	
			
			
		})
					
	});

	
		
	/* window.onload = function(){
		   const url = "/eqSelectAjax";
		   $.ajax(url,{
			   dataType : "JSON",
			   method: "GET"
		   }).done(function(result){
			
			  	console.log(result);
				
   			})
		};  */
		
		/* $("#vdr_cd").value = result.eqCd;
		$("#eq_nm").value = result.eqNm; */
		
		
	
				


	
	
	
</script>

</html>
