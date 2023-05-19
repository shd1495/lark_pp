<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../../include/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- Content Row -->
	<div class="row">
		<div class="card shadow col-md-12">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">글쓰기</h6>
			</div>
			<div class="card-body">
				<form class="form-group" action="/board/write" method="post">
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }" />
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<input type="hidden" id="userid" name="userid" value="${pinfo.username }"/>
					</sec:authorize>
					<div>
						<label for="formGroupExampleInput" class="form-label">제목</label>
						<input type="text" class="form-control" id="title" name="title" placeholder="제목" required/>
					</div>
					<hr>
					<div>
						<label for="formGroupExampleInput" class="form-label">내용</label>
						<textarea id="content" name="content" rows="20" class="form-control" placeholder="내용" required></textarea>
					</div>
					<hr>
					<div class="form-group text-right">
						<button type="submit" class="btn btn-primary">쓰기</button>
						<button type="button" class="btn btn-secondary">취소</button>
					</div>
				</form>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@ include file="../../include/footer.jsp"%>