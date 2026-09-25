# Secure Secret Manager (iOS)

Siber güvenlik odaklı, Keychain + Biometric Authentication + Jailbreak
Detection kullanan iOS şifre/gizli veri kasası uygulaması.

## Özellikler
- [ ] Face ID / Touch ID kimlik doğrulama
- [ ] iOS Keychain Services ile şifreli veri saklama
- [ ] Core Data (encrypted) - metadata için
- [ ] Jailbreak tespiti
- [ ] Ekran görüntüsü / kayıt koruması

## Mimari
MVVM (Model-View-ViewModel)

## Branching Stratejisi
- `main` — stabil, demo edilebilir sürüm
- `develop` — aktif geliştirme
- `feature/*` — özellik bazlı branch'ler

## Kurulum
Xcode 15+ ile açın, SPM bağımlılıkları otomatik çözülecektir.
