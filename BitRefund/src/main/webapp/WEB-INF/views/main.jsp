<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script src="/resources/js/main.js"></script>

<style type="text/css">
.off {
	display: none;
}
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
      <th scope="col">수납번호</th>
      <th scope="col">수납일</th>
      <th scope="col">총진료비</th>
      <th scope="col">본인부담금</th>
      <th scope="col">수납액</th>
      <th scope="col">환불액</th>
    </tr>
  </thead>
  <tbody id="acceptancetbody">
      <c:forEach items="${acceptanceList}" var="acceptance">
      	<tr id="${acceptance.acceptanceNo}" class="acceptanceRow">
      	 <td>${acceptance.acceptanceNo}</td>
      	 <td>${acceptance.acceptanceDate}</td>
      	 <td><fmt:formatNumber value="${acceptance.totalPrice}" pattern="#,###"/></td>
      	 <td><fmt:formatNumber value="${acceptance.copay}" pattern="#,###"/></td>
      	 <td><fmt:formatNumber value="${acceptance.acceptanceAmount}" pattern="#,###"/></td>
      	 <td><fmt:formatNumber value="${acceptance.refundAmount}" pattern="#,###"/></td>
      	</tr>
      </c:forEach>
  </tbody>
</table>
</div>
<hr/>
<div style="height:250px; border: 1px solid gray; overflow-y: scroll;">
<table class="table table-bordered table-hover table-sm">
  <thead>
    <tr class="table-primary">
      <th scope="col">환불일</th>
      <th scope="col">현금</th>
      <th scope="col">카드</th>
      <th scope="col">계좌이체</th>
      <th scope="col">총환불액</th>
    </tr>
  </thead>
  <tbody id="refundtbody">
  </tbody>
</table>
</div>
</div>
	<div class="col-sm-5">
		<button class="btn btn-block btn-sm btn-info" id="patientList">환자검색 / 환자목록</button>
		<br/>
		<form id="acceptanceForm">
		<input type="hidden" id="patientNo" name="patientNo" value="${patient.patientNo}" >
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
		      <input type="text" class="form-control accpetanceInfo" id="totalPrice" name="totalPrice" onkeyup="inputNumberFormat(this)" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="copay" class="col-sm-3 col-form-label">본인부담금</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control accpetanceInfo" id="copay" name="copay" placeholder="0" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="acceptanceAmount" class="col-sm-3 col-form-label">수납액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control accpetanceInfo" id="acceptanceAmount" name="acceptanceAmount" onkeyup="inputNumberFormat(this)" placeholder="0"></input>
		    </div>
		  </div>
		  <button type="button" id="acceptanceBtn" class="btn btn-primary btn-sm btn-block">수납</button> 
		</form>
		<br/>
		<form id="refundForm">
		  <div class="form-group row">
		    <label for="acceptanceNo" class="col-sm-3 col-form-label">수납번호</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="acceptanceNo" name="acceptanceNo" readonly>
		    </div>
		  </div>
  		  <div class="form-group row">
		    <label for="possibleAmount" class="col-sm-3 col-form-label">환불가능액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="possibleAmount" name="possibleAmount" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="cash" class="col-sm-3 col-form-label">현금</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control refundInfo" id="cash" name="cash" onkeyup="inputNumberFormat(this)" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="card" class="col-sm-3 col-form-label">카드</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control refundInfo" id="card" name="card" onkeyup="inputNumberFormat(this)" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="bankTransfer" class="col-sm-3 col-form-label">계좌이체</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control refundInfo" id="bankTransfer" name="bankTransfer" onkeyup="inputNumberFormat(this)" placeholder="0">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="totalRefundAmount" class="col-sm-3 col-form-label">총환불액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control refundInfo" id="totalRefundAmount" name="totalRefundAmount" placeholder="0" readonly>
		    </div>
		  </div>
		  <button type="button" id="refundBtn" class="btn btn-danger btn-sm btn-block">환불</button> 
		</form>
		
		<form id="cancelForm" class="off">
		  <div class="form-group row">
		    <label for="acceptanceNo" class="col-sm-3 col-form-label">수납번호</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="acceptanceNo" name="acceptanceNo" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="totalRefundAmount" class="col-sm-3 col-form-label">총환불액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="totalRefundAmount" name="totalRefundAmount" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="cash" class="col-sm-3 col-form-label">현금</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control cancelInfo" id="cash" name="cash" onkeyup="inputNumberFormat(this)" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="card" class="col-sm-3 col-form-label">카드</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control cancelInfo" id="card" name="card" onkeyup="inputNumberFormat(this)" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="bankTransfer" class="col-sm-3 col-form-label">계좌이체</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control cancelInfo" id="bankTransfer" name="bankTransfer" onkeyup="inputNumberFormat(this)" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="totalRefundAmount" class="col-sm-3 col-form-label">총환불취소액</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="totalRefundAmount" name="totalRefundAmount" placeholder="0" readonly>
		    </div>
		  </div>
		  <button type="button" id="cancelBtn" class="btn btn-secondary btn-sm btn-block">환불취소</button> 
		</form>
	</div>
</div>
</div>
</body>
</html>