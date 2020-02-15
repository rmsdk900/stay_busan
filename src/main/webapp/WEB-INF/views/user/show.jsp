<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/header.jsp" %>
<!-- 소개 페이지 전체 -->
<div class="show_wrapper">
	<!-- 프로필 사진 + 제목 + 회원가입일 + 소개  -->
	<div>
		<!-- 프로필 사진 + 제목 + 회원가입일 -->
		<div>
			<!-- 프로필 사진 -->
			<div class="show_my_img" >
				[프로필 사진]
			</div>
			<!-- 프로필 제목 + 회원가입일-->
			<div>
				<!-- 프로필 제목 -->
				<div>
					[프로필 제목]
				</div>
				<!-- 회원 가입일 -->
				<div>
					[회원 가입일]
				</div>
			</div>
		</div>
		<!-- 소개 -->
		<div>
			[프로필 소개]
		</div>
	</div>
	<!-- 숙소들 -->
	<div>
		<!-- 찜한 숙소 -->
		<div>
			[찜한 숙소]
		</div>
		<!-- 예약된 숙소 -->
		<div>
			[예약된 숙소]
		</div>
		<!-- 숙박했던 숙소 -->
		<div>
			[숙박했던 숙소]
		</div>
	</div>
	<!-- 후기들 -->
	<div>
		[후기들]
	</div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/show.js"></script>
<%@ include file="../common/footer.jsp" %>