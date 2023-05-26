<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../../include/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">기본 페이지</h1>
	</div>

	<!-- Content Row -->
	<div class="row">
		<div class="card shadow col-md-12">
			<div class="card-body">
				<form id="form" action="/users/userInfoMod" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<h4 class="form-group">회원 정보 수정</h4>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">아이디</span>
					  <input type="text" id="userid" name="userid" class="form-control" aria-label="Sizing example input" value="${user.userid }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">이름</span>
					  <input type="text" id="userName" name="userName" class="form-control" aria-label="Sizing example input" value="${user.userName }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">별명</span>
					  <input type="text" id="nickname" name="nickname" class="form-control" aria-label="Sizing example input" value="${user.nickname }" required>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">이메일</span>
					  <input type="email" id="userEmail" name="userEmail" class="form-control" aria-label="Sizing example input" value="${user.userEmail }" required>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">가입일</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" 
					  		 value='<fmt:formatDate value="${user.regDate }" pattern="yyyy-MM-dd"/>' readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">정보수정일</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" 
					  		 value='<fmt:formatDate value="${user.updateDate }" pattern="yyyy-MM-dd HH:mm"/>' readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">권한</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" value="${user.authList[0].auth }" readonly>
					</div>
					<div class="form-group text-right">
						<button type="button" id="btnMod" class="btn btn-primary">비밀번호 변경</button>
						<button id="btnSubmit" class="btn btn-primary">정보수정</button>
						<a href="/users/userInfo" class="btn btn-secondary">취소</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
<!-- 모달 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">비밀번호 변경</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>현재 비밀번호</label>
					<input type="password" class="form-control" name="password1" id="password1" >
				</div>
				<div class="form-group">
					<label>새 비밀번호</label>
					<input type="password" class="form-control" name="password2" id="password2" >
				</div>
				<div class="form-group">
					<label>새 비밀번호 확인</label>
					<input type="password" class="form-control" name="password3" id="password3" >
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-primary">수정</button>
				<button id="modalCloseBtn" type="button" class="btn btn-secondary"
					data-dismiss="modal">닫기</button>

			</div>
			<!-- modal-footer -->
		</div>
		<!-- modal-content -->
	</div>
	<!-- modal-dialog -->
</div>
</div>
<!-- End of Main Content -->
<script>
$(document).ready(function(){
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//모달창 띄우기
	var modal = $("#myModal");
	var modalInputUserid = $('#userid');
	var modalInputPassword1 = $('#password1');
	var modalInputPassword2 = $('#password2');
	var modalInputPassword3 = $('#password3');
	
	
	
	var modalModBtn = $("#modalModBtn");
	
	$("#btnMod").on("click", function(e){
		e.preventDefault();

		modalInputPassword1.val('');
		modalInputPassword2.val('');
		modalInputPassword3.val('');
		
		modal.modal("show");
	});
	let chk = 0;
	modalModBtn.on("click", function(){
		const checkPassword1 = $('#password1').val();
		const checkPassword2 = $('#password2').val();
		const checkPassword3 = $('#password3').val();
		const userid = $('#userid').val();
		console.log(checkPassword1);
		console.log(checkPassword2);
		console.log(checkPassword3);
		 $.ajax({
             type: 'GET',
             url: '/users/chkPw',
             data: {'userid' : userid ,'checkPassword': checkPassword1},
             datatype: "JSON"
         }).done(function(result){
             if(result == "true"){
                 console.log("비밀번호 일치");
                 chk = 1;
             } else {
                 console.log("비밀번호 틀림");
                 // 비밀번호가 일치하지 않으면
                 alert("비밀번호가 맞지 않습니다.");
                 chk = 0;
             }
         });
        if(!checkPassword1 || checkPassword1.trim() === "" || !checkPassword2 || checkPassword2.trim() === "" 
        		|| !checkPassword3 || checkPassword3.trim() === "" ){
            alert("비밀번호를 입력하세요.");
        } else if(checkPassword2 == checkPassword3){
        	if(confirm("정말로 수정하시겠습니까?")){
  			  $.ajax({
  	                type: 'GET',
  	                url: '/users/userPwMod',
  	                contentType: 'application/json; charset=utf-8',
  	                data: {'userid' : userid ,'changePassword' : checkPassword2},
  	                datatype: "JSON"
  	            }).done(function(result){
  	            	console.log(result);
  	                if(result == "true"){
  	                    alert("비밀번호 변경이 완료되었습니다.");
  	                    window.location.href="/users/userInfo";
  	                } else{
  	                    alert("비밀번호 변경에 실패했습니다");
  	                }
  	            }); 
  		}
        } else {
        	alert("비밀번호가 틀립니다.");
        }
	});
	
	$("#btnSubmit").on("click", function(e){
		e.preventDefault();
		let userid = $("#userid").val();
		let nickname = $("#nickname").val();
		$.ajax({
			url:'/users/idChk',
			type:'get',
			contentType: 'application/JSON; charset=utf-8',
			data: {userid : userid, nickname : nickname},
			dataType:'JSON',
			success:function(result){
				if (result == "3"){
					alert("중복된 별명 입니다.");
				} else if (result == "1"){
					alert("중복된 별명 입니다.");
				} else {
					$("#form").submit();
				}
			}
		});
	});
})
</script>
<%@ include file="../../include/footer.jsp"%>