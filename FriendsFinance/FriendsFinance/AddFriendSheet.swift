import SwiftUI

struct AddFriendEmailSheet: View {

    @Binding var newFriendEmail: String
    var onAdd: () -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                TextField("Friend's Email Address", text: $newFriendEmail)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)

                Button(action: onAdd) {
                    Text("Add Friend")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
