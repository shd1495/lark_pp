<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				<div class="table-responsive">
					<h4 class="form-group">회원 목록</h4>
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<colgroup>
							<col style="width: 150px;" />
							<col style="width: 150px;" />
							<col style="width: 150px;" />
							<col style="width: 150px;" />
							<col style="width: 180px;" />
							<col style="width: 180px;" />
							<col style="width: 80px;" />
							<col style="width: 100px;" />
						</colgroup>
						<thead>
							<tr>
								<th>회원 아이디</th>
								<th>회원 이름</th>
								<th>회원 별명</th>
								<th>회원 이메일</th>
								<th>회원 등록일시</th>
								<th>회원 정보 수정일시</th>
								<th>권한</th>
								<th>권한 수정</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="cnt" value="0" />
							<c:forEach var="users" items="${list}">
								<tr>
									<td>${users.userid }</td>
									<td>${users.userName }</td>
									<td>${users.nickname }</td>
									<td>${users.userEmail }</td>
									<td><fmt:formatDate value="${users.regDate }"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td><fmt:formatDate value="${users.updateDate }"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td>${users.authList[0].auth }</td>
									<td class="text-center"><a href="/users/userMod?userid=${users.userid}" role="button"
										 class="btn btn-secondary btn-sm btnMod">수정</a></td>
								</tr>
								<c:set var="cnt" value="${cnt+1}" />
							</c:forEach>
							<c:if test="${cnt == 0}">
								<tr>
									<td colspan="5">등록된 회원이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="d-flex justify-content-center nav-li" style="margin-top: 27px;">
					<!-- search results navigation -->
					<nav class="search-results-navigation">
						<div class="col-md-4"></div>
						<ul class="pagination m-0">
							<c:if test="${pageMaker.prev }">
								<li class="paginate_button page-item previous">
									<a href="${pageMaker.startPage-1}" aria-control="dataTable" class="page-link">이전</a>
								</li>
							</c:if>
							<c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								<li class="paginate_button page-item ${pageMaker.cri.pageNum == num?"active":"" }">
									<a class="page-link" href="${num}">${num}</a>
								</li>
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<li class="paginate_button page-item next">
									<a href="${pageMaker.endPage+1}" aria-control="dataTable" class="page-link">다음</a>
								</li>
							</c:if>
						</ul>
					</nav>
					<!-- END search-results-navigation -->
				</div>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->
</div>
<!-- End of Main Content -->

<script src="../../resources/js/list.js"></script>
<%@ include file="../../include/footer.jsp"%>