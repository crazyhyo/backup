// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init("582c43c5379e1cd6033238a735875c5f");
// SDK 초기화 여부를 판단합니다.
console.log(Kakao.isInitialized());

// 로그인
function kakaoLogin() {
  // Kakao.Auth.createLoginButton({
  //   // container: '#kakao-login',
  //   success: function(resp){
  Kakao.Auth.login({
    success: function (authObj) {
      Kakao.API.request({
        url: "/v2/user/me",
        success: function (resp) {
          let kakao_account = resp.kakao_account;
          let properties = resp.properties;

          console.log("<h2>로그인 성공</h2>");
          console.log(`<h4>id : ${resp.id}</h4>`);
          console.log(`<h4>connected time : ${resp.connected_at}</h4>`);

          let email = "";
          let nickname = "";
          if (typeof kakao_account != "undefined") {
            // 변수에 속성 값 넣기
            email = kakao_account.email;
            nickname = properties.nickname;
          }

          console.log(`<h4>email : ${email}</h4>`);
          console.log(`<h4>nickname : ${nickname}</h4>`);
        },
        fail: function (error) {
          console.log("error : " + error);
        },
      });
    },
    fail: function (err) {
      alert(JSON.stringify(err));
    },
  });

  //   },
  //   fail: function(error){
  //     console.log("error : " + error);
  //   }
  // });
}

// 로그아웃
function kakaoLogout() {
  if (Kakao.Auth.getAccessToken()) {
    Kakao.API.request({
      url: "/v1/user/unlink",
      success: function (resp) {
        alert("로그아웃 완료");
        console.log("logout succeed : " + resp);
      },
      fail: function (error) {
        console.log("error : " + error);
      },
    });
    Kakao.Auth.setAccessToken(undefined);
  }
}
