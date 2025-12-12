import SwiftUI
import FirebaseFirestore


struct FriendsView: View {

    @Environment(\.dismiss) var dismiss

    @State private var friends: [String] = []
    @State private var showAddFriend = false
    @State private var newFriendEmail = ""
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        ZStack {

            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // Header
                HStack {
//                    Button(action: { dismiss() }) {
//                        Image(systemName: "chevron.left")
//                            .font(.title3)
//                            .foregroundColor(.white)
//                    }

                    Text("Friends")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()

                    Spacer()

                    // Add friend button
                    Button(action: { showAddFriend = true }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.4))
                    .padding(.horizontal)

                // Friends list
                ScrollView {
                    VStack(spacing: 12) {
                        if friends.isEmpty {
                            Text("No friends yet. Add some!")
                                    .foregroundColor(.white)
                                    .padding()
                        }
                        ForEach(friends, id: \.self) { email in
                            HStack {
                                Text(email)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(14)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, 10)
                }

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showAddFriend) {
                    AddFriendEmailSheet(
                        newFriendEmail: $newFriendEmail,
                        onAdd: {
                            let emailToAdd = newFriendEmail.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            guard !emailToAdd.isEmpty else {
                                errorMessage = "Please enter a email."
                                showError = true
                                return
                            }
                            
                            // Firestore query to check if the email exists
                            let db = Firestore.firestore()
                            db.collection("users")
                                .whereField("email", isEqualTo: emailToAdd)
                                .getDocuments { snapshot, error in
                                    if let error = error {
                                        print("Error fetching user: \(error.localizedDescription)")
                                        errorMessage = "Error checking email."
                                        showError = true
                                        return
                                    }
                                    
                                    if let documents = snapshot?.documents, !documents.isEmpty {
                                        // User exists → add to friends list
                                        if !friends.contains(emailToAdd) {
                                            friends.append(emailToAdd)
                                        }
                                        newFriendEmail = ""
                                        showAddFriend = false
                                    } else {
                                        // User not found
                                        errorMessage = "User not found."
                                        showError = true
                                    }
                    }
                }
            )
        }
        .alert(errorMessage, isPresented: $showError) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FriendsView()
        }
    }
}

