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
					  <input type="text" class="form-control" aria-label="Sizing example input" value="${user.userName }" readonly>
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
						<button id="btnSubmit" class="btn btn-primary">정보수정</button>
						<a href="/users/userInfo" class="btn btn-secondary">취소</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->
<script>
$(document).ready(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
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