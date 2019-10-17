<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="${cp }/js/jquery-3.4.1.min.js"></script>
<script>
//사용자 정보 클릭시 이벤트 핸들러
// $(document).ready(function(){
	$(function(){
		if("${res }"){
			alert("${res }");
		}	
		
	$(".deleteBtn").on("click", function(){
		var result = confirm("정말로 삭제하시겠습니까?");
		
		if(result) {
			$("#selectEmp").val($(this).data("emp_id"));
			$("#frm").prop("action", "${cp}/deleteEmployee");
			$("#frm").submit();
		}
		
// 		Swal({
// 			title: '삭제 요청',
// 			text: "해당 사원을 삭제하시겠습니까?",
// 			type: 'warning',
// 			showCancelButton: true,
// 			confirmButtonColor: '#3085d6',
// 			cancelButtonColor: '#d33',
// 			confirmButtonText: '네',
// 			cancelButtonText: '아니오'
// 		}).then((result) => {
// 			if (result.value) {
// 				$.ajax({
// 					url : '${cp}deleteEmployee',
// 					type : 'post',
// 					data : {name : '${employee.EMP_ID}'},
// 					success : function(data){
// 					Swal({
// 						title: '삭제 완료',
// 						text: '해당 사원이 삭제되었습니다.',
// 						type: 'black',
// 						confirmButtonText: '확인',
// 						timer: 3000
// 					})
// 					}
// 			});
// 		};
	});
	
	$(".updateBtn").on("click", function(){
		
		$("#selectEmp").val(($(this).parents("tr")).attr("id"));
		$("#updateBtn").val($(this).attr("value"));
		var emp_id = ($(this).parents("tr")).attr("id");
		$("#updateAble").val($("#updateAble"+emp_id + " option:selected").val());
		console.log($("#updateBtn").val());
		$("#frm").submit();
	})
	
	$(".updateBtn2").on("click", function(){
		$("#selectEmp").val(($(this).parents("tr")).attr("id"));
		$("#updateBtn2").val($(this).attr("value"));
		var emp_id = ($(this).parents("tr")).attr("id");
		$("#updateRank").val($("#updateRank"+emp_id + " option:selected").val());
		console.log($("#updateRank"+emp_id + " option:selected").val());
		$("#frm").submit();
	})
	
	$(".updateBtn3").on("click", function(){
		$("#selectEmp").val(($(this).parents("tr")).attr("id"));
		$("#updateBtn3").val($(this).attr("value"));
		var emp_id = ($(this).parents("tr")).attr("id");
		$("#updateDepart").val($("#updateDepart"+emp_id + " option:selected").val());
		console.log($("#updateDepart"+emp_id + " option:selected").val());
		$("#frm").submit();
	});
	
	$("#createEmp").on("click", function() {
		$("#createFrm").submit();
	});
	
});
	

</script>

<%-- <form id="frm" action="${cp }/user/user" method="get"> --%>
<!-- 	<input type="hidden" id="emp_id" name="emp_id" /> -->
<!-- </form> -->

	<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div class="row">
					<div class="col-sm- blog-main">
					<h2 class="sub-header">사원 등록</h2>
					<br>
					<!-- 사원 등록 테이블 -->
						<div class="table-responsive">
				<form id="createFrm" class="form-horizontal" action="${cp }/insertEmployee" method="post">
					
<!-- 					<div class="form-group"> -->
				
							<table class="table table-hover">
								<tr>
								<td><label class="col-sm control-label">사원 아이디</label></td>
								<!-- 사원 아이디(emp_id) -->
								<td>
								<input placeholder="e0000" id="newEmp_id" type="text" name="emp_id" class="form-control" value=""/>
								</td>
								<td><label class="col-sm control-label">비밀번호</label></td>
								<!-- 비밀번호(pass) -->
								<td>
								<input id="newPass" type="text" name="pass" class="form-control" value=""/>
								</td>
								</tr>
								<tr>
								<td><label class="col-sm control-label">사원 이름</label></td>
								<!-- 사원 이름(emp_nm) -->
								<td>
								<input id="newEmp_nm" type="text" name="emp_nm" class="form-control" value=""/>
								</td>
								<td><label class="col-sm control-label">등급</label></td>
								<!-- 등급(rank) : USER로 고정 -->
								<td>
								<input placeholder="USER" id="newRank" type="text" name="rank" class="form-control" value=""/>
								</td>
								</tr>
								<tr>
								<td><label class="col-sm control-label">이메일</label></td>
								<!-- 이메일(email) -->
								<td>
								<input placeholder="test1234@gmail.com" id="newEmail" type="text" name="email" class="form-control" value=""/>
								</td>
								<td><label class="col-sm control-label">전화번호</label></td>
								<!-- 전화번호(tel) -->
								<td>
								<input placeholder="010-1234-1234" id="newTel" type="text" name="tel" class="form-control" value=""/>
								</td>
								</tr>
								<tr>
								<td><label class="col-sm control-label">입사일</label></td>
								<!-- 입사일(join_dt) -->
								<td>
								<input id="newJoin_dt" type="date" name="join_dt" class="form-control" value="" pattern="yyyy-MM-dd"/>
								</td>
<%-- 								<td><fmt:formatDate value="${employee.JOIN_DT }" pattern="yyyy-MM-dd"/></td> --%>
								<!-- 부서(department : depart_id를 이용해서 depart_nm(부서명)을 불러오기  -->
								<td><label class="col-sm control-label">부서</label></td>
								<td><select id="insertDepart" name="depart_id" class="form-control">
										<c:forEach items="${departmentList }" var="department">
											<option value="${department.depart_id}">${department.depart_nm}</option>
										</c:forEach>
											</select>
										</td>
										</tr>
										<tr>
										<td><label class="col-sm control-label">직책</label></td>
								<!-- 직책(position : posi_id를 이용해서 posi_nm(직책명)을 불러오기  -->
								<td><select id="insertRank" name="posi_id" class="form-control">
										<c:forEach items="${positionList }" var="position">
											<option value="${position.posi_id}">${position.posi_nm}</option>
										</c:forEach>
											</select>
										</td>
										<td><label class="col-sm control-label">이메일 비밀번호</label></td>
										<td>
										<input id="newEmail_pass" type="pass" name="email_pass" class="form-control" value=""/>
										</td>
										
<!-- 										<td><label class="col-sm control-label">활성화 / 비활성화</label></td> -->
<!-- 										활성화 / 비활성화(able) : 활성화로 선택이 되어있도록 고정 (활성화) -->
<!-- 										<td> -->
<%-- 										<select id="insertAble${employee.EMP_ID}" name="updateable2" class="form-control"> --%>
<%-- 											<option value="${employee.ABLE == 'T'}" selected>활성화</option> --%>
<!-- 										</select> -->
<!-- 										</td> -->
										</tr>
									</table>
								<button id="createEmp" type="button" name="insertBtn" class="btn mb-1 btn-outline-primary pull-right" value="insert">추가</button>
								</form>
					<!-- 사원 등록 테이블 끝 -->
					<br>
					<!-- 사원 리스트 메인 테이블 -->
						<div class="table-responsive">
				<form id="frm" class="form-horizontal" action="${cp }/updateEmployee" method="post">
					<input id="selectEmp" name="emp_id" type="hidden"/>
					<input id="updateBtn" name="updateBtn" type="hidden"/>
					<input id="updateBtn2" name="updateBtn2" type="hidden"/>
					<input id="updateBtn3" name="updateBtn3" type="hidden"/>
					<input id="updateRank" name="posi_id" type="hidden"/>
					<input id="updateAble" name="able" type="hidden"/>
					<input id="updateDepart" name="depart_id" type="hidden"/>
					<input id="deleteBtn" name="emp_id2" type="hidden"/>
				</form>
								<div class="form-group">
								
								<h2 class="sub-header">사원 리스트</h2>
								<br>
							<table class="table table-hover">
								<tr>
									<th>사원 아이디</th>
									<th>사원 이름</th>
									<th>부서</th>
									<th>직책</th>
									<th>입사일</th>
								</tr>
								<c:forEach items="${employeeList }" var="employee">
									<tr id="${employee.EMP_ID}" class="employeeTr" data-emp_id="${employee.EMP_ID}">
										<!-- 사원 아이디 -->
										<td>${employee.EMP_ID }</td>
										<!-- 사원 이름 -->
										<td>${employee.EMP_NM }</td>
										<!-- 활성화인 경우 부서변경  td -->
										<c:if test="${employee.ABLE == 'T' }">
										<td><select id="updateDepart${employee.EMP_ID}" name="updatedepartment" class="form-control">
										<c:forEach items="${departmentList }" var="department">
												<c:choose>
													<c:when test="${employee.DEPART_ID == department.depart_id}">
														<option value="${employee.DEPART_ID}" selected>${department.depart_nm}</option>
													</c:when>
													<c:otherwise>
														<option value="${department.depart_id}">${department.depart_nm}</option>
													</c:otherwise>
												</c:choose>
										</c:forEach>
											</select>
										</td>
										</c:if>
										
										<!-- 비활성화인 경우 부서변경  td (disabled) -->
										<c:if test="${employee.ABLE == 'F' }">
										<td><select id="updateDepart${employee.EMP_ID}" name="updatedepartment" class="form-control" disabled>
										<c:forEach items="${departmentList }" var="department">
												<c:choose>
													<c:when test="${employee.DEPART_ID == department.depart_id}">
														<option value="${employee.DEPART_ID}" selected>${department.depart_nm}</option>
													</c:when>
													<c:otherwise>
														<option value="${department.depart_id}">${department.depart_nm}</option>
													</c:otherwise>
												</c:choose>
										</c:forEach>
											</select>
										</td>
										</c:if>
										
										<!-- 활성화인 경우 직책변경  td -->
										<c:if test="${employee.ABLE == 'T' }">
										<td><select id="updateRank${employee.EMP_ID}" name="updaterank" class="form-control">
										<c:forEach items="${positionList }" var="position">
												<c:choose>
													<c:when test="${employee.POSI_ID == position.posi_id}">
														<option value="${employee.POSI_ID}" selected>${position.posi_nm}</option>
													</c:when>
													<c:otherwise>
														<option value="${position.posi_id}">${position.posi_nm}</option>
													</c:otherwise>
												</c:choose>
										</c:forEach>
											</select>
										</td>
										</c:if>
										
										<!-- 비활성화인 경우 직책변경  td (disabled) -->
										<c:if test="${employee.ABLE == 'F' }">
										<td><select id="updateRank${employee.EMP_ID}" name="updaterank" class="form-control" disabled>
												<c:forEach items="${positionList }" var="position">
												<c:choose>
													<c:when test="${employee.POSI_ID == position.posi_id}">
														<option value="${employee.POSI_ID}" selected>${position.posi_nm}</option>
													</c:when>
													<c:otherwise>
														<option value="${position.posi_id}">${position.posi_nm}</option>
													</c:otherwise>
												</c:choose>
										</c:forEach>
											</select>
											
										</td>
										</c:if>
										<!-- 입사날짜 -->
										<td><fmt:formatDate value="${employee.JOIN_DT }" pattern="yyyy-MM-dd"/></td>
										<!-- 활성화 / 비활성화 -->
										<td>
										<select id="updateAble${employee.EMP_ID}" name="updateable" class="form-control">
											<c:choose>
												<c:when test="${employee.ABLE == 'T' }">
													<option selected>활성화</option>
													<option>비활성화</option>
												</c:when>
												<c:when test="${employee.ABLE == 'F' }">
													<option>활성화</option>
													<option selected>비활성화</option>
												</c:when>
											</c:choose>
										</select>
										</td>
										<!-- 버튼 -->
										<td>
										<button id="update${employee.EMP_ID}" type="button" name="updateBtn" class="updateBtn btn mb-1 btn-outline-success" value="modify">수정</button>
<%-- 										<a href="${cp }/deleteEmployee?emp_id=${employee.EMP_ID}" id="deleteEmp" class="deleteEmp btn mb-1 btn-outline-dark pull-right">삭제</a> --%>
										<button id="delete${employee.EMP_ID}" data-emp_id="${employee.EMP_ID}" type="button" name="deleteBtn" class="deleteBtn btn mb-1 btn-outline-dark pull-right" value="delete">삭제</button>
										<c:if test="${employee.ABLE == 'T' }">
										<button id="updateDepart${employee.EMP_ID }" type="button" name="updateBtn3" class="updateBtn3 btn mb-1 btn-outline-primary" value="modifyDepartment">부서변경</button>
										</c:if>
										<c:if test="${employee.ABLE == 'F' }">
										<button id="updateDepart${employee.EMP_ID }" type="button" name="updateBtn3" class="updateBtn3 btn mb-1 btn-outline-primary" value="modifyDepartment" disabled="disabled">부서변경</button>
										</c:if>
										<c:if test="${employee.ABLE == 'T' }">
										<button id="updateRank${employee.EMP_ID }" type="button" name="updateBtn2" class="updateBtn2 btn mb-1 btn-outline-primary" value="modifyPosition">직책변경</button>
										</c:if>
										<c:if test="${employee.ABLE == 'F' }">
										<button id="updateRank${employee.EMP_ID }" type="button" name="updateBtn2" class="updateBtn2 btn mb-1 btn-outline-primary" value="modifyPosition" disabled="disabled">직책변경</button>
										</c:if>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
<%-- <!-- 사원 추가 -->			<a href="${cp }/insertEmployee" id="insertEmp" class="insertEmp btn mb-1 btn-outline-primary pull-right">사원 추가 </a> --%>
						<!-- 사원 리스트 페이지네이션 -->
						<div class="bootstrap-pagination">
							<nav>
								<ul class="pagination justify-content-center">
								<!-- 이전 페이지 가기 : 지금 있는 페이지에서 한페이지 전으로 -->
									
									<c:choose>
										<c:when test="${page == 1 }">
											<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">&laquo;</a></li>
												<span aria-hidden="Previous"></span>
										</c:when>
										<c:otherwise>
											<li class="page-item">
								 				<a class="page-link" href="${cp }/employeeList?page=1&emp_id=${emp_id}" aria-label="Previous">
													<span aria-hidden="true">&laquo;</span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>
											
											
									<c:choose>
										<c:when test="${page == 1 }">
											<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">&lt;</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="${cp }/employeeList?page=${page-1}&emp_id=${emp_id}" tabindex="-1">&lt;</a></li>
										</c:otherwise>
									</c:choose>
									
									<c:forEach begin="1" end="${paginationSize }" var="i">
										<c:choose>
											<c:when test="${i == page }">
												 <li class="page-item disabled"><span class="page-link">${i }</span></li>
											</c:when>
											<c:otherwise>
												 <li class="page-item"><a class="page-link" href="${cp }/employeeList?page=${i }&emp_id=${emp_id}">${i }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<c:choose>
										<c:when test="${page == paginationSize || paginationSize == 0}">
											<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
										</c:when>
										<c:otherwise>
												<li class="page-item"><a class="page-link" href="${cp }/employeeList?page=${page+1}&emp_id=${emp_id}">&gt;</a>
                                            </li>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${page == paginationSize || paginationSize == 0}">
											<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
												<span aria-hidden="Next"></span>
										</c:when>
										<c:otherwise>
											<li class="page-item">
								 				<a class="page-link" href="${cp }/employeeList?page=${paginationSize }&emp_id=${emp_id}" aria-label="Previous">
													<span aria-hidden="true">&raquo;</span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
			</div>
			</div>
		</div>
		</div>
	</div>
</div>