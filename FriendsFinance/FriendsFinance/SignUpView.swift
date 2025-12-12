import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Back button + Title
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    
                    Text("Sign Up")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.4))
                    .padding(.horizontal)
                
                Spacer()
                
                // Logo
                Image("FFLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Text("Create Your Account")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                // Input Fields
                VStack(spacing: 16) {
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 40)
                
                // Create Account Button
                Button(action: createAccount) {
                    Text("Create Account")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color(red: 0.35, green: 0.40, blue: 0.45))
                        .cornerRadius(25)
                }
                .padding(.top, 10)
                
                // Error message
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true) 
    }
    
    // MARK: - Functions
    
    func createAccount() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill out all fields."
            showError = true
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
                return
            }

            let db = Firestore.firestore()
            db.collection("users").document(result!.user.uid).setData([
                "name": name,
                "email": email.lowercased()
            ]) { err in
                if let err = err {
                    print("Error saving user: \(err)")
                } else {
                    print("User saved in Firestore")
                }
            }

            dismiss() // Back to login screen
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView()
        }
    }
}

