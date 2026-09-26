# 🔐 Secure Secret Manager - iOS Security Vault

Bu proje, Apple ekosisteminde güvenli veri saklama standartlarını
(Keychain, Biometrics, Jailbreak Detection) uygulamalı olarak
öğrenmek amacıyla geliştirilmiş, siber güvenlik odaklı bir iOS
parola ve gizli veri kasası uygulamasıdır.

## Demo Video

<div align="center">
  <video src="https://github.com/user-attachments/assets/cfb03de5-a5a0-4593-9ea4-4ea7249af6af" controls width="200"></video>
</div>
⚠ Video da uygulama , önce yanlış sonra da doğru FaceID ile test edilmiştir.


## 🚀 Özellikler

* **Kimlik Doğrulama:** Face ID / Touch ID ile uygulama açılışında ve
  hassas veri görüntülemede zorunlu biyometrik doğrulama.
* **Şifreli Saklama:** Parolalar `UserDefaults` yerine, cihazın
  donanımsal şifreleme katmanı olan **iOS Keychain**'de saklanır.
* **Jailbreak Tespiti:** 5 farklı teknikle (dosya yolu, sandbox
  ihlali, URL şeması, fork(), dinamik kütüphane taraması) cihaz
  bütünlüğü kontrolü; güvensiz cihazlarda uygulama tamamen kilitlenir.
* **Ekran Koruması:** Arka plana geçişte blur overlay ve ekran
  görüntüsü tespiti ile hassas veri sızıntısı önlenir.
* **Mimari:** MVVM (Model-View-ViewModel) ile temiz ve test edilebilir
  kod yapısı.
* **Kolay Kurulum:** Xcode ile açıp doğrudan çalıştırabilirsiniz,
  harici bağımlılık gerekmez (native SPM ile yönetilir).

## 🛠️ Kurulum ve Çalıştırma

Projeyi çalıştırmak için Xcode 15+ ve iOS 17+ SDK'sının kurulu
olması gerekir.

1. Projeyi klonlayın veya indirin.
2. `SecureSecretManager.xcodeproj` dosyasını Xcode ile açın.
3. Simülatörde çalıştırmak için ⌘R'a basın.


## 🧠 Güvenlik Yaklaşımı

* Bu proje **savunma-derinliği (defense in depth)** prensibiyle
  tasarlanmıştır; hiçbir katman tek başına %100 koruma iddia etmez.
* Parolaların **kendisi** hiçbir zaman Core Data'ya yazılmaz, sadece
  Keychain'e karşılık gelen anahtar saklanır.
* Jailbreak tespit yöntemleri bypass edilebilir; bu bilinçli bir
  tasarım kararıdır ve raporlarda dürüstçe belirtilmiştir
  (bkz. OWASP MASTG - Jailbreak Detection).


##
[<img align="left" alt="Swift" width="50px" src="https://developer.apple.com/assets/elements/icons/swift/swift-256x256_2x.png" />][Swift]
[<img align="left" alt="Xcode" width="50px" src="https://developer.apple.com/assets/elements/icons/xcode/xcode-128x128_2x.png" />][Xcode]
[<img align="left" alt="iOS" width="50px" src="https://img.icons8.com/color/1200/ios-logo.jpg" />][iOS]

[Swift]: https://developer.apple.com/swift
[Xcode]: https://developer.apple.com/xcode
[iOS]: https://developer.apple.com/ios

<br/>
<br/>

##
*✨Built with passion by [Yaren Canlı](https://github.com/Yarencnl)*
