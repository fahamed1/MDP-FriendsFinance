import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {

            // TAB 1 — HOME DASHBOARD
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // TAB 2 — UPLOAD RECEIPT
            NavigationStack {
                UploadReceiptImageView()
            }
            .tabItem {
                Image(systemName: "camera.fill")
                Text("Upload")
            }

            // TAB 3 — FRIENDS LIST
            NavigationStack {
                FriendsView()
            }
            .tabItem {
                Image(systemName: "person.2.fill")
                Text("Friends")
            }

            // TAB 4 — PROFILE / SETTINGS
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Profile")
            }
        }
        .accentColor(.green)  // highlights selected tab
        .navigationBarBackButtonHidden(true)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
