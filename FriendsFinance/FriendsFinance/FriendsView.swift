import SwiftUI

struct FriendsView: View {

    @Environment(\.dismiss) var dismiss

    @State private var friends: [String] = ["mehera@example.com", "farhat@gmail.com"]
    @State private var showAddFriend = false
    @State private var newFriendEmail = ""
    @State private var showError = false

    var body: some View {
        ZStack {

            // Background matching your app
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                    }

                    Text("Friends")
                        .font(.title2)
                        .foregroundColor(.white)

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
                    if newFriendEmail.isEmpty {
                        showError = true
                        return
                    }
                    friends.append(newFriendEmail.lowercased())
                    newFriendEmail = ""
                    showAddFriend = false
                }
            )
        }
        .alert("Please enter an email", isPresented: $showError) {
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

