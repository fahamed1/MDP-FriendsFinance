import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class UserViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var profileImage: UIImage? = nil

    private var authHandle: AuthStateDidChangeListenerHandle?

    init() {
        listenToAuthChanges()
    }

    deinit {
        if let handle = authHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    private func listenToAuthChanges() {
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                guard let self = self else { return }
                if let user = user {
                    await self.fetchUserData(uid: user.uid)
                } else {
                    self.name = ""
                    self.email = ""
                    self.profileImage = nil
                }
            }
        }
    }

    private func fetchUserData(uid: String) async {
        let db = Firestore.firestore()
        do {
            let doc = try await db.collection("users").document(uid).getDocument()
            if let data = doc.data() {
                self.name = data["name"] as? String ?? ""
                self.email = data["email"] as? String ?? ""
                // TODO: load profile image from Storage if you store one (async)
            } else {
                self.name = ""
                self.email = ""
            }
        } catch {
            print("Error fetching user: \(error)")
        }
    }

    // Example update function to write changes back to Firestore
    func updateProfile(name: String, email: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .updateData(["name": name, "email": email])
        // Update local published properties
        self.name = name
        self.email = email
    }
}

struct UserViewModel_Previews: PreviewProvider {
    static var previews: some View {
        Text("Previewing UserViewModel")
            .environmentObject(UserViewModel())
    }
}

