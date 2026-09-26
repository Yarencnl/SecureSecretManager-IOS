//
//  BiometricAuthService.swift
//  SecureSecretManager
import Foundation
import LocalAuthentication

enum BiometricType {
    case none
    case touchID
    case faceID
}

enum BiometricError: Error {
    case notAvailable
    case authenticationFailed
    case userCancelled
    case unknown(Error)
}

final class BiometricAuthService {

    static let shared = BiometricAuthService()
    private init() {}


    var biometricType: BiometricType {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }

        switch context.biometryType {
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .none
        }
    }

    func authenticate(
        reason: String = "Hassas verilerinize erişmek için kimliğinizi doğrulayın",
        completion: @escaping (Result<Bool, BiometricError>) -> Void
    ) {
        let context = LAContext()
        context.localizedCancelTitle = "Vazgeç"
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            completion(.failure(.notAvailable))
            return
        }

        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason
        ) { success, evaluateError in
            DispatchQueue.main.async {
                if success {
                    completion(.success(true))
                } else if let laError = evaluateError as? LAError {
                    switch laError.code {
                    case .userCancel, .userFallback, .systemCancel:
                        completion(.failure(.userCancelled))
                    default:
                        completion(.failure(.authenticationFailed))
                    }
                } else {
                    completion(.failure(.authenticationFailed))
                }
            }
        }
    }
}
