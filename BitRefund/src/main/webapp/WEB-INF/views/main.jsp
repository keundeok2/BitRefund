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
<script type="text/javascript">

//Date 변환
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

//input 태그 숫자입력시 천단위 컴마 function
function inputNumberFormat(obj) {
  obj.value = comma(uncomma(obj.value));
}

function comma(str) {
  str = String(str);
  return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
function uncomma(str) {
  str = String(str);
  return str.replace(/[^\d]+/g, '');
}

//수납목록 클릭 이벤트
$(document).on("click", "tr.acceptanceRow", function() {
	$(".refundRow").remove();
	$("input.cancelInfo").val("");
	$("input.refundInfo").val("");
	
	
	$("tr").css("background-color", "");
	$(this).css("background-color", "#e9ecef");
	
	var acceptanceNo = $(this).attr("id");
	var acceptanceAmount = $("tr#"+ acceptanceNo +" td:nth-child(5)").html().trim();
	var refundAmount = $("tr#"+ acceptanceNo +" td:nth-child(6)").html().trim();
	$("input#acceptanceNo").val(acceptanceNo);
	
	//	환불액이 없으면 환불창, 환불액이 있으면 환불취소창 보이기
	if (refundAmount == 0) {
		$("#refundForm").removeClass("off");
		$("#cancelForm").addClass("off");
		
		$("#refundForm input#possibleAmount").val(acceptanceAmount);
//		$("#cancelForm input#totalRefundAmount").val((parseInt(acceptanceAmount) - parseInt(refundAmount)));
	} else {
		$("#refundForm").addClass("off");
		$("#cancelForm").removeClass("off");
		
		$("#cancelForm input#totalRefundAmount").val(refundAmount);
	}
	
	//	환불목록 데이터 가져와서 붙이기
	$.ajax({
		url : "/refund/getAllRefundByAcceptanceNo/"+acceptanceNo,
		method : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(d) {
			for (var i = 0; i < d.refundList.length; i++) {
				var html = "<tr id='"+d.refundList[i].refundNo +"' class='refundRow'>"
					+"<td>"+new Date(d.refundList[i].refundDate).format("yyyy-MM-dd")+"</td>"
					+"<td>"+d.refundList[i].cash.toLocaleString()+"</td>"
					+"<td>"+d.refundList[i].card.toLocaleString()+"</td>"
					+"<td>"+d.refundList[i].bankTransfer.toLocaleString()+"</td>"
					+"<td>"+d.refundList[i].totalRefundAmount.toLocaleString()+"</td>"
				+"</tr>";
				$(html).appendTo("#refundtbody");
			}
			
			if (d.refundList.length != 0) {
			
				var cash = $("#refundtbody tr:nth-child(1) td:nth-child(2)").html();
				var card = $("#refundtbody tr:nth-child(1) td:nth-child(3)").html();
				var bankTransfer = $("#refundtbody tr:nth-child(1) td:nth-child(4)").html();
				
				$("#cancelForm input#cash").val(cash.toLocaleString());
				$("#cancelForm input#card").val(card.toLocaleString());
				$("#cancelForm input#bankTransfer").val(bankTransfer.toLocaleString());
			}
			
		}
	});
}); 


$(function() {
	
	//	수납버튼 클릭 이벤트
	$("button#acceptanceBtn").on("click", function() {
		
		var patientNo = $("input#patientNo").val();
		var name = $("input#name").val();
		var socialId = $("input#socialId").val();
		var totalPrice = $("input#totalPrice").val().replace(/,/gi,"");
		var copay = $("input#copay").val().replace(/,/gi,"");
		var acceptanceAmount = $("input#acceptanceAmount").val().replace(/,/gi,"");
		
		if (totalPrice == "" || totalPrice == null) {
			alert("총진료비를 입력하세요.");
			return;
		}
		
		if (acceptanceAmount != copay) {
			alert("수납액을 확인하세요.");
			return;
		}
		
		var conf = confirm("수납하시겠습니까?");
		
		if (conf) {
			
			$.ajax({
				url : "/acceptance/addAcceptance",
				method : "POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType : "json",
				data :JSON.stringify({
					patientNo : patientNo,
					name : name,
					socialId : socialId,
					totalPrice : totalPrice,
					copay : copay,
					acceptanceAmount : acceptanceAmount
				}),
				success: function(d) {
					if (d.success) {
						var date = new Date(d.acceptance.acceptanceDate);
						var html = "<tr id='"+d.acceptance.acceptanceNo+"' class='acceptanceRow'>"
							      	 +"<td>"+d.acceptance.acceptanceNo+"</td>"
							      	 +"<td>"+new Date().format('yyyy-MM-dd')+"</td>"
							      	 +"<td>"+d.acceptance.totalPrice.toLocaleString()+"</td>"
							      	 +"<td>"+d.acceptance.copay.toLocaleString()+"</td>"
							      	 +"<td>"+d.acceptance.acceptanceAmount.toLocaleString()+"</td>"
							      	 +"<td>"+d.acceptance.refundAmount.toLocaleString()+"</td>"
							      	+"</tr>";
						$(html).prependTo("#acceptancetbody");
					} else alert("Error.");
					$(".accpetanceInfo").val("");
				},
				error : function(err) {
					alert("err");
			}
		});
		}
	});
	
	//	환불버튼 클릭이벤트
	$("#refundBtn").on("click", function() {
		
		
		var acceptanceNo = $("#refundForm input#acceptanceNo").val();
		var patientNo = $("input#patientNo").val();
		var cash = $("#refundForm input#cash").val() == "" ? 0 : $("#refundForm input#cash").val().replace(/,/gi,"");
		var card = $("#refundForm input#card").val() == "" ? 0 : $("#refundForm input#card").val().replace(/,/gi,"");
		var bankTransfer = $("#refundForm input#bankTransfer").val() == "" ? 0 : $("#refundForm input#bankTransfer").val().replace(/,/gi,"");
		var totalRefundAmount = $("#refundForm input#totalRefundAmount").val().replace(/,/gi,"");
		var tRAL = $("#refundForm input#totalRefundAmount").val();
		
		var possibleAmount = $("#refundForm #possibleAmount").val().replace(/,/gi,"");
		
		if (parseInt(totalRefundAmount) != parseInt(possibleAmount)) {
			alert("환불액을 확인하세요.");
			return;
		}
		
		var conf = confirm("환불을 진행하시겠습니까?");
		if (conf) {
			
		$.ajax({
			url : "/refund/addRefund",
			method : "POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify({
				acceptanceNo : acceptanceNo,
				patientNo : patientNo,
				cash : cash,
				card : card,
				bankTransfer : bankTransfer,
				totalRefundAmount : totalRefundAmount
			}),
			success : function(d) {
				if (d.success) {
					var html = "<tr class='refundRow'>"
									+"<td>"+new Date().format("yyyy-MM-dd")+"</td>"
									+"<td>"+d.refund.cash.toLocaleString()+"</td>"
									+"<td>"+d.refund.card.toLocaleString()+"</td>"
									+"<td>"+d.refund.bankTransfer.toLocaleString()+"</td>"
									+"<td>"+d.refund.totalRefundAmount.toLocaleString()+"</td>"
								+"</tr>";
					$(html).prependTo("#refundtbody");
					var value = parseInt(d.refund.totalRefundAmount) + parseInt($("tr#"+acceptanceNo+" td:nth-child(6)").html().trim());
					$("tr#"+acceptanceNo+" td:nth-child(6)").html(value.toLocaleString());
					
					$("#refundForm").addClass("off");
					$("#cancelForm").removeClass("off");
					
					var cash = $("#refundtbody tr:nth-child(1) td:nth-child(2)").html();
					var card = $("#refundtbody tr:nth-child(1) td:nth-child(3)").html();
					var bankTransfer = $("#refundtbody tr:nth-child(1) td:nth-child(4)").html();
					
					$("#cancelForm input#cash").val(cash.toLocaleString());
					$("#cancelForm input#card").val(card.toLocaleString());
					$("#cancelForm input#bankTransfer").val(bankTransfer.toLocaleString());
					$("#cancelForm input#totalRefundAmount").val(tRAL);
				}
			}
		})
		}
	});
	
	
	//	환불취소버튼 클릭 이벤트
	$("#cancelBtn").on("click", function() {
		
		
		var acceptanceNo = $("#cancelForm input#acceptanceNo").val();
		var patientNo = $("input#patientNo").val();
		var cash = $("#cancelForm input#cash").val() == "" ? 0 : $("#cancelForm input#cash").val().replace(/,/gi,"");
		var card = $("#cancelForm input#card").val() == "" ? 0 : $("#cancelForm input#card").val().replace(/,/gi,"");
		var bankTransfer = $("#cancelForm input#bankTransfer").val() == "" ? 0 : $("#cancelForm input#bankTransfer").val().replace(/,/gi,"");
		var totalRefundAmount = $("#cancelForm input#totalRefundAmount").val().replace(/,/gi,"");
		var traL = $("#cancelForm input#totalRefundAmount").val();
		
		var conf = confirm("환불취소를 진행하시겠습니까?");
		
		if (conf) {
			
		$.ajax({
			url : "/refund/addRefund",
			method : "POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify({
				acceptanceNo : acceptanceNo,
				patientNo : patientNo,
				cash : -cash,
				card : -card,
				bankTransfer : -bankTransfer,
				totalRefundAmount : -totalRefundAmount
			}),
			success : function(d) {
				var html = "<tr class='refundRow'>"
								+"<td>"+new Date().format("yyyy-MM-dd")+"</td>"
								+"<td>"+d.refund.cash.toLocaleString()+"</td>"
								+"<td>"+d.refund.card.toLocaleString()+"</td>"
								+"<td>"+d.refund.bankTransfer.toLocaleString()+"</td>"
								+"<td>"+d.refund.totalRefundAmount.toLocaleString()+"</td>"
							+"</tr>";
				$(html).prependTo("#refundtbody");
				
				$("tr#"+acceptanceNo+" td:nth-child(6)").html(0);
				
				$("#refundForm").removeClass("off");
				$("#cancelForm").addClass("off");
				
				$(".refundInfo").val("");
				$("#possibleAmount").val(traL);
			}
		})
		}
	});
	
	
	
	$("#totalPrice, #cash, #card, #bankTransfer").keypress(function(e) {
		if (e.keyCode > 57 || e.keyCode < 48) {
				return false;
		}
	});
	
	$("#totalPrice").keyup(function(e) {
		var tp = $(this).val().replace(/,/gi,"");
		var copay = tp/3
		$("#copay").val(Math.round(copay).toLocaleString());
	});
	
	$("#cash, #card, #bankTransfer").keyup(function(e) {
		var value =$(this).val().replace(/,/gi,"");
		if (value == null || value == "") {
			value = 0;
		}
		var cash = $("#cash").val().replace(/,/gi,"") == "" ? 0 : $("#cash").val().replace(/,/gi,"");
		var card = $("#card").val().replace(/,/gi,"") == "" ? 0 : $("#card").val().replace(/,/gi,""); 
		var bankTransfer = $("#bankTransfer").val().replace(/,/gi,"") == "" ? 0 : $("#bankTransfer").val().replace(/,/gi,""); 
		$("#totalRefundAmount").val((parseInt(card) + parseInt(cash) + parseInt(bankTransfer)).toLocaleString());
	});
	
	
	//	환자검색 버튼 클릭 이벤트
	$("button#patientList").on("click", function() {
		window.open("/patient/getAllPatient","환자목록","width=550, height=400, left=400, top=100");
	});
	
	
});



</script>


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