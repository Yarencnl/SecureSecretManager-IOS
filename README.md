# 🔐 Secure Secret Manager - iOS Security Vault

Bu proje, Apple ekosisteminde güvenli veri saklama standartlarını
(Keychain, Biometrics, Jailbreak Detection) uygulamalı olarak
öğrenmek amacıyla geliştirilmiş, siber güvenlik odaklı bir iOS
parola ve gizli veri kasası uygulamasıdır.

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

## 🧠 Güvenlik Yaklaşımı

* Bu proje **savunma-derinliği (defense in depth)** prensibiyle
  tasarlanmıştır; hiçbir katman tek başına %100 koruma iddia etmez.
* Parolaların **kendisi** hiçbir zaman Core Data'ya yazılmaz, sadece
  Keychain'e karşılık gelen anahtar saklanır.
* Jailbreak tespit yöntemleri bypass edilebilir; bu bilinçli bir
  tasarım kararıdır ve raporlarda dürüstçe belirtilmiştir
  (bkz. OWASP MASTG - Jailbreak Detection).

##
*✨Built with passion by [Yaren Canlı](https://github.com/Yarencnl)*
