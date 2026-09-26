//
//  JailbreakDetectionService.swift
//  SecureSecretManager

import MachO
import Foundation
import UIKit

final class JailbreakDetectionService {

    static let shared = JailbreakDetectionService()
    private init() {}

    func isJailbroken() -> Bool {
        #if targetEnvironment(simulator)

        return false
        #else
        var suspicionScore = 0

        if checkSuspiciousFiles() { suspicionScore += 1 }
        if checkSandboxWriteViolation() { suspicionScore += 1 }
        if checkSuspiciousURLSchemes() { suspicionScore += 1 }
        if checkForkAvailability() { suspicionScore += 1 }
        if checkDYLD() { suspicionScore += 1 }

        return suspicionScore >= 2
        #endif
    }


    private func checkSuspiciousFiles() -> Bool {
        let suspiciousPaths = [
            "/Applications/Cydia.app",
            "/Applications/Sileo.app",
            "/Applications/Zebra.app",
            "/Applications/Installer.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/private/var/stash",
            "/private/var/tmp/cydia.log",
            "/bin/bash",
            "/usr/bin/ssh"
        ]

        for path in suspiciousPaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }

    private func checkSandboxWriteViolation() -> Bool {
        let testPath = "/private/jailbreak_test_\(UUID().uuidString).txt"
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            try? FileManager.default.removeItem(atPath: testPath)
            return true
        } catch {
            return false
        }
    }

    private func checkSuspiciousURLSchemes() -> Bool {
        let suspiciousSchemes = [
            "cydia://",
            "sileo://",
            "zbra://",
            "undecimus://",
            "filza://"
        ]

        for scheme in suspiciousSchemes {
            if let url = URL(string: scheme) {
                if UIApplication.shared.canOpenURL(url) {
                    return true
                }
            }
        }
        return false
    }


    private func checkForkAvailability() -> Bool {
        let pointerToFork = UnsafeMutableRawPointer(bitPattern: -2)
        let forkPtr = dlsym(pointerToFork, "fork")
        typealias ForkType = @convention(c) () -> pid_t

        guard let fork = forkPtr else { return false }
        let forkFunc = unsafeBitCast(fork, to: ForkType.self)
        let pid = forkFunc()

        if pid >= 0 {
            if pid > 0 {
                kill(pid, SIGTERM)
            }
            return true
        }
        return false
    }

    private func checkDYLD() -> Bool {
        let suspiciousLibraries = [
            "MobileSubstrate",
            "SubstrateLoader",
            "SSLKillSwitch",
            "libhooker",
            "SubstrateInserter"
        ]

        let imageCount = _dyld_image_count()
        for i in 0..<imageCount {
            guard let imageNamePtr = _dyld_get_image_name(i) else { continue }
            let imageName = String(cString: imageNamePtr)
            for suspicious in suspiciousLibraries {
                if imageName.contains(suspicious) {
                    return true
                }
            }
        }
        return false
    }
}
