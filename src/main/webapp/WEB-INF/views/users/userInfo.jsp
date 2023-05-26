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
				<h4 class="form-group">회원 정보</h4>
				<form id="form" method="post" action="/users/userInfoDel">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">아이디</span>
					  <input type="text" class="form-control" name="userid" aria-label="Sizing example input" value="${user.userid }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">이름</span>
					  <input type="text" class="form-control" name="userName" aria-label="Sizing example input" value="${user.userName }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">별명</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" value="${user.nickname }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">이메일</span>
					  <input type="email" class="form-control" name="userEmail" aria-label="Sizing example input" value="${user.userEmail }" readonly>
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
					<div class="form=-group text-right">
						<a id="btnMod" href="/users/userInfoMod" class="btn btn-primary">정보수정</a>
						<button id="btnCan" class="btn btn-danger">회원탈퇴</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->

</div>
<!-- 모달 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">비밀번호 확인</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>아이디</label>
					<input class="form-control" name="userid" id="userid" value="${user.userid }" readonly>
				</div>
				<div class="form-group">
					<label>비밀번호</label>
					<input type="password" class="form-control" name="password" id="password" >
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
	var modalInputPassword = $('#password');
	
	
	var modalModBtn = $("#modalModBtn");
	
	$("#btnMod").on("click", function(e){
		e.preventDefault();

		modalInputUserid.val("${user.userid}");
		modalInputPassword.val('');
		
		modal.modal("show");
	});
	
	modalModBtn.on("click", function(){
		const checkPassword = $('#password').val();
		const userid = $('#userid').val();
		console.log(userid);
		console.log(checkPassword);
        if(!checkPassword || checkPassword.trim() === ""){
            alert("비밀번호를 입력하세요.");
        } else{
            $.ajax({
                type: 'GET',
                url: '/users/chkPw',
                data: {'userid' : userid ,'checkPassword': checkPassword},
                datatype: "JSON"
            }).done(function(result){
                if(result == "true"){
                    console.log("비밀번호 일치");
                    window.location.href="/users/userInfoMod";
                } else {
                    console.log("비밀번호 틀림");
                    // 비밀번호가 일치하지 않으면
                    alert("비밀번호가 맞지 않습니다.");
                }
            });
        }
	});
	
	
	$("#btnCan").on("click", function(e){
		e.preventDefault();
		if(confirm("정말 탈퇴하시겠습니까?")){
			$("#form").submit();
		}
	});
});
</script>
<%@ include file="../../include/footer.jsp"%>