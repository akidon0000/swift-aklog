# swift-aklog
[![Release](https://img.shields.io/github/v/release/akidon0000/swift-aklog)](https://github.com/akidon0000/swift-aklog/releases/latest)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https://swiftpackageindex.com/api/packages/akidon0000/swift-aklog/badge?type=swift-versions)](https://swiftpackageindex.com/akidon0000/swift-aklog)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https://swiftpackageindex.com/api/packages/akidon0000/swift-aklog/badge?type=platforms)](https://swiftpackageindex.com/akidon0000/swift-aklog)
[![License](https://img.shields.io/github/license/akidon0000/swift-aklog)](https://github.com/akidon0000/swift-aklog/blob/main/LICENSE)
[![Twitter](https://img.shields.io/twitter/follow/akidon0000?style=social)](https://twitter.com/akidon0000)

簡単に詳細なログを出力するためのライブラリです。



## インストール方法

### Swift Package Manager

#### Package

このパッケージを`Package.swift`に追加し、ターゲットの依存関係に含めることができます。

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/akidon0000/swift-aklog", .upToNextMajor(from: "0.1.0")),
    ],
    targets: [
        .target(
            name: "<your-target-name>",
            dependencies: ["AKLog"]),
    ]
)
```

#### Xcode

使用方法はこちらの[ドキュメント](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app)から


## 使い方

`AKLog` をimportして使います。

```swift
import AKLog

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        AKLog.debug("メッセージ")
        // 00:00:00 [DEBUG] MainViewController.swift:6 - viewDidLoad:メッセージ
    }
}
```

ログには以下の種類があります。

```swift
AKLog.trace("メッセージ")
AKLog.debug("メッセージ")
AKLog.info("メッセージ")
AKLog.notice("メッセージ")
AKLog.warn("メッセージ")
AKLog.error("メッセージ")
AKLog.critical("メッセージ")
```

## 統計

![Alt](https://repobeats.axiom.co/api/embed/6ad6de677b5d371146416b8047d9cde9aac4507b.svg "Repobeats analytics image")

参考
https://github.com/uhooi/swift-string-transform
https://github.com/melke/SlimLogger
