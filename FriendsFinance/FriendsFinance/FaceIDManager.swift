

import LocalAuthentication

class FaceIDManager {
    static let shared = FaceIDManager()

    func authenticate(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {

            let reason = "Use Face ID to sign in"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    completion(success, authError)
                }
            }

        } else {
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}
