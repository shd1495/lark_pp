<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Login</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
    <script src="../resources/vendor/jquery/jquery.js"></script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">로그인</h1>
                                    </div>
                                    <form id="form" class="user" method="post" action="/login">
                                    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                                    <input type="hidden" id="nickname" name="nickname" value="1" />
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                id="userid" name="username" aria-describedby="emailHelp"
                                                placeholder="Enter ID">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="userpw" name="password" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" name="remember-me" id="remember-me">
                                                <label class="custom-control-label" for="remember-me">로그인 유지</label>
                                            </div>
                                        </div>
                                        <button id="btnSubmit" class="form-control btn btn-primary btn-user btn-block">로그인</button>
                                        <hr>
                                        <a href="index.html" class="btn btn-google btn-user btn-block">
                                            <i class="fab fa-google fa-fw"></i> 로그인 with Google
                                        </a>
                                        <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                            <i class="fab fa-facebook-f fa-fw"></i> 로그인 with Facebook
                                        </a>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="/users/register">회원가입 페이지</a>
                                    </div>
                                    <div class="text-center">
		                                <a class="small" href="/">메인 화면</a>
		                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>

<script>
$(document).ready(function(){
	let chk = 0;
	$('#btnSubmit').on('click', function(event){
		event.preventDefault();
		let userid = $("#userid").val();
		let nickname = $("#nickname").val();
		let checkPassword = $("#userpw").val();
		$.ajax({
			url:'/users/idChk',
			type:'get',
			contentType: 'application/JSON; charset=utf-8',
			data: {userid : userid, nickname : nickname},
			dataType:'JSON',
			success:function(result){
				if(result == "1" || result == "2"){
					console.log(result);
					chk = 1;
				} else {
 					alert("아이디 또는 비밀번호를 확인하세요.");
					console.log(result);
					chk = 0;
				}
			}
		}).done(function(){
			if(chk == 1){
				$.ajax({
   	            	type: 'GET',
   	                url: '/users/chkPw',
   	                contentType: 'application/json; charset=utf-8',
   	                data: {'userid' : userid ,'checkPassword' : checkPassword},
   	                datatype: "JSON",
                	success:function(result){
	     				if(result == "true"){
	    					console.log(result);
	     					$("#form").submit();
	     				} else {
	    					console.log(result);
	     					alert("아이디 또는 비밀번호를 확인하세요.");
	     				}
   	     			}
   	            });
			}
		});
	});
});
</script>
</body>

</html>