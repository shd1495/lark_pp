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
				<h6 class="m-0 font-weight-bold text-primary">자유게시판 > ${board.bno} > 수정 페이지</h6>
			</div>
			<div class="card-body">
				<form class="form-group" action="/board/write" method="post">
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
					<input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword" value="${cri.keyword }">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<input type="hidden" id="userid" name="userid" value="${pinfo.username }"/>
					</sec:authorize>
					<div>
						<label class="form-label col-md-8">제목</label>
						<label class="form-label col-md-3">작성자 : ${board.userid}</label>
						<input type="text" class="form-control" id="title" name="title" placeholder="제목" value="${board.title}" required/>
					</div>
					<hr>
					<div>
						<label class="form-label col-md-8">내용</label>
						<label class="form-label col-md-3">수정일시 : 
							<fmt:formatDate value="${board.updateDate }" pattern="yyyy-MM-dd HH:mm" /></label>
						<textarea id="content" name="content" rows="20" class="form-control" placeholder="내용" required>${board.content}</textarea>
					</div>
					<hr>
					<div class="form-group text-right">
						<a href="/board/modify" class="btn btn-primary">완료</a>
						<a href="/board/get${cri.listLink }&bno=${board.bno}" class="btn btn-secondary">취소</a>
					</div>
				</form>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@ include file="../../include/footer.jsp"%>