/**
 * 게시판 목록 JS
 */
$(document).ready(function() {
	
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
	$(".getBoard").on("click", function(event) {
		event.preventDefault();

		$("#actionForm input[name=bno]").remove();
		$("#actionForm").append(
				"<input type='hidden' name='bno' value='"
						+ $(this).attr("href") + "'>");
		$("#actionForm").attr("action", "/board/get");

		$("#actionForm").submit();

	});
	
	//관리자가 삭제 버튼 눌렀을 때
	$("#btnDel").on("click", function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			return true;
		} else {
			return false;
		}
	});

});