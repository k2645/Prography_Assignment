# Prography Assignment

## Storyboard 삭제 및 CodeBase AutoLayout 설정

## Custom TabBar 생성

### Trouble Shooting
- custom tabBar를 생서하는 과정에서 tabBar의 높이를 조정해야했는데 잘 적용이 되지 않았다.

## Custom Navigation Bar 설정

### Trouble Shooting
- Navigation Bar의 Background color를 흰색으로 설정해야 했는데 barTintColor가 적용되지 않는 이슈가 발생하였다.

## Unsplash API 연동

### Trouble Shooting
- Unsplash client_id를 추가하고 커밋 푸시를 하는 과정에서 client_id를 담은 secret파일이 gitignore에 추가했음에도 repository에 올라가는 이슈가 발생하였다.
- JSON Parsing을 하는 과정에서 Decoding이 되지 않는 이슈가 발생하였다.

## CocoaPods를 사용하여 RxSwift, RxCocoa 설치

### Trouble Shooting
1. 다음 같은 에러 발생
![image](https://github.com/k2645/Prography_Assignment/assets/62226667/0417857d-bcd2-4051-909f-81c9838b253d)
- Project - Configurations - Debug/Release 재설정
2. 위 에러를 해결한 후 위와 같은 에러 발생
![image](https://github.com/k2645/Prography_Assignment/assets/62226667/3d5bd3e6-1444-4a90-aa9a-0b6c37e40627)
- Target - Build Settings - Build Options - User Script Sandboxing - No로 설정
