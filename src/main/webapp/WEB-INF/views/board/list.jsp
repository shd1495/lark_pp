<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../include/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">게시글 목록</h1>
	</div>

	<!-- Content Row -->
	<div class="row">
		<div class="card shadow col-md-12">
			<div class="card-body">
				<div class="table-responsive">
					<div class="form-group text-right">
						<a href="/board/write" class="btn btn-primary">글쓰기</a>
					</div>
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<colgroup>
							<col style="width:80px;"/>
							<col style="width:150px;"/>
							<col style="width:auto;"/>
							<col style="width:250px;"/>
							<col style="width:75px;"/>
						</colgroup>
						<thead>
							<tr>
								<th>글번호</th>
								<th>작성자</th>
								<th>제목</th>
								<th>등록일시</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="cnt" value="0"/>							
							<c:forEach var="board" items="${list}">
								<tr>
									<td>${board.bno }</td>
									<td>${board.userid }</td>
									<td><a href="${board.bno}" class="getBoard">${board.title }</a> 
									<span class="badge badge-primary">${board.replyCnt }</span></td>
									<td><fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd HH:mm"/></td>
									<td>${board.hit }</td>
								</tr>
							<c:set var="cnt" value="${cnt+1}"/>
							</c:forEach>
							<c:if test="${cnt == 0}">
								<tr>
									<td colspan="5">등록된 글이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@ include file="../../include/footer.jsp"%>