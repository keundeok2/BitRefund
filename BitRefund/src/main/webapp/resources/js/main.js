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


//수납목록 클릭 이벤트
$(document).on("click", "tr.acceptanceRow", function() {
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
		
		$("#refundForm input#possibleAmount").val((parseInt(acceptanceAmount) - parseInt(refundAmount)));
		$("#cancelForm input#totalRefundAmount").val((parseInt(acceptanceAmount) - parseInt(refundAmount)));
	} else {
		$("#refundForm").addClass("off");
		$("#cancelForm").removeClass("off");
		
		$(".cancel")
		$("#cancelForm input#totalRefundAmount").val(refundAmount);
	}
	
	//	환불목록 데이터 가져와서 붙이기
	$.ajax({
		url : "/refund/getAllRefundByAcceptanceNo/"+acceptanceNo,
		method : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(d) {
			$("#refundtbody").html("");
			for (var i = 0; i < d.refundList.length; i++) {
				var html = "<tr id='"+d.refundList[i].refundNo +"' class='refundRow'>"
					+"<td>"+new Date(d.refundList[i].refundDate).format("yyyy-MM-dd")+"</td>"
					+"<td>"+d.refundList[i].cash+"</td>"
					+"<td>"+d.refundList[i].card+"</td>"
					+"<td>"+d.refundList[i].bankTransfer+"</td>"
					+"<td>"+d.refundList[i].totalRefundAmount+"</td>"
				+"</tr>";
				$(html).appendTo("#refundtbody");
			}
			
			var cash = $("#refundtbody tr:nth-child(1) td:nth-child(2)").html();
			var card = $("#refundtbody tr:nth-child(1) td:nth-child(3)").html();
			var bankTransfer = $("#refundtbody tr:nth-child(1) td:nth-child(4)").html();
			
			$("#cancelForm input#cash").val(cash);
			$("#cancelForm input#card").val(card);
			$("#cancelForm input#bankTransfer").val(bankTransfer);
		}
	});
}); 


$(function() {
	
	//	수납버튼 클릭 이벤트
	$("button#acceptanceBtn").on("click", function() {
		var patientNo = $("input#patientNo").val();
		var name = $("input#name").val();
		var socialId = $("input#socialId").val();
		var totalPrice = $("input#totalPrice").val();
		var copay = $("input#copay").val();
		var acceptanceAmount = $("input#acceptanceAmount").val();
		
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
							      	 +"<td>"+d.acceptance.totalPrice+"</td>"
							      	 +"<td>"+d.acceptance.copay+"</td>"
							      	 +"<td>"+d.acceptance.acceptanceAmount+"</td>"
							      	 +"<td>"+d.acceptance.refundAmount+"</td>"
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
		var cash = $("#refundForm input#cash").val() == "" ? 0 : $("#refundForm input#cash").val();
		var card = $("#refundForm input#card").val() == "" ? 0 : $("#refundForm input#card").val();
		var bankTransfer = $("#refundForm input#bankTransfer").val() == "" ? 0 : $("#refundForm input#bankTransfer").val();
		var totalRefundAmount = $("#refundForm input#totalRefundAmount").val();
		
		var possibleAmount = $("#refundForm #possibleAmount").val();
		
		if (parseInt(totalRefundAmount) != parseInt(possibleAmount)) {
			alert("환불액을 확인하세요.");
			return;
		}
		
		
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
				var html = "<tr class='refundRow'>"
								+"<td>"+new Date().format("yyyy-MM-dd")+"</td>"
								+"<td>"+d.refund.cash+"</td>"
								+"<td>"+d.refund.card+"</td>"
								+"<td>"+d.refund.bankTransfer+"</td>"
								+"<td>"+d.refund.totalRefundAmount+"</td>"
							+"</tr>";
				$(html).prependTo("#refundtbody");
				var value = parseInt(d.refund.totalRefundAmount) + parseInt($("tr#"+acceptanceNo+" td:nth-child(6)").html().trim());
				$("tr#"+acceptanceNo+" td:nth-child(6)").html(value);
				
				$("#refundForm").addClass("off");
				$("#cancelForm").removeClass("off");
				
				var cash = $("#refundtbody tr:nth-child(1) td:nth-child(2)").html();
				var card = $("#refundtbody tr:nth-child(1) td:nth-child(3)").html();
				var bankTransfer = $("#refundtbody tr:nth-child(1) td:nth-child(4)").html();
				
				$("#cancelForm input#cash").val(cash);
				$("#cancelForm input#card").val(card);
				$("#cancelForm input#bankTransfer").val(bankTransfer);
				
			}
		})
	});
	
	
	//	환불취소버튼 클릭 이벤트
	$("#cancelBtn").on("click", function() {
		
		
		var acceptanceNo = $("#cancelForm input#acceptanceNo").val();
		var patientNo = $("input#patientNo").val();
		var cash = $("#cancelForm input#cash").val() == "" ? 0 : $("#cancelForm input#cash").val();
		var card = $("#cancelForm input#card").val() == "" ? 0 : $("#cancelForm input#card").val();
		var bankTransfer = $("#cancelForm input#bankTransfer").val() == "" ? 0 : $("#cancelForm input#bankTransfer").val();
		var totalRefundAmount = $("#cancelForm input#totalRefundAmount").val();
		
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
								+"<td>"+d.refund.cash+"</td>"
								+"<td>"+d.refund.card+"</td>"
								+"<td>"+d.refund.bankTransfer+"</td>"
								+"<td>"+d.refund.totalRefundAmount+"</td>"
							+"</tr>";
				$(html).prependTo("#refundtbody");
				
				var value = parseInt(d.refund.totalRefundAmount) + parseInt($("tr#"+acceptanceNo+" td:nth-child(6)").html().trim());
				$("tr#"+acceptanceNo+" td:nth-child(6)").html(value);
				
				$("#refundForm").removeClass("off");
				$("#cancelForm").addClass("off");
				
				$(".refundInfo").val("");
				$("#possibleAmount").val(-(parseInt(d.refund.totalRefundAmount)));
			}
		})
	});
	
	
	
	$("#totalPrice, #cash, #card, #bankTransfer").keypress(function(e) {
		if (e.keyCode > 57 || e.keyCode < 48) {
				return false;
		}
	});
	
	$("#totalPrice").keyup(function(e) {
		var tp = $(this).val();
		var copay = tp/3
		$("#copay").val(Math.round(copay));
	});
	
	$("#cash, #card, #bankTransfer").keyup(function(e) {
		var value =$(this).val();
		if (value == null || value == "") {
			value = 0;
		}
		var cash = $("#cash").val() == "" ? 0 : $("#cash").val();
		var card = $("#card").val() == "" ? 0 : $("#card").val(); 
		var bankTransfer = $("#bankTransfer").val() == "" ? 0 : $("#bankTransfer").val(); 
		$("#totalRefundAmount").val(parseInt(card) + parseInt(cash) + parseInt(bankTransfer));
	});
	
	
	//	환자검색 버튼 클릭 이벤트
	$("button#patientList").on("click", function() {
		window.open("/patient/getAllPatient","환자목록","width=550, height=400, left=400, top=100");
	});
	
	
});
