<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../../include/header.jsp"%>

<style>
.bigPictureWrapper {
position:absolute;
display: none;
justify-content: center;
align-items: center;
top:0%;
width:100%;
height:100%;
background-color: gray;
z-index:100;
background: rgba(255,255,255, 0.5);
}

.bigPicture{
position: relative;
display: flex;
justify-content: center;
align-items: center;

}
.bigPicture img {
width: 600px;
}
</style>

<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- Content Row -->
	<div class="row">
		<div class="card shadow col-md-12">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">자유게시판 >
					${board.bno}</h6>
			</div>
			<div class="card-body">
				<form role="form" id="actionForm" class="form-group"
					action="/board/modify">
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
					<input type="hidden" name="type" value="${cri.type }"> <input
						type="hidden" name="keyword" value="${cri.keyword }"> <input
						type="hidden" name="bno" value="${board.bno}">
					<div>
						<label class="form-label col-md-8">제목</label> <label
							class="form-label col-md-3">작성자 : ${board.userid}</label> <input
							type="text" class="form-control" id="title" name="title"
							placeholder="제목" value="${board.title}" readonly />
					</div>
					<hr>
					<div>
						<label class="form-label col-md-8">내용</label> <label
							class="form-label col-md-3">수정일시 : <fmt:formatDate
								value="${board.updateDate }" pattern="yyyy-MM-dd HH:mm" /></label>
						<textarea id="content" name="content" rows="20"
							class="form-control" placeholder="내용" readonly>${board.content}</textarea>
					</div>
					<hr>
					<div class="form-group text-right">
						<sec:authentication property="principal" var="pinfo" />
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.username eq  board.userid}">
								<button type="submit" class="btn btn-primary" data-oper="modify">수정</button>
							</c:if>
						</sec:authorize>
						<button type="submit" class="btn btn-secondary" data-oper="list">목록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="row">
			<div class="card shadow col-md-12">
				<div class="card-header py-3">파일첨부</div>
				<div class="card-body">
					<div class="uploadResult">
						<ul>
						
						</ul>
					</div>
				</div>
			</div>
		</div>
	<div class="row">
		<div class="card shadow col-md-12">
			<div>
				<div class="card-header py-3 d-flex justify-content-between">
					<i class="fa fa-comments fa-fw">댓글</i>
					<div class="text-right">
						<sec:authorize access="isAuthenticated()">
							<button id="addReplyBtn" class="btn btn-primary btn-sm">댓글 쓰기</button>
						</sec:authorize>
					</div>
				</div>
				<div class="card-body">
					<ul class="chat">
						<li class="left clearfix" data-rno="12">
							<div>
								<div class="header" >
									<strong class="primary-font">user00</strong> <small
										class="pull-right text-muted">2023-04-18 11:45:</small>
								</div>
								<p>Good job!</p>
							</div>
						</li>
					</ul>
				</div>
				<div id="replyPage" class="card-footer text-center">여기에 댓글페이징</div>

			</div>
			<!-- END column -->
		</div>
	</div>
	<!-- /.container-fluid -->
</div>
<!-- End of Main Content -->
<!-- 모달 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글창</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>댓글 내용</label>
					<textarea class="form-control" name="reply" id="reply"></textarea>
				</div>
				<div class="form-group">
					<label>댓글 작성자</label> <input class="form-control" name="replyer"
						id="replyer" readonly>
				</div>
				<div class="form-group">
					<label>작성날짜</label> <input class="form-control"
						name="replyDate" id="replyDate" readonly>
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-primary">수정</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-warning">삭제</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-success">등록</button>
				<button id="modalCloseBtn" type="button" class="btn btn-secondary"
					data-dismiss="modal">닫기</button>

			</div>
			<!-- modal-footer -->
		</div>
		<!-- modal-content -->
	</div>
	<!-- modal-dialog -->
</div>
<!-- modal fade -->
<!-- 모달 끝 -->
<!-- 빅그림 -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>
<script src="../../resources/js/reply.js"></script>
<script>
$(document).ready(function() {
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});

	let formObj = $("form[role=form]");

	//수정, 삭제, 목록 버튼 눌렀을 시
	$("button[type=submit]").on("click", function(event) {
		event.preventDefault();
	
		let operation = $(this)
				.data('oper');
	
		//수정 버튼 눌렀을 시 수정 데이터 전송 및 첨부파일 
		if (operation === 'modify') {
			let str = "";
	
			$(".uploadResult ul li").each(function(i, obj) {
								let jobj = $(obj);
	
								let type = (jobj
										.data('type') == true) ? "1"
										: "0";
	
								str += "<input type='hidden' name='attachList["
										+ i
										+ "].fileName' value='"
										+ jobj
												.data('filename')
										+ "'>";
								str += "<input type='hidden' name='attachList["
										+ i
										+ "].uuid' value='"
										+ jobj
												.data('uuid')
										+ "'>";
								str += "<input type='hidden' name='attachList["
										+ i
										+ "].uploadPath' value='"
										+ jobj
												.data('path')
										+ "'>";
								str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+type+"'>";
							});
	
			formObj.append(str);
	
			//삭제 버튼 눌렀을 시 삭제 확인 메시지 출력 후 삭제				
		} else if (operation === 'remove') {
			if (confirm("정말로 삭제하시겠습니까?")) {
				$("#actionForm").attr(
						"action",
						"/board/remove");
			} else {
				return false;
			}
			//목록 버튼 눌렀을 시 페이징 값과 함께 목록으로 이동
		} else if (operation === 'list') {
			$("#actionForm").attr("action",
					"/board/list");
			$("#actionForm").attr("method",
					"get");
	
			let pageNumTag = $(
					"input[name=pageNum]")
					.clone();
			let amountTag = $(
					"input[name=amount]")
					.clone();
			let typeTag = $(
					"input[name=type]")
					.clone();
			let keywordTag = $(
					"input[name=keyword]")
					.clone();
	
			$("#actionForm").empty();
			$("#actionForm").append(
					pageNumTag);
			$("#actionForm").append(
					amountTag);
			$("#actionForm")
					.append(typeTag);
			$("#actionForm").append(
					keywordTag);
		}
	
		formObj.submit();
	});
	
	<sec:authorize access="isAuthenticated()">
	var replyer = "<sec:authentication property="principal.username"/>";
	</sec:authorize>
	
	var bnoValue = '<c:out value="${board.bno }"/>';
	
	var replyUL = $(".chat");		
	var replyPageFooter = $("#replyPage");

	var pageNum = 1;
	var replyCnt2 = 0;
	
	
	showList(1);
	showReplyPage(1);
	
	function showList(page){

		
		replyService.getList({bno:bnoValue, page:page|| 1}, function(replyCnt, list){

			replyCnt2 = replyCnt;
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			
			var str = ""; 
			
			if(list == null || list.length == 0){
				
				replyUL.html("");
				
				return;
			}
			
			
			len = list.length || 0;
			for(var i = 0; i < len; i++){
				str += '<li class="left clearfix" data-rno = "'+list[i].rno+'">';
				str += '<div>';
				str += '<div class="header  d-flex justify-content-between">';
				str += '<strong class="primary-font">'+list[i].replyer+'</strong>';
				str += '<small class="text-right text-muted">'+replyService.displayTime(list[i].replyDate)+'</small>';
				str += '</div>';
				str += '<p>'+list[i].reply+'</p>';
				str += '</div>';
				str += '<hr>';
				str += '</li>';			
			}
			
			replyUL.html(str);
			
			showReplyPage(replyCnt);
			
		});


	}
			
	//모달창 띄우기
	var modal = $("#myModal");
	var modalInputReply = $('#reply');
	var modalInputReplyer = $('#replyer');
	var modalInputReplyDate = $('#replyDate');
	
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(e){

		modalInputReply.val('');
		modalInputReplyer.val(replyer);
		modalInputReplyDate.val('');		
		
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		modal.modal("show");
	});
	
	modalRegisterBtn.on("click",function(){
		var reply = {
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue
		};
		
		replyService.add(
				reply,
				function(result){

					modalInputReply.val('');
					modalInputReplyer.val('');
					modalInputReplyDate.val('');	
					
					modal.modal("hide");
					
					showList(-1);
				});
	});
	
	//관리 버튼 클릭시 모달 출력
	$(".chat").on("click", "li", function(){
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply){
			
			modalInputReplyDate.closest("div").show();
			
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate));
			
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalModBtn.show();
			modalRemoveBtn.show();
			
			modal.modal("show");
		});
	});
	
	modalModBtn.on("click", function(){
		
		var rno = modal.data("rno");
		
		if(!replyer){
			alert("로그인후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		
		var reply = {
				reply:modalInputReply.val(),
				replyer:originalReplyer,
				rno:rno
		};
		
		replyService.update(
				reply,
				function(result){

					modalInputReply.val('');
					modalInputReplyer.val('');
					modalInputReplyDate.val('');	
					
					modal.modal("hide");
					
					showList(pageNum);
				});
	});
	
modalRemoveBtn.on("click", function(){
		
		var rno = modal.data("rno");
		
		console.log("RNO:" + rno);
		console.log("REPLYER:" + replyer);
		
		if(!replyer){
			alert("로그인후 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		var endNum = Math.ceil(pageNum / 10.0) *10;
		
		replyCnt2 = replyCnt2 -1;
		
		if(endNum * 10 >= replyCnt2){
			endNum = Math.ceil(replyCnt2/10.0);
		}
		
		replyService.remove(rno, originalReplyer, function(result){
			alert(result);

			modalInputReply.val('');
			modalInputReplyer.val('');
			modalInputReplyDate.val('');	
			
			modal.modal("hide");
			
			if(pageNum > endNum){
				pageNum = pageNum-1;
			} 
			
			showList(pageNum);
		});
		
	});
	
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) *10;
		var startNum = endNum -9;
		
		var prev = startNum != 1;
		var next = false;

		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}

		var str = "<div class='d-flex justify-content-center'><ul class='pagination'>";
		if(prev){
			
			str += "<li class='page-item'><a class='page-link' href='"+(startNum - 1) + "'>Previous</a></li>";
		}

		console.log("startNum:" + startNum);
		console.log("endNum:" + endNum);
		
		for(var i = startNum ; i <= endNum; i++){
			var active = pageNum == i?"active":"";
			str += "<li class='page-item "+active+"'><a class='page-link' href='"+i + "'>"+i+"</a></li>";	
		}

		if(next){
			
			str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1) + "'>Next</a></li>";
		}
		str += "</ul></div>";
		//console.log(str);
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		
		var targetPageNum = $(this).attr("href");
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});
	
	////////////////////////////////////////////////////////////////////
	
	let uploadResult = $(".uploadResult ul");
	
	(function(){
		$.getJSON("/board/getAttachList", {bno: bnoValue}, function(uploadResultArr){
			
			let str = "";
			
			$(uploadResultArr).each(function(i, obj){
				
				let fileDownPath = obj.uploadPath+"/"+obj.uuid+"_"+encodeURIComponent(obj.fileName);
				//console.log(obj);
				
				//일반파일
				if(obj.fileType != '1'){
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
					str += "<div><span>" + obj.fileName + "</span>";
					str += "<img src='/resources/assets/images/attach.png'></div>"
					str += "</li>"
				} else {
					//이미지파일
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/thum_"+obj.uuid+"_"+obj.fileName);
					
					fileDownPath = fileDownPath.replace(new RegExp(/\\/g), "/");
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<img src='/display?fileName="+fileCallPath+"'>"
					str += "</div></li>"
				}
			});
			
			uploadResult.append(str);
		});	
	})();
	
	
	$(".uploadResult").on("click", "li", function(){
		let liObj = $(this);
		
		let path = encodeURIComponent(liObj.data('path')+"/"+liObj.data('uuid')+"_"+liObj.data('filename'));
		
		
		if(liObj.data('type')){
			showImage(path.replace(new RegExp(/\\/g), "/"));
		} else {
			self.location = "/download?fileName="+path;
		}
	});
	

	$(".bigPictureWrapper").on("click", function(){
		$(".bigPicture").animate({width:'0%',height:'0%'}, 1000);
		setTimeout(()=>{
			$(this).hide();
		}, 1000);
	});
	
});//$(document).ready(function(){
	
	
function showImage(fileCallPath){
	$(".bigPictureWrapper").css("display","flex").show();
	
	$(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>")
	.animate({width:'100%',height:'100%'}, 1000);
}	
</script>
<%@ include file="../../include/footer.jsp"%>