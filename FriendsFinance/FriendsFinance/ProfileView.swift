import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var name = "Meow Meow"
    @State private var email = "meow@gmail.com"
    @State private var profileImage: UIImage? = UIImage(named: "cat") // default
    @State private var showEditProfile = false
    @State private var showImagePicker = false
    @State private var selectedImage: PhotosPickerItem?

    var body: some View {
        ZStack {
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // Title + Divider
                VStack(spacing: 8) {
                    Text("Edit Profile")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.4))
                        .padding(.horizontal)
                }
                .padding(.top, 30)

                Spacer()

                // Profile Image
                Button(action: { showImagePicker = true }) {
                    if let img = profileImage {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            .shadow(radius: 5)
                    } else {
                        Circle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 160, height: 160)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            )
                    }
                }
                .photosPicker(isPresented: $showImagePicker, selection: $selectedImage)
                .onChange(of: selectedImage) {
                    Task {
                        if let data = try? await selectedImage?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            profileImage = uiImage
                        }
                    }
                }

                // Name + Email
                VStack(spacing: 6) {
                    Text("Name: \(name)")
                        .foregroundColor(.white)
                        .font(.title3)

                    Text("Email: \(email)")
                        .foregroundColor(.white.opacity(0.9))
                }

                // Edit Profile Button
                Button(action: { showEditProfile = true }) {
                    Text("Edit Profile")
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 150)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                Spacer()
                Spacer(minLength: 40)
            }
        }
        .sheet(isPresented: $showEditProfile) {
            EditProfileView(name: $name, email: $email)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}




