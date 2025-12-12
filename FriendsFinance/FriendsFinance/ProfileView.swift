import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var userVM: UserViewModel

    @State private var showEditProfile = false
    @State private var showImagePicker = false
    @State private var selectedImage: PhotosPickerItem?

    var body: some View {
        ZStack {
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                Text("Profile")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                Spacer()

                // Profile Image
                Button { showImagePicker = true } label: {
                    if let img = userVM.profileImage {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
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

                Text("Name: \(userVM.name)")
                    .foregroundColor(.white)
                    .font(.title3)

                Text("Email: \(userVM.email)")
                    .foregroundColor(.white.opacity(0.9))

                Button("Edit Profile") {
                    showEditProfile = true
                }
                .foregroundColor(.black)
                .padding()
                .background(.white.opacity(0.8))
                .cornerRadius(10)

                Spacer()
            }
        }
        .sheet(isPresented: $showEditProfile) {
            EditProfileView(name: $userVM.name, email: $userVM.email)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
                .environmentObject(UserViewModel())
        }
    }
}




