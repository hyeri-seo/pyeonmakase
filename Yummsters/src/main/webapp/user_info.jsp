<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<style>
/*박스*/
.box {
	border-radius: 30px;
	margin: 0 auto;
	width: 800px;
	height: 800px;
	background-color: #FFF8E2;
	position: relative;
}
/*동그라미*/
.c1 {
	float: left;
	margin: 10px;
	background-color: #EEC595;
	width: 30px;
	height: 30px;
	border-radius: 30px;
}

.c2 {
	float: right;
	margin: 10px;
	background-color: #EEC595;
	width: 30px;
	height: 30px;
	border-radius: 30px;
}

.c3 {
	float: left;
	margin: 10px;
	background-color: #EEC595;
	width: 30px;
	height: 30px;
	border-radius: 30px;
	position: absolute;
	bottom: 0;
}

.c4 {
	position: absolute;
	bottom: 0;
	right: 0;
	margin: 10px;
	background-color: #EEC595;
	width: 30px;
	height: 30px;
	border-radius: 30px;
}
/*회원정보*/
.title {
	position: absolute;
	top: 10%;
	left: 35%;
	font-size: 70px;
	line-height: 0px;
	-webkit-text-stroke: 4px #524434;
	color: white;
}

.img {
	position: absolute;
	top: 1%;
	left: 17%;
	width: 150px;
	height: 120px;
}

.name1 {
	position: absolute;
	color: #524434;
	font-size: 25px;
	top: 35%;
	left: 12%;
}

.name2 {
	position: absolute;
	color: #524434;
	font-size: 25px;
	top: 35%;
	left: 20%;
}

.nickname1 {
	position: absolute;
	color: #524434;
	font-size: 25px;
	top: 45%;
	left: 10%;
}

.nickname2 {
	position: absolute;
	color: #524434;
	font-size: 25px;
	width: 500px;
	top: 45%;
	left: 20%;
}

.email1 {
	position: absolute;
	color: #524434;
	font-size: 25px;
	top: 55%;
	left: 10%;
}

.email2 {
	position: absolute;
	color: #524434;
	font-size: 25px;
	width: 500px;
	top: 55%;
	left: 20%;
}
/*버튼*/
#user_btn1 {
	position: absolute;
	left: 15%;
	bottom: 10%;
	border: none;
	width: 250px;
	height: 30px;
	font-size: 20px;
	color: #524434;
	background-color: #EEC595;
	border-radius: 30px;
}

#user_btn2 {
	position: absolute;
	right: 15%;
	bottom: 10%;
	border: none;
	width: 250px;
	height: 30px;
	font-size: 20px;
	color: #524434;
	background-color: #EEC595;
	border-radius: 30px;
}

.popup {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ccc;
	z-index: 1000;
}
</style>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
   
$(document).ready(function() {
    // 회원정보 수정 버튼 이벤트 핸들러
    $('#user_btn1').click(function() {
        location.href = "user_modify.jsp";
    });
               
    // 회원탈퇴 버튼 이벤트 핸들러
    $('#user_btn2').click(function() {
        var message = prompt("정말 탈퇴하시겠습니까? \n 탈퇴하시면 회원정보를 되돌릴 수 없습니다.", "비밀번호를 입력하세요.");
               
        if (message) {
            var memberNickname = "${sessionScope.member.nickname}";
          var memberPw = "${sessionScope.member.member_pw}";
                         
          if(memberPw == message) {
                $.ajax({
                    url: 'memberdelete',
                    type: 'POST',
                    data: {
                        nickname: memberNickname,
                        password: memberPw
                    },
                    success: function(response) {
                           alert("회원 탈퇴가 완료되었습니다.");
                           location.href = "home"; // 탈퇴 후 리다이렉트할 페이지
                    },
                    error: function() {
                       alert("서버 오류가 발생했습니다.");
                    }
                });
             
          } else {
                 alert("비밀번호가 일치하지 않습니다.");
                 console.log("password: " + password)
          }
       };
   });
});
</script>



</head>
<body>
	<!-- header  -->
	<jsp:include page="header.jsp" />
	<!-- 박스-->
	<br>
	<div class="box" style="border: 3px solid #EEC595">
		<!-- 원-->
		<div class="c1" style="display: inline"></div>
		<div class="c2"></div>
		<div class="c3"></div>
		<div class="c4"></div>

		<!-- 회원정보-->
		<img class="img" src="imgView?file=로고.png" alt="">
		<div class="title">
			<b>회원정보</b>
		</div>

		<div class="name1" style="display: inline">
			<b>이름</b>
		</div>
		<div class="name2">${member.member_name }</div>
		<div class="nickname1" style="display: inline">
			<b>닉네임</b>
		</div>
		<div class="nickname2">${member.nickname }</div>
		<div class="email1" style="display: inline">
			<b>이메일</b>
		</div>
		<div class="email2">${member.email }</div>

      <!-- 버튼-->
      <p><button id="user_btn1">회원정보 수정</button></p>

      <p><button id="user_btn2">회원탈퇴</button></p>

	</div>
	<br>




	<jsp:include page="footer.jsp" />
</body>
