<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수납환불시스템</title>
<!--  jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- Optional theme -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

$(function() {
	$("#totalPrice").keydown(function(e) {
		console.log(e.keyCode);
		if (e.keyCode > 57 || e.keyCode < 48) {
			if (e.keyCode != 8) {
				return false;
			}
		}
	});
	
	$("#totalPrice").keyup(function(e) {
		var tp = $(this).val();
		var copay = tp/3
		$("#copay").val(Math.round(copay));
	});
	
	
});
</script>
<style type="text/css">
</style>
</head>
<body>
<div class="container" style="margin-top:10px;">
<div class="row">
<div class="col-sm-7">
<div style="height:400px; border: 1px solid gray; overflow-y: scroll;">
<table class="table table-bordered table-hover table-sm">
  <thead>
    <tr class="table-primary">
      <th scope="col">수납일</th>
      <th scope="col">총진료비</th>
      <th scope="col">본인부담금</th>
      <th scope="col">수납액</th>
      <th scope="col">환불액</th>
    </tr>
  </thead>
  <tbody>
      <c:forEach items="${acceptanceList}" var="acceptance">
      	<tr id="${acceptance.acceptanceNo}">
      	 <td>${acceptance.acceptanceDate}</td>
      	 <td>${acceptance.totalPrice}</td>
      	 <td>${acceptance.copay}</td>
      	 <td>${acceptance.acceptanceAmount}</td>
      	 <td>${acceptance.refundAmount}</td>
      	</tr>
      </c:forEach>
  </tbody>
</table>
</div>
<hr/>
<div style="height:200px; border: 1px solid gray; overflow-y: scroll;">
<table class="table table-bordered table-hover table-sm">
  <thead>
    <tr class="table-primary">
      <th scope="col">환불일</th>
      <th scope="col">현금</th>
      <th scope="col">카드</th>
      <th scope="col">수표</th>
      <th scope="col">총환불액</th>
    </tr>
  </thead>
  <tbody>

  </tbody>
</table>
</div>
</div>
	<div class="col-sm-5">
		<form id="acceptanceForm" method="POST" action="/acceptance/addAcceptance">
		<input type="hidden" name="patientNo" value="${patient.patientNo}" >
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">이름</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="name" name="name" value="${patient.name}" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="socialId" class="col-sm-3 col-form-label">주민번호</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="socialId" name="socialId" value="${patient.socialId}" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="totalPrice" class="col-sm-3 col-form-label">총진료비</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="totalPrice" name="totalPrice" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="copay" class="col-sm-3 col-form-label">본인부담금</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="copay" name="copay" placeholder="0" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="acceptanceAmount" class="col-sm-3 col-form-label">수납액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="acceptanceAmount" name="acceptanceAmount" placeholder="0">
		    </div>
		  </div>
		  <button type="submit" class="btn btn-primary btn-sm btn-block">수납</button> 
		</form>
		<hr/><br/>
		<form name="refundForm">
		<input type="hidden" value="${patient.patientNo}" >
		  <div class="form-group row">
		    <label for="cash" class="col-sm-3 col-form-label">현금</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="cash" name="cash" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="card" class="col-sm-3 col-form-label">카드</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="card" name="card" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="bankTransfer" class="col-sm-3 col-form-label">계좌이체</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="bankTransfer" name="bankTransfer" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="totalRefundAmount" class="col-sm-3 col-form-label">총환불액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="totalRefundAmount" name="totalRefundAmount" placeholder="0">
		    </div>
		  </div>
		  <button type="submit" class="btn btn-secondary btn-sm btn-block">환불</button> 
		</form>
	</div>
</div>
</div>
</body>
</html>