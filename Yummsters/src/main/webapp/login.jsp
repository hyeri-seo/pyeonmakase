<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
    /* form 전체 틀 */
    .login-box {
        border-radius: 20px;
        border: 5px solid #EEC595;
        background: #FFF;
        width: 800px;
        margin: 100px auto;
        text-align: center;
    }

    /* form 제목 */
    .title {
        font-size: 20px;
        color: #524434;
        font-weight: bold;
        margin: 20px auto;
    }

    /* input 태그 */
    .login-form-wrap {
        width: 80%;
        padding: 13px 10px;
        margin: 40px auto;
        border-bottom: 3px solid #EEC595;
        display: flex;
        flex-flow: row wrap;
        justify-content: space-between;
        height: 26px;
    }

    .login-form-wrap > input {
        border: none;
        font-size: 17px;
        outline: none;
        height: 26px;
        width: 100%;
    }

    /* input 태그 클릭 시 테두리 표시되지 않도록 설정 */
    .login-form > input:focus {
        outline: none;
    }

    /* 로그인 버튼 */
    .login-form #loginBtn {
        display: inline-block;
        margin: 5px auto 30px auto;
        width: 75%;
        height: 35px;
        border-radius: 5px;
        border: 1px solid #EEC595;
        background: #EEC595;
        color: black;
        text-align: center;
        font-weight: bold;
        font-size: 17px;
    }

    /* join 페이지 이동 */
    .join, .join > a {
        text-align: right;
        margin: 0 30px 30px 0;
        color: #524434;
    }

    .join > a {
        text-decoration: underline;
    }

    /* 소셜 로그인 */
    .social-title {
        color: #524434;
        text-align: center;
        font-size: 17px;
    }

    .login-form > #loginErr {
        margin-bottom: 10px;
    }
</style>

<body>
<jsp:include page="header.jsp"/>
<div class="login-box">
    <div class="title">로그인</div>

    <form class="login-form" method="post" action="login">
        <div class="login-form-wrap">
            <input type="text" id="id" name="id" required
                   placeholder="아이디를 입력하세요"/>
        </div>
        <div class="login-form-wrap">
            <input type="password" id="password" name="password" required
                   placeholder="비밀번호를 입력하세요">
        </div>
        <div id="loginErr"></div>
        <input type="submit" value="로그인" id="loginBtn">

        <div class="join">
            회원이 아니신가요? <a href="signup">회원가입</a>
        </div>
    </form>

    <div class="social-title">
        <a href="javascript:kakaoLogin()"><img src="imgView?file=kakao_login.png" style="width: 300px"></a>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
<script>
    $(function () {
        $("#loginBtn").click(function (e) {
            e.preventDefault(); // 폼 제출 방지
            var id = $("#id").val();
            var password = $("#password").val();

            $.ajax({
                url: "login", // 서블릿 주소
                type: "post", // method 타입
                data: { // 서버로 보낼 데이터
                    id: id,
                    password: password
                },
                success: function (res) {
                    if (res === "fail") {
                        console.log("로그인 실패");
                        $("#loginErr").text("아이디 또는 비밀번호를 잘못 입력했습니다").css("color", "red");
                    } else {
                        $(".loginForm").submit();
                        console.log("로그인 성공");
                        history.pushState(null, null, "./");
                        window.location.reload();
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            })
        })

        // 폼 제출 전 안내 초기화
        $(".login-form").on("input", function () {
            $("#loginErr").text("");
        });
    })
</script>


<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<script>
    Kakao.init('${kakao.javascript.key}');

    function kakaoLogin() {
        Kakao.Auth.login({
            success: function () {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function (response2) {
                        console.log(response2);
                        var email = response2.kakao_account.email;
                        var nickname = response2.kakao_account.profile.nickname;

                        $.ajax({
                            url: 'kakaoLogin',
                            type: 'post',
                            data: {'email': email, 'nickname': nickname},
                            dataType: 'json',
                            success: function (response) {
                                console.log("로그인 성공")
                                alert("로그인 성공");
                                if (response.signup === true) {
                                    alert("회원가입 후 로그인이 완료되었습니다.");
                                    location.href = "home";
                                    return false;
                                }
                                if (response.login === true) {
                                    alert("로그인 완료되었습니다.");
                                    location.href = "home";
                                    return false;
                                }
                            },
                            error: function (request, status, error, response) {
								console.log(response);
                                console.log(error);
                                alert("code: " + request.status + " message: " + request.responseText + " error: " + error);
                            }
                        })
                    },
                    fail: function (error) {
                        alert(JSON.stringify(error))
                    },
                })
            },
            fail: function (error) {
                alert(JSON.stringify(error))
            },
        })

        function kakaoDelete() {
            Kakao.API.request({
                url: '/v1/user/unlink'
            }).then(function(response){
                console.log(response);
            })
                .catch(function (error){
                    console.log(error);
                })

        }
    }
</script>

