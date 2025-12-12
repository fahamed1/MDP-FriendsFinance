
import SwiftUI
import LocalAuthentication
import FirebaseAuth


struct SignInView: View {

    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var faceIDAvailable = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    @State private var isLoggedIn = false

    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // Back + Title
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                    }

                    Text("Sign In")
                        .font(.title2)
                        .foregroundColor(.white)

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

                Text("Friends Finance")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                // Textfields
                VStack(spacing: 16) {

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

                // Face ID Button
                if faceIDAvailable {
                    Button {
                        startFaceIDLogin()
                    } label: {
                        HStack {
                            Image(systemName: "faceid")
                            Text("Sign in with Face ID")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    }
                }
                
                Button(action: {
                    signIn()
                }) {
                    Text("Sign In")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color(red: 0.35, green: 0.40, blue: 0.45))
                        .cornerRadius(25)
                }
                
                .padding(.top, 10)

                // Forgot password
                Button(action: resetPassword) {
                    Text("Forgot Your Password?")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 16))
                        .padding(.top, 20)
                }

                .navigationDestination(isPresented: $isLoggedIn) {
                        MainTabView()
                }
                
                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.white)
                }

                Spacer()
            }
            .alert(errorMessage, isPresented: $showError) {
                Button("OK", role: .cancel) { }
            }


            // Error Alert
//            if showError {
//                VStack {
//                    Text(errorMessage)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//            }
        }
        .onAppear(perform: checkFaceID)
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - FUNCTIONS

    func checkFaceID() {
        let context = LAContext()
        faceIDAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }

    func startFaceIDLogin() {
        FaceIDManager.shared.authenticate { success, error in
            if success {
                print("Face ID Success → Continue to Home Screen")
            } else {
                showError = true
                errorMessage = "Face ID failed. Try again."
            }
        }
    }

    func resetPassword() {
        guard !email.isEmpty else {
            showError = true
            errorMessage = "Please enter your email."
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                showError = true
                errorMessage = error.localizedDescription
            } else {
                showError = false
                errorMessage = "Password reset link sent to \(email)."
            }
        }
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
                    errorMessage = "Please enter both email and password."
                    showError = true
                    return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
                email = ""
                password = ""
                return
            }

            print("Logged in:", result?.user.email ?? "")
            isLoggedIn = true
        }
    }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView()
        }
    }
}
