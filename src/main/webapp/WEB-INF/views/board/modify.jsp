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
				<form role="form" id="actionForm" class="form-group" action="/board/modify" method="post">
					<input type="hidden" name="pageNum" value="${cri.pageNum }"> <!-- 페이지 번호 -->
					<input type="hidden" name="amount" value="${cri.amount }"> <!-- 페이지 표시 글 수 -->
					<input type="hidden" name="type" value="${cri.type }"> <!-- 검색 설정 값 -->
					<input type="hidden" name="keyword" value="${cri.keyword }"> <!-- 검색어 -->
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" /> <!-- csrf -->
					<input type="hidden" name="bno" value="${board.bno}"> <!-- 글 번호 -->
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
						<button type="submit" class="btn btn-primary" data-oper="modify">수정</button>
						<button type="submit" class="btn btn-warning" data-oper="remove">삭제</button>
						<button type="submit" class="btn btn-secondary" data-oper="list">목록</button>
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
	
	let formObj = $("form[role=form]");
	
	//수정, 삭제, 목록 버튼 눌렀을 시
	$("button[type=submit]").on("click", function(event){
		event.preventDefault();
		
		let operation = $(this).data('oper');
		
		//수정 버튼 눌렀을 시 수정 데이터 전송 및 첨부파일 
		if(operation === 'modify'){
			let str = "";
			
			$(".uploadResult ul li").each(function(i, obj){
				let jobj = $(obj);
				
				let type = (jobj.data('type') == true)?"1":"0";

				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data('filename')+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data('uuid')+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data('path')+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+type+"'>";
			});
			
			formObj.append(str);
			
		//삭제 버튼 눌렀을 시 삭제 확인 메시지 출력 후 삭제				
		} else if(operation === 'remove'){
			if(confirm("정말로 삭제하시겠습니까?")){
				$("#actionForm").attr("action", "/board/remove");
			} else {
				return false;
			}
		//목록 버튼 눌렀을 시 페이징 값과 함께 목록으로 이동
		} else if(operation === 'list'){
			$("#actionForm").attr("action", "/board/list");
			$("#actionForm").attr("method", "get");
			
			let pageNumTag = $("input[name=pageNum]").clone();
			let amountTag = $("input[name=amount]").clone();
			let typeTag = $("input[name=type]").clone();
			let keywordTag = $("input[name=keyword]").clone();
			
			$("#actionForm").empty();
			$("#actionForm").append(pageNumTag);
			$("#actionForm").append(amountTag);
			$("#actionForm").append(typeTag);
			$("#actionForm").append(keywordTag);
		}
		
		formObj.submit();
	});
	
});
</script>
<%@ include file="../../include/footer.jsp"%>