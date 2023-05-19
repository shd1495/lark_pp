<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../include/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">자유게시판</h1>
	</div>

	<!-- Content Row -->
	<div class="row">
		<div class="card shadow col-md-12">
			<div class="card-body">
				<div class="table-responsive">
					<div class="form-group text-right">
						<a href="/board/write" class="btn btn-primary">글쓰기</a>
					</div>
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<colgroup>
							<col style="width: 80px;" />
							<col style="width: 150px;" />
							<col style="width: auto;" />
							<col style="width: 250px;" />
							<col style="width: 75px;" />
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
							<c:set var="cnt" value="0" />
							<c:forEach var="board" items="${list}">
								<tr>
									<td>${board.bno }</td>
									<td>${board.userid }</td>
									<td><a href="${board.bno}" class="getBoard">${board.title }</a>
										<span class="badge badge-primary">${board.replyCnt }</span></td>
									<td><fmt:formatDate value="${board.regDate }"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td>${board.hit }</td>
								</tr>
								<c:set var="cnt" value="${cnt+1}" />
							</c:forEach>
							<c:if test="${cnt == 0}">
								<tr>
									<td colspan="5">등록된 글이 없습니다.</td>
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
								<li style="margin-right: 10px;"><a href="${pageMaker.startPage-1}"
									aria-label="Previous"> <span aria-hidden="true"><i
											class="fa fa-chevron-left"></i></span>
								</a></li>
							</c:if>
							<c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								<li style="margin-right: 10px;"><a role="button" 
									class="${pageMaker.cri.pageNum == num?"active":"" } btn btn-primary btn-sm" href="${num}">${num}</a></li>
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<li><a href="${pageMaker.endPage+1}" aria-label="Next">
										<span aria-hidden="true"><i class="fa fa-chevron-right"></i></span>
								</a></li>
							</c:if>
						</ul>
					</nav>
					<!-- END search-results-navigation -->
				</div>
				<div class="d-flex justify-content-center" style="margin-top: 27px;">
					<form id="searchForm" class="form-inline">
						<input type="hidden" name="pageNum"
							value="${pageMaker.cri.pageNum}"> <input type="hidden"
							name="amount" value="${pageMaker.cri.amount}">
							<select name="type" class="form-control col-md-2">
								<option value="">전체</option>
								<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>제목</option>
								<option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>내용</option>
								<option value="W" ${pageMaker.cri.type eq "W"?"selected":"" }>작성자</option>
								<option value="TC" ${pageMaker.cri.type eq "TC"?"selected":"" }>제목OR내용</option>
								<option value="TW" ${pageMaker.cri.type eq "TW"?"selected":"" }>제목OR작성자</option>
								<option value="TWC"
									${pageMaker.cri.type eq "TWC"?"selected":"" }>제목OR내용OR작성자</option>
							</select>
							<input type="text" name="keyword" class="form-control col-md-8" value="${pageMaker.cri.keyword}">
						<div class="form-group">
							<button class="btn btn-secondary">Search</button>
						</div>
					</form>
				</div>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->
</div>
<!-- End of Main Content -->
<form id="actionForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	<input type="hidden" name="type" value="${pageMaker.cri.type}">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>

<script>
	$(document).ready(
			function() {

				//페이징에 a태그를 클릭했을때
				$(".pagination a").on("click", function(event) {
					event.preventDefault();
					$("input[name=pageNum]").val($(this).attr("href"));
					$("#actionForm").attr("action", "/board/list");
					$("#actionForm input[name=bno]").remove();
					$("#actionForm").submit();
				});

				//검색
				$("#searchForm button").on("click", function(event) {

					if ($("#searchForm").find("option:selected").val() == '') {
						return true;
					}

					event.preventDefault();

					if (!$("#searchForm").find("input[name=keyword]").val()) {
						alert("키워드를 입력하세요");
						return false;
					}

					if (!$("#searchForm").find("option:selected").val()) {
						alert("검색종류를 선택하세요");
						return false;
					}

					$("#searchForm").find("input[name=pageNum]").val(1);

					$("#searchForm").submit();

				});

				//제목 클릭했을때 actionform - hidden에 bno 값 추가 후 전송 및 삭제
				$(".getBoard").on(
						"click",
						function(event) {
							event.preventDefault();

							$("#actionForm input[name=bno]").remove();
							$("#actionForm").append(
									"<input type='hidden' name='bno' value='"
											+ $(this).attr("href") + "'>");
							$("#actionForm").attr("action", "/board/get");

							$("#actionForm").submit();

						});

			});
</script>
<%@ include file="../../include/footer.jsp"%>