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
					  <input type="text" class="form-control" aria-label="Sizing example input" value="${user.userName }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">별명</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" value="${user.nickname }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">이메일</span>
					  <input type="email" class="form-control" aria-label="Sizing example input" value="${user.userEmail }" readonly>
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
						<a href="/users/userInfoMod" class="btn btn-primary">정보수정</a>
						<button id="btnDel" class="btn btn-danger">회원탈퇴</button>
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
	$("#btnDel").on("click", function(e){
		e.preventDefault();
		if(confirm("정말 탈퇴하시겠습니까?")){
			$("#form").submit();
		}
	});
});
</script>
<%@ include file="../../include/footer.jsp"%>