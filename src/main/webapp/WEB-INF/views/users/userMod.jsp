<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../../include/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">관리자 페이지</h1>
	</div>

	<!-- Content Row -->
	<div class="row">
		<div class="card shadow col-md-12">
			<div class="card-body">
				<h4 class="form-group">회원 권한 수정</h4>
				<form action="/users/userMod" method="post">
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }" />
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">아이디</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" name="userid" value="${user.userid }" readonly>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">이름</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" value="${user.userName }" disabled>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">가입일</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" 
					  		 value='<fmt:formatDate value="${user.regDate }" pattern="yyyy-MM-dd"/>' disabled>
					</div>
					<div class="input-group mb-3">
					  <span class="input-group-text" id="inputGroup-sizing-default">권한</span>
					  <input type="text" class="form-control" aria-label="Sizing example input" value="${user.authList[0].auth }" disabled>
					  <select name="auth" class="form-control col-md-2">
					  	<option value="USER">USER</option>
					  	<option value="ADMIN">ADMIN</option>
					  </select>
					</div>
					<div class="text-right">
						<button type="submit" class="btn btn-primary">수정</button>
						<a href="/users/list" class="btn btn-secondary">취소</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@ include file="../../include/footer.jsp"%>