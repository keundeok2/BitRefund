<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환자목록</title>
<!--  jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- Optional theme -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

$(function() {
	$("button#getAllPatient").on("click", function() {
		$(location).attr("href", "/patient/getAllPatient");
	});
	
	
	$("tr.info").on("click", function() {
		var patientNo = $(this).attr("id");
		opener.location.href="/acceptance/getAllAcceptanceByPatientNo/"+patientNo;
		self.close();
	});
});
</script>
</head>
<body>

	<div class="container" style="margin-top: 10px;">
	<div class="col-sm-12">
		<form class="form-inline" method="POST" action="/patient/getPatientForSearch">
			<div class="form-group mb-2">
				<select	class="form-control" name="searchCondition">
					<option value="name" ${search.searchCondition =='name' ? 'selected' : ''}>이름</option>
					<option value="socialId" ${search.searchCondition =='socialId' ? 'selected' : ''}>주민번호</option>
					
				</select>
			</div>
			<div class="form-group mb-2">
				<input type="text" class="form-control" name="searchKeyword" value="${search.searchKeyword}">
			</div>
			<button type="submit" class="btn btn-primary mb-2" id="submit">검색</button>
			<button type="button" class="btn btn-secondary mb-2" id="getAllPatient">전체 환자 목록</button>
		</form>
	</div>
		<div class="table-responsive col-xs-12 col-sm-10 col-md-10" style="width: 500px;max-height: 300px;">
		<table class="table table-hover table-sm table-bordered">
			<thead>
				<tr class="table-primary">
					<th scope="col">이름</th>
					<th scope="col">주민번호</th>
					<th scope="col">성별</th>
				</tr>
			</thead>
			<tbody style="overflow-y: scroll;">
				<c:forEach items="${list}" var="patient">
					<tr id="${patient.patientNo}" class="info" >
						<td>${patient.name}</td>
						<td>${patient.socialId }</td>
						<td>
							<c:if test="${patient.sex == 'M' }">
							남성
							</c:if>
							<c:if test="${patient.sex == 'W' }">
							여성
							</c:if>
						</td>					
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
</body>
</html>