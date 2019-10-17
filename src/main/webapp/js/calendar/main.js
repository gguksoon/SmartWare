var calendar;

$(function() {
	var calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
    	plugins : [ "dayGrid", "timeGrid", "list", "interaction" ],
		header : {
			left : "prev,next today",
			center : "title", 
			right : "dayGridMonth,timeGridWeek,timeGridDay,listWeek"
		},
		locale: 'ko',
		height: "auto",
		navLinks : true, // can click day/week names to navigate views
		selectable: true, // interaction 플러그인 필요, 사용자가 선택 및 드래그 하여 날짜를 선택할 수 있다.
		editable : true,
		eventLimit : true, // allow "more" link when too many events
		eventSources: [{ // 이벤트(일정) 추가
			events: function(info, successCallback, failureCallback) {
				$.ajax({
					url: cp + "/getAllCalendarList",
					type: "GET",
					dataType: "json",
					success: function(data) {
						successCallback(data.calendarList);
					}
				});
			}
		}],
		eventRender: function(info) { // 일정 hover
			var event = info.event;
			var element = info.el;
			var view = info.view;
			$(element).popover({
				title: $('<div />', {
					'class': 'popoverTitleCalendar',
					'text': event.title
				}).css({
					'background': event.backgroundColor,
					'color': event.textColor
				}),
				content: $('<div />', {
					'class': 'popoverInfoCalendar'
		        }).append('<p><strong>카테고리:</strong> ' + event.extendedProps.category_nm + '</p>')
		          .append('<p><strong>등록자:</strong> ' + event.extendedProps.emp_nm + '</p>')
		          .append('<p><strong>시간:</strong> ' + getDisplayDate(event) + '</p>')
		          .append(getDisplayContent(event)),
		          delay: {
					show: "300",
					hide: "50"
		      	},
		      	trigger: 'hover',
		      	placement: 'top',
		      	html: true,
		      	container: 'body'
			});
			return filtering(event);
		},
		select: function(info) { // 날짜를 클릭 or 드래그 했을 때
			selectDate(info); // ==> calendar.js
		}
    });
    calendar.render();

	// 개인 일정 카테고리 불러오기
	$.getJSON(cp + "/getEmpCategoryList")
		.done(function(data) {
			getDisplayCategory(data.categoryList, $("#empCategory"));
		});
	
	// 부서 일정 카테고리 불러오기
	$.getJSON(cp + "/getDepCategoryList")
		.done(function(data) {
			getDisplayCategory(data.categoryList, $("#depCategory"));
		});
	
	// 카테고리 체크박스 클릭
	$(document).delegate(".categoryList", "click", function() {
		var iTag = $(this).children("i");
		
		if(iTag.hasClass("on")) { // 체크되어 있을 때
			$(this).children("i").removeClass("fa-check-square-o on");
			$(this).children("i").addClass("fa-square-o off");	
		} else if(iTag.hasClass("off")) { // 체크되지 않았을 때
			$(this).children("i").removeClass("fa-square-o off");
			$(this).children("i").addClass("fa-check-square-o on");
		}
		
		calendar.rerenderEvents();
	});
	
	// 카테고리 체크박스 전체 선택
	$(".categoryAll").on("click", function() {
		var selectedId = $(this).attr("id")
		
		if(selectedId === "empCategoryOn") {			// 개인 일정 전체 선택
			$("#empCategory div.categoryList > i").addClass("fa-check-square-o on");
			$("#empCategory div.categoryList > i").removeClass("fa-square-o off");
		} else if(selectedId  === "empCategoryOff") {	// 개인 일정 전체 해제
			$("#empCategory div.categoryList > i").addClass("fa-square-o off");
			$("#empCategory div.categoryList > i").removeClass("fa-check-square-o on");
		} else if(selectedId  === "depCategoryOn") {		// 부서 일정 전체 선택
			$("#depCategory div.categoryList > i").addClass("fa-check-square-o on");
			$("#depCategory div.categoryList > i").removeClass("fa-square-o off");
		} else if(selectedId  === "depCategoryOff") {	// 부서 일정 전체 해제
			$("#depCategory div.categoryList > i").addClass("fa-square-o off");
			$("#depCategory div.categoryList > i").removeClass("fa-check-square-o on");
		}
		
		calendar.rerenderEvents();
	});
	
});

function getDisplayCategory(data, loc) {
	var res = "";
	
	// 카테고리 리스트 출력
	$.each(data, function(index, entry) {
		res += "<hr>";
		res += "<div id=" + entry.category_id + " class='categoryList'>"
		res += "<i class='fa fa-lg fa-check-square-o on' style='color: " + entry.color + "; width: 20px;'></i>";
		res += "<span> " + entry.category_nm + "</span>";
		res += "<button class='btnCateModify btnCateUpdate'>"
		res += "<i class='fa fa-lg fa-wrench cateModify'></i>";
		res += "</button>";
		res += "<button class='btnCateModify btnCateDelete'>"
		res += "<i class='fa fa-lg fa-times'></i>";
		res += "</button>";
		res += "</div>";
	});
	// 카테고리 추가 버튼 출력
	res += "<hr>";
	if(loc.attr("id") === "empCategory")
		res += "<span id='addEmpCategory'>";
	else if(loc.attr("id") === "depCategory")
		res += "<span id='addDepCategory'>";
	res += "<i class='fa fa-lg fa-plus-circle' style='width: 20px;'></i>";
	res += "<span data-toggle='modal' data-target='#categoryModal'> 새로운 카테고리</span>";
	// 위에서 저장한 HTML태그를 document에 출력
	loc.append(res);
}

// 받아온 시간을 moment.js를 이용하여 포맷에 정의된 형태로 반환
function getDisplayDate(event) {

	// 반환 될 데이터가 저장됨
	var displayEventDate;

	if(event.allDay == false) {
		var startDate = moment(event.start).format('HH:mm');
		var endDate = moment(event.end).format('HH:mm');
		if(event.end == null) 
			displayDate = startDate	
		else 
			displayDate = startDate + " - " + endDate;
		
	} else {
		displayDate = "하루 종일";
	}

	return displayDate;
}

function getDisplayContent(event) {
	var content = event.extendedProps.description;
	
	if(content != null) {
		return '<div class="popoverDescCalendar"><strong>설명:</strong> ' + content + '</div>';
	} else {
		return '';
	}
}

// 카테고리 체크박스 해제 시 해당 일정이 출력되지 않도록 해주는 함수
function filtering(event) {
	// 선택되어 있는 필터의 카테고리아이디들을 맵객체로 저장
	var checkedCategory = $(".on").map(function () {
		return $(this).parent().attr("id");
	}).get();
	
	// 맵객체에서 이벤트의 카테고리아이디가 일치하는지를 반환
	return checkedCategory.indexOf(event.extendedProps.category_id) >= 0;
}

// 카테고리 추가, 수정 시 색상을 초기화 하기 위한 함수
function selectColor(color) {
	$(".btn-colorselector").css("backgroundColor", color);
	$(".dropdown-caret > li > a").removeClass("selected");
	$(".dropdown-caret > li > a").each(function(index, item) {
		if(item.title === color) {
			$(item).addClass("selected");
		}
	});
}

// rgb를 hex로 변경하는 함수
function rgb2hex(rgb) {
     if (rgb.search("rgb") == -1) {
          return rgb;
     } else {
          rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);
          function hex(x) {
               return ("0" + parseInt(x).toString(16)).slice(-2);
          }
          return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]); 
     }
}

// 컬러셀렉터 표시
$("#colorselector").colorselector();

// tui.date-picker
var picker = tui.DatePicker.createRangePicker({
	language: 'ko',
    startpicker: {
        date: new Date(),
        input: '#startpicker-input',
        container: '#startpicker-container'
    },
    endpicker: {
        date: new Date(),
        input: '#endpicker-input',
        container: '#endpicker-container'
    },
    type: 'date',
    format: 'yyyy-MM-dd HH:mm',
    timepicker: {
    	language: 'ko',
    	showMeridiem: false
    }
});