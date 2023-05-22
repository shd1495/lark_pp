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

    <title>회원가입 페이지</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
    <!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	
	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>
	<style>
		#id{
		display: flex;
		}
	</style>
    
</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                            </div>
                            <form id="form" class="user text-center" action="/users/register" method="post">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
								<input type="hidden" name="auth" id="role1" value="USER">
                               	<small id="msg"></small>
                                <div id="id" class="form-group">
                                    <input type="text" class="form-control form-control-user col-md-9" id="userid"
                                        name="userid" placeholder="ID" required="required">
                                    <button type="button" id="idchkBtn" class="btn btn-user btn-warning col-md-3" >중복 체크</button>
                                </div>
                               	<small id="msg2"></small>
                               	<div class="form-group">
                                    <input type="password" class="form-control form-control-user"
                                        id="userpw" name="userpw" placeholder="Password" required="required">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="userName"
                                        name="userName" placeholder="USERNAME" required="required">
                                </div>
                                <button id="btnSubmit" type="submit" class="btn btn-primary btn-user btn-block">
                                    계정 생성
                                </button>
                                <hr>
                                <a href="/" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="/" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<script src="../../resources/js/register.js"></script>
</body>

</html>