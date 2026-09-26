//
//  ScreenProtectionService.swift
//  SecureSecretManager

import UIKit
import SwiftUI

final class ScreenProtectionService {

    static let shared = ScreenProtectionService()
    private init() {}

    private var blurView: UIVisualEffectView?
    private var screenshotObserver: NSObjectProtocol?

    func activate() {
        setupBackgroundBlur()
        setupScreenshotDetection()
    }

    private func setupBackgroundBlur() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    @objc private func willResignActive() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.windows.first })
            .first else { return }

        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = window.bounds
        effectView.tag = 999999 // tanımlamak için

        window.addSubview(effectView)
        blurView = effectView
    }

    @objc private func didBecomeActive() {
        blurView?.removeFromSuperview()
        blurView = nil
    }

    private func setupScreenshotDetection() {
        screenshotObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: .main
        ) { _ in
            print("⚠️ UYARI: Kullanıcı ekran görüntüsü aldı! Hassas veri sızıntısı riski.")
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        if let observer = screenshotObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
