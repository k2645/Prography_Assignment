# Prography Assignment

## Architecture 
- MVVM

## Framework
- UIKit
- CocoaPods

## 사용된 Library
- RxSwift
- RxCocoa
- KingFisher

## Trouble Shooting
1. Navigation Bar의 Background color를 흰색으로 설정해야 했는데 barTintColor가 적용되지 않는 이슈 발생

`configureWithOpaqueBackground`을 적용
```swift
func setNavigationBarBackground() {
  let appearance = UINavigationBarAppearance()
  appearance.configureWithOpaqueBackground()
  navigationController?.navigationBar.scrollEdgeAppearance = appearance
}
```

2. Unsplash client_id를 추가하고 커밋 푸시를 하는 과정에서 client_id를 담은 secret파일을 gitignore에 추가했음에도 repository에 올라가는 이슈 발생

`% git rm -r --cached .` 를 사용하여 캐시 데이터 삭제 후 커밋 푸시

3. `Unable to load contents of file list` 에러 발생
![image](https://github.com/k2645/Prography_Assignment/assets/62226667/0417857d-bcd2-4051-909f-81c9838b253d)
- Project - Info - Configurations - Debug/Release 재설정 (Secret file 추가)

4. `Sandbox: rsync.samba deny' 에러 발생 
![image](https://github.com/k2645/Prography_Assignment/assets/62226667/3d5bd3e6-1444-4a90-aa9a-0b6c37e40627)
- Target - Build Settings - Build Options - User Script Sandboxing - No로 설정

5. 사진 크기에 따른 Dynamic Height가 적용되지 않는 이슈 발생

Collection View의 layout을 `Compositional Layout`을 사용하여 구현하려 하였다. 

`Compositional Layout`에서는 `NSCollectionLayoutDimension`을 사용하여 layout을 잡는데 `NSCollectionLayoutDimension`는 3개의 case로 이루어져 있었다.
- `.absolute()` : 고정 값으로 layout 설정
- `.fractionalWidth()` : 상위 layout에 대한 비율로 layout 설정
- `.estimated()` : 추측 값을 넣고 실제로는 계산된 값으로 layout 설정

Dynamic Height를 구현하기 위해 `.estimated()`를 사용했는데, API에서 불러온 image의 실제 크기가 height에 반영되었다.

그래서 cell을 생성하는 곳에서 해당 cell에 들어갈 image의 비율을 사용하여 `UIImageView`의 height constraints값으로 주고 `.estimated()`를 사용했다. image의 height 값을 잘 들어갔지만 cell 크기는 동적으로 변하지 않고 설정된 초기값으로 고정되었다.

6. Collection View를 scroll하는 경우 하단 TabBar의 색이 변경되는 이슈 발생

`tabBar.barTintColor` 와 `tabBar.isTranslucent = false` 설정
