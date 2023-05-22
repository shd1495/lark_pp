<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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
						<input type="hidden" id="userid" name="userid"
							value="${pinfo.username }" />
					</sec:authorize>
					<div>
						<label for="formGroupExampleInput" class="form-label">제목</label> <input
							type="text" class="form-control" id="title" name="title"
							placeholder="제목" required />
					</div>
					<hr>
					<div>
						<label for="formGroupExampleInput" class="form-label">내용</label>
						<textarea id="content" name="content" rows="20"
							class="form-control" placeholder="내용" required></textarea>
					</div>
					<hr>
					<div class="row">
						<div class="card shadow col-md-12">
							<div class="card-heading">파일 첨부</div>
							<div class="card-body">
								<div class="form-group uploadDiv">
									<input type="file" name="uploadFile" multiple="multiple">
								</div>
								<div class="uploadResult">
									<ul>

									</ul>
								</div>
							</div>
						</div>
					</div>
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
<script>
function showImage(fileCallPath){
	$(".bigPictureWrapper").css("display","flex").show();
	
	$(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>")
	.animate({width:'100%',height:'100%'}, 1000);
}


$(document).ready(function(){
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	var formObj = $("form[role=form]");
	
	$("button[type=submit]").on("click", function(e){
		e.preventDefault();
		
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			let jobj = $(obj);
			
			let type = (jobj.data('type') == true)?"1":"0";

			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data('filename')+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data('uuid')+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data('path')+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+type+"'>";
		});
		
		formObj.append(str).submit();
	});
	
	
	let regex = new RegExp("(.*?)\.(png|gif|jpg|txt)$");
	let maxSize = 5242880;//5Mbyte
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
	var cloneObj = $(".uploadDiv").clone();
	
	$(".uploadDiv").on("change","input[type=file]", function(){
		
		let formData = new FormData();
		
		let inputFile = $("input[name=uploadFile]");
		
		let files = inputFile[0].files;
		console.log(files);
		
		for(let i = 0; i < files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url:'/uploadAjaxAction',
			processData:false,
			contentType:false,
			data:formData,
			type:'POST',
			dataType:'json',
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success:function(result){
				console.log(result);
				/* input type=file 을 초기화 */
				$(".uploadDiv").html(cloneObj.html());
				
				/* ajax 결과값을 출력 */
				showUploadedFile(result);
				
			}
		});
		
		
	});
	
	let uploadResult = $(".uploadResult ul");
	
	function showUploadedFile(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
		}
		
		let str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			let fileDownPath = obj.uploadPath+"/"+obj.uuid+"_"+encodeURIComponent(obj.fileName);
			
			if(!obj.image){
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
				str += "<div><span><a href='/download?fileName="+fileDownPath+"'>" + obj.fileName + "</a></span>";
				str += "<button type='button' data-file='"+fileDownPath+"' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>";
				str += "<img src='/resources/assets/images/attach.png'></div>"
				str += "</li>"
			} else {
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/thum_"+obj.uuid+"_"+obj.fileName);
				
				fileDownPath = fileDownPath.replace(new RegExp(/\\/g), "/");
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<span><a href='/download?fileName="+fileDownPath+"'>" + obj.fileName + "</a></span>";
				str += "<button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle btn-sm'><i class='fa fa-times'></i></button>";
				str += "<a href='javascript:showImage(\""+fileDownPath+"\")'><img src='/display?fileName="+fileCallPath+"'></a>"
				str += "</div></li>"
			}
		});
		
		uploadResult.append(str);
	}
	
	$(".bigPictureWrapper").on("click", function(){
		$(".bigPicture").animate({width:'0%',height:'0%'}, 1000);
		setTimeout(()=>{
			$(this).hide();
		}, 1000);
	});
	
	$(".uploadResult").on("click","button", function(){
		let targetFile = $(this).data("file");
		let type = $(this).data("type");
		let my = $(this);
		//console.log(my);
		$.ajax({
			url:'/deleteFile',
			data: {fileName:targetFile, type:type},
			dataType:'text',
			type:'post',
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result){
				my.parent().parent().remove();
			}
		});
	});
});//$(document).ready(function(){
</script>
<%@ include file="../../include/footer.jsp"%>