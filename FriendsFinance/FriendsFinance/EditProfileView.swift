import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var name: String
    @Binding var email: String

    @State private var updatedName = ""
    @State private var updatedEmail = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $updatedName)
                }

                Section(header: Text("Email")) {
                    TextField("Enter email", text: $updatedEmail)
                        .textInputAutocapitalization(.never)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        name = updatedName
                        email = updatedEmail
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                updatedName = name
                updatedEmail = email
            }
        }
    }
}


struct EditProfileView_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var name = "Jane Doe"
        @State private var email = "jane@example.com"

        var body: some View {
            NavigationStack {
                EditProfileView(name: $name, email: $email)
            }
        }
    }

    static var previews: some View {
        PreviewContainer()
    }
}
