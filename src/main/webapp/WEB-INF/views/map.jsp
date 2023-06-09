<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<link href="../resources/css/map.css" rel="stylesheet">
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">유틸리티</h1>
	</div>

	<!-- Content Row -->
	<div class="card shadow">
		<div class="card-body">
			<h4>지도</h4>
			<h6>검색한 키워드에 맞는 장소 목록 표시</h6>
			<div class="map_wrap">
				<div id="map"
					style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51ea9eb5502b47ad6f1f4fd86eacaa27&
					libraries=services,clusterer,drawing"></script>
				<script src="../resources/js/map.js"></script>
				<div id="menu_wrap" class="bg_white"> 
					<div class="option">
						<div>
							<form onsubmit="searchPlaces(); return false;">
								키워드 : <input type="text" value="" id="keyword" size="15">
								<button type="submit" class="btn btn-secondary">검색하기</button>
							</form>
						</div>
					</div>
					<hr>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
				</div>
				<div class="custom_typecontrol radius_border">
			        <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
			        <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
			    </div>
			    <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
			    <div class="custom_zoomcontrol radius_border"> 
			        <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
			        <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
			    </div>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@ include file="../include/footer.jsp"%>