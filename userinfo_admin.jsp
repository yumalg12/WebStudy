<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 인코딩
request.setCharacterEncoding("UTF-8");
%>    
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Information</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="./script/execDaumPostcode.js"></script>

</head>
<%@include file="./header.jsp" %>
<%String updateID = request.getParameter("updateID");%>

<body>
	<div class="contents">
		<div class="grid" style="grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="./sidebar.jsp"%>
			</div>
			<div class="container">

<h1>사용자 정보 수정 (<%=updateID %>)</h1>

<%@ include file = "./admin/conn.jsp"%>

<%
// DB에서 정보 가져오기
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `t_shopping_member` where MEMBER_ID = '"+updateID+"';";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();

		String PW = ""; // 자격 확인용
		
		// 결과를 출력
		while (rs.next()) {
			String userID = rs.getString("MEMBER_ID");
			PW = rs.getString("MEMBER_PW");
			String userName = rs.getString("MEMBER_NAME");
			Integer dept = rs.getInt("DEPTNO");
			String gender = rs.getString("MEMBER_GENDER");
			String num1 = rs.getString("TEL1");
			String num2 = rs.getString("TEL2");
			String num3 = rs.getString("TEL3");
			String SMSYN = rs.getString("SMSSTS_YN");
			String email1 = rs.getString("EMAIL1");
			String email2 = rs.getString("EMAIL2");
			String emailYN = rs.getString("EMAILSTS_YN");
			String zipcode = rs.getString("ZIPCODE");
			String roadAddress = rs.getString("ROADADDRESS");
			String jibunAddress = rs.getString("JIBUNADDRESS");
			String namujiAddress = rs.getString("NAMUJIADDRESS");
			Integer bYear = rs.getInt("MEMBER_BIRTH_Y");
			Integer bMon = rs.getInt("MEMBER_BIRTH_M");
			Integer bDay = rs.getInt("MEMBER_BIRTH_D");
		%>

<!-- 결과 표시 -->
<form name="Registerform" action=./admin/userinfo_adminupdate.jsp method="post" onSubmit="return updateForm();">

    <div class="item">
    <label>아이디</label>
    <input type="text" name="userID" class="form-control" placeholder="userID" value="<%=userID%>" maxlength="12" disabled>
    <input type="hidden" name="updateID" value="<%=userID%>">
</div>

    <div class="item">
    <label>비밀번호</label>
    <input type="password" name="PW" class="form-control" placeholder="Enter password" value="1q2w3e4r5t6y7u8i9o0p" onInput="checkPWone()" disabled maxlength="20">
    <span class="notice" id="PWNotice" style="display: none;"> ※영문 소문자, 숫자, 특수문자로 이루어진 4~20자</span>
    </div>

    <div class="item">
        <label>이름</label>
    <input type="text" name="userName" class="form-control" placeholder="username" value="<%=userName%>" maxlength="5">
</div>

    <div class="item">
    <label>부서</label>
    <select class="form-select" name="dept">

<% 		pstmt = null;
		rs = null;

		sql = "SELECT * FROM `t_dept` ORDER BY DEPTNO ASC;";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();
		
		// 결과를 출력s
		while (rs.next()) {
			Integer deptno = rs.getInt("DEPTNO");
			String dname = rs.getString("DNAME");%>
		<option value="<%=deptno %>"><%=dname %></option>
		<%} %>
	</select>
    </div>

<script>
$(document).ready(function(){
	$("#dept option[value='<%=dept%>']").prop("selected", true);
});
</script>

    <div class="item">
    <label>성별</label>
    <span>여자</span><input type="radio" name="gender" value="female" <%if (gender.equals("female")) out.print("checked");%>>
    <span> 남자</span><input type="radio" name="gender" value="male" <%if (gender.equals("male")) out.print("checked");%>>
</div>

    <div class="item">
    <label>생년월일</label>
    <input type="text" value="<%=bYear %>" name="bYear" class="form-control" style="width: 80px;;" maxlength="4"><span>년 </span>
    <input type="text" value="<%=bMon %>" name="bMon" class="form-control" style="width: 80px;;" maxlength="2"><span>월 </span>
    <input type="text" value="<%=bDay %>" name="bDay" class="form-control" style="width: 80px;;" maxlength="2"><span>일 </span>
</div>

    <div class="item">
    <label>전화번호</label>
    <input type="text" class="form-control" style="width: 80px;" name="num1" value="<%=num1%>" onInput="checkPhone(this.name)" maxlength="3"> 
	<span>-</span> 
	<input type="text" class="form-control" style="width: 80px;" name="num2" value="<%=num2%>" onInput="checkPhone(this.name)" maxlength="4"> 
	<span>-</span> 
	<input type="text" class="form-control" style="width: 80px;" name="num3" value="<%=num3%>" onInput="checkPhone(this.name)" maxlength="4"> 
	<br>
	<label></label>
	<input type="checkbox" id="SMSYN" name="SMSYN" <%if (SMSYN.equals("Y")) out.print("checked");%>><span>SMS 수신 동의</span>
</div>

    <div class="item">
    <label>이메일</label>
    <input type="text" name="email1" class="form-control" value="<%=email1%>" onInput="checkMail1()">
    <span>@</span>
    <input type="text" name="email2" class="form-control" value="<%=email2%>" onInput="checkMail2_2()">
	<br>
	<label></label>
    <input type="checkbox" id="emailYN" name="emailYN" <%if (emailYN.equals("Y")) out.print("checked");%>><span>이메일 수신 동의</span>
</div>

    <div class="item">
    <label>주소</label>
	<span class="addressdiv" style="margin-left: 0px;">우편번호: </span><input value="<%=zipcode%>" class="form-control" type="text" id="zipcode" name="zipcode" maxlength="5" onInput=checkZipCode()> 
	<span class="btn" onClick="javascript:execDaumPostcode()" id="adrsSearchBtn">우편번호 검색</span>
	<br>
	<label></label><span class="addressdiv">지번 주소: </span><input value="<%=jibunAddress%>" class="form-control" type="text" id="jibunAddress" name="jibunAddress" style="width: 300px;" onInput=checkAddress(this.name)>
	<br>
	<label></label><span class="addressdiv">도로명 주소: </span><input value="<%=roadAddress%>" class="form-control" type="text" id="roadAddress" name="roadAddress" style="width: 300px;" onInput=checkAddress(this.name)>
	<br>
	<label></label><span class="addressdiv">나머지 주소: </span><input value="<%=namujiAddress%>" class="form-control" type="text" name="namujiAddress" style="width: 300px;">
</div>

<%} %>
<input class="btn btn-primary" type="submit" value="Save" id="save" name="save">
<span class="btn btn-secondary" style="padding: 7px 10px; position: relative; top: 0.2px;" onClick="location.href='./user_db.jsp'">Cancel</span>
<span class="btn btn-outline-secondary" style="padding: 7px 10px; position: relative; top: 0.2px; background: white;" onClick="history.go(0)">Reset</span>
</form>

		</div>
	</div>
</div>
<script src="./script/register.js"></script>
<script>
function checkMail2_2() {
	var regex = /^[a-zA-Z0-9]+[\.][a-z]+$/;
	
	if(regex.test(document.Registerform["email2"].value)){
		doneCSS("email2");
		return true;
	} else {
		falseCSS("email2");
		return false;
	}
}

function updateForm() {
	if (checkPW()) {
		if (!checkPhone("num1") || !checkPhone("num2") || !checkPhone("num3")) {
			alert("올바른 전화번호를 입력하십시오.");
			setTimeout(function() {
				var elements = document.getElementsByClassName("false");
				if (elements.length > 0) {
					elements[0].focus();
				}
			}, 100);
			return false;
		} else if (!checkMail1() || !checkMail2_2()) {
			alert("올바른 이메일 주소를 입력하십시오.");
			setTimeout(function() {
				var elements = document.getElementsByClassName("false");
				if (elements.length > 0) {
					elements[0].focus();
				}
			}, 100);
			return false;
		} else if (!checkZipCode() || (!checkAddress("roadAddress") && !checkAddress("jibunAddress"))) {
			alert("올바른 주소를 입력하십시오.");
			setTimeout(function() {
				var elements = document.getElementsByClassName("false");
				if (elements.length > 0) {
					elements[0].focus();
				}
			}, 100);
			return false;
		} else {
			return true;
		}
	} else {
		return false;
	}

}

</script>
</body>


</html>