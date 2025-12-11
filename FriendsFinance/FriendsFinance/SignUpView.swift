import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: {dismiss()}) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    
                    Text("Sign Up")
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
                
                Image("FFLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Text("Create Your Account")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                VStack(spacing: 16) {
                    
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Phone Number", text: $phone)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                        .keyboardType(.phonePad)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 40)
                
                Button(action: {
                    // TODO: Handle sign up logic
                    print("Signing up...")
                }) {
                    HStack {
                        Spacer()
                        Text("Create Account")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color(red: 0.35, green: 0.40, blue: 0.45))
                            .cornerRadius(25)
                        Spacer()
                    }
    
                }
                .padding(.top, 10)
                
                Spacer()
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView()
        }
    }
}
