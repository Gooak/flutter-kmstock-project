# Flutter-kmstock-project

계명대학교 캡스톤디자인 주식초보자 도움 어플
<br>

>사용자에게 눈에 띄는 GUI를 제공하여 접근성을 높이고정보를 빠르게 제공하여<br>
장내 중요사항을 빨리 접할 수 있는 애플리케이션을 제공한다.<br>
이 본문에서는 어플리케이션에 대한 부분만 가지고 있다.<br>
Flutter version 2.5.2
<br>
<br>

# 서비스 제공을 위한 정보와 서버의 흐름 설계도
![image](https://user-images.githubusercontent.com/91882939/224691115-f0d774d7-1665-44a4-b8d4-9a770da756a2.png)



# Flutter 사용 라이브러리
- [get](https://pub.dev/packages/get)
- [syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts)
- [cupertino_icons](https://pub.dev/packages/cupertino_icons)
- [intl](https://pub.dev/packages/intl)
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [flutter_signin_button](https://pub.dev/packages/flutter_signin_button)
- [firebase_messaging](https://pub.dev/packages/firebase_messaging)
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- [webview_flutter](https://pub.dev/packages/webview_flutter)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- [cp949](https://pub.dev/packages/cp949)
- [flutter_easyloading](https://pub.dev/packages/flutter_easyloading)

# 결과물 페이지
![image](https://user-images.githubusercontent.com/91882939/224696900-35024649-bc69-4af7-ae06-6200e8a602f4.png)


![image](https://user-images.githubusercontent.com/91882939/224697035-b618cb37-79e6-42a3-851e-a78ef683e1cf.png)


![image](https://user-images.githubusercontent.com/91882939/224697163-f86bb539-5050-4251-8ae1-a321edf2f915.png)


![image](https://user-images.githubusercontent.com/91882939/224697452-29260669-2207-4a27-be54-6a202cb1b15f.png)


![image](https://user-images.githubusercontent.com/91882939/224697503-da925ba9-c5b9-4053-93e6-dace44bb1759.png)


![image](https://user-images.githubusercontent.com/91882939/224697556-07555f17-173a-48af-88de-c45301c807d4.png)


![image](https://user-images.githubusercontent.com/91882939/224697596-bdd2077e-29a1-485c-9c38-ed0812b59c96.png)


![image](https://user-images.githubusercontent.com/91882939/224697643-769bae4f-530c-48ed-9d3a-1b2965906ebd.png)


![image](https://user-images.githubusercontent.com/91882939/224697682-1319be11-8404-463d-b2c2-4e1835dd6a0f.png)


# 느낀점

처음으로 Flutter로 개발해본 프로젝트이다.
배움과 동시에 개발을 시작하여서 많이 어색하였고,<br>
이를 구글 검색, Flutter 카카오톡 오픈 채팅방에서 주로 도움을 받았다.<br>

이 개발을 통하여 MVC패턴에 대해 조금 알게되었고
서버에서 HTTP를 통하여 JSON형태로 데이터를 받아오는데<br>
JSON데이터를 핸들링 하기위한 Class모델을 생성하여 직렬화하는 방법을 터득하였다.<br>

Firebase를 통하여 Auth 로그인 FrieStore의 NoSQL등 사용법을 터득하였고
이를 가지고 CRUD를 사용할 수 있게되었다.

# 아쉬운점

디자인 설계를 제대로 하지 못하여 디자인이 많이 아쉽다.

Notification으로 알람이 울리면 이를 연결 시켜서 화면에 나타내고 싶었으나
예제를 잘 사용하지 못해 구현하지 못했다.

MVC패턴으로 코드를 짜긴 하였으나 요구사항과 제출기간이 촉박해짐으로 인해 중복코드가 종종 있다.

