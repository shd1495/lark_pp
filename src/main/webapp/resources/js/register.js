/**
 * 회원가입 페이지 JS
 */
 $(document).ready(function(){

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	idchk = 2;

	//중복 체크 버튼 ajax통신으로 중복체크
	$("#idchkBtn").on("click", function(){
		let userid = $("#userid").val();
		$.ajax({
			url:'/users/idChk',
			type:'get',
			contentType: 'application/JSON; charset=utf-8',
			data: {userid : userid},
			dataType:'JSON',
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success:function(result){
				if(result == "1"){
					alert("중복된 아이디 입니다.");
					idchk = 1;
				} else {
					alert("사용가능한 아이디입니다.");
					idchk = 0;
				}
			}
		});
	});
	
	//패스워드에 조건 추가
	$('#userpw').on("keyup", function(){
		if($(this).val().length < 6 || $(this).val().length > 12){
			$('#msg2').html("6~12자 사이로 입력하세요.");
			$('#msg2').css("color", "#f00").css("z-index",1);
		} else {
			let regPass = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}$/;
			if (!regPass.test($(this).val())) {
				$('#msg2').html("영문자 숫자 특수문자를 포함하세요.");
				$('#msg2').css("color", "#f00").css("z-index",1);
			} else {
				$('#msg2').html("");
			}
		}
	});
	
	//아이디에 조건 추가
	$('#userid').on("keyup", function(){
		if($(this).val().length < 6 || $(this).val().length > 12){
			$('#msg').html("6~12자 사이로 입력하세요.");
			$('#msg').css("color", "#f00").css("z-index",1);
		} else {
			$('#msg').html("");
		}
	});
	
	//생성 버튼 누를 시 조건 체크
	$('#btnSubmit').on('click', function(event){
		event.preventDefault();
		if($('#userid').val() == '' || $('#userid').val().length < 6 || $('#userid').val().length > 12 || idchk == 1 ){
			alert("양식에 맞는 아이디를 입력하세요.");
			$('#userid').focus();
			return;
		}
		let regPass = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}$/;
		if($('#userpw').val() == '' || $('#userpw').val().length < 6 || $('#userpw').val().length > 12  || !regPass.test($('#userpw').val()) == true){
			alert("양식에 맞는 비밀번호를 입력하세요.");
			$('#userpw').focus();
			return;
		}
		if($('#userName').val() == '' || $('#userName').val().length <= 2){
			alert("이름을 입력하세요..");
			$('#name').focus();
			return;
		}
		if(idchk == 0){
			$("#form").submit();
		} else {
			alert("중복 체크 확인");
		}
	});
});