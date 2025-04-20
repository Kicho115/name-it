import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager() // Singleton para uso fácil

    private let isFlashOnKey = "isFlashOn"
    private let isVibrationOnKey = "isVibrationOn"
    private let isVoiceFeedbackOnKey = "isVoiceFeedbackOn"

    // MARK: - Setters
    func setFlashOn(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: isFlashOnKey)
    }

    func setVibrationOn(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: isVibrationOnKey)
    }

    func setVoiceFeedbackOn(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: isVoiceFeedbackOnKey)
    }

    // MARK: - Getters
    func isFlashOn() -> Bool {
        return UserDefaults.standard.bool(forKey: isFlashOnKey)
    }

    func isVibrationOn() -> Bool {
        return UserDefaults.standard.bool(forKey: isVibrationOnKey)
    }

    func isVoiceFeedbackOn() -> Bool {
        return UserDefaults.standard.bool(forKey: isVoiceFeedbackOnKey)
    }
}