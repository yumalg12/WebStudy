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
<title>Department Modification</title>

<style>
.smallth{
width: 20%; 
min-width: 80px;
}

.smalltd{
text-align:center;}
</style>
</head>
<%@include file="./header.jsp"%>

<body>
	<div class="contents">
		<div class="grid" style="grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="./sidebar.jsp"%>
			</div>
			<div class="container">

				<h1>부서 관리</h1>
<h2>부서 목록</h2>
				<table
					style="width: 50%; margin-left: auto; margin-right: auto; min-width: 320px; max-width: 800px;">
					<tr>
						<th class="smallth">부서번호</th>
						<th>부서명</th>
						<th class="smallth">인원</th>
					</tr>

					<%@ include file="./admin/conn.jsp"%>

					<%
					// DB에서 정보 가져오기
					PreparedStatement pstmt = null;
					ResultSet rs = null;

					String sql = "SELECT t_dept.DEPTNO, t_dept.DNAME, IFNULL(COUNT(t_shopping_member.deptno), 0) AS 'COUNT' "
							+"FROM t_dept "
							+"LEFT JOIN t_shopping_member ON t_dept.DEPTNO = t_shopping_member.DEPTNO "
							+"GROUP BY t_dept.DEPTNO, DNAME "
							+"ORDER BY t_dept.DEPTNO ASC;";

					pstmt = conn.prepareStatement(sql);

					rs = pstmt.executeQuery();

					// 결과를 출력
					while (rs.next()) {
						Integer deptno = rs.getInt("DEPTNO");
						String dname = rs.getString("DNAME");
						Integer count = rs.getInt("COUNT");
					%>

					<tr>
						<td class="smalltd"><%=deptno%></td>
						<td><%=dname%></td>
						<td class="smalltd"><%=count%></td>
					</tr>
					<%
					}
					%>
				</table>
				<br>
				<h2>부서 추가</h2>
				
				<form name="Registerform" action="./admin/dept_add.jsp"
					method="post" onSubmit="return checkDept();">

					<div class="item">
						<label>부서 번호</label> <input type="text" name="deptno"
							class="form-control" placeholder="deptno" value="" maxlength="5">
					</div>

					<div class="item">
						<label>부서명</label> <input type="text" name="dname" class="form-control"
							placeholder="dname" value="">
					</div>
				<div id="infobtns">
					<input class="btn btn-primary" type="submit" value="Add" id="add" name="add">
				</div>
				</form>

			</div>
		</div>
	</div>
<script>
function checkDept () {
	var deptno = document.Registerform.deptno.value;
	var dname =  document.Registerform.dname.value;
	
	var regex = /^[0-9]{2,5}$/;
	
		if (deptno == null || deptno == "") {
			alert("부서 번호를 입력하십시오.");
			  setTimeout(function () { document.Registerform.deptno.focus(); }, 100);
			return false;
		} else if (!regex.test(deptno)) {
			alert("부서 번호는 2자리 이상의 숫자여야 합니다.");
			  setTimeout(function () { document.Registerform.deptno.focus(); }, 100);
			return false;
		} else if (regex.test(deptno)) {
			if (dname == null || dname == "") {
				alert("부서 이름을 입력하십시오.");
				  setTimeout(function () { document.Registerform.dname.focus(); }, 100);
				return false;
			} else if (dname.length < 2) {
				alert("부서 이름은 2글자 이상이어야 합니다.");
				  setTimeout(function () { document.Registerform.dname.focus(); }, 100);
				return false;
			} else if (dname.length >= 2) {
				return true;
			} else {
				alert("오류가 발생했습니다.");
				  setTimeout(function () { document.Registerform.dname.focus(); }, 100);
				return false;
			}
		} else {
			alert("오류가 발생했습니다..");
			  setTimeout(function () { document.Registerform.deptno.focus(); }, 100);
			return false;
		}
	}
</script>
</body>
</html>