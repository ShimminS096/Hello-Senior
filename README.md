# 빌드 오류 참고사항
- Chrome에서는 빌드되는데 android에서는 안될 때
- android/app/build.gradle 파일 확인: 'minSdkVersion 20'일 것
- Cannot resolve symbol 'Properties' 오류이면 Project Structure 에서
  1. Project, 2. Modules, 3. Platform Settings - SDKs
  세 곳의 SDK가 일치하는지 확인.
  ex) 'Android API 34, extension level 7 Platform'
- 참고 링크: https://ilsognobella.tistory.com/29 [내 소소한..:티스토리]
