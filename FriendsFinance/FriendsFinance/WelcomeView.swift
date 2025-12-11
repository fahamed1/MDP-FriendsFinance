
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()

            VStack(spacing: 40) {

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 120, height: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frame(width: 60)
                    )
                    .padding(.top, 40)

                Spacer()

                Image("FFLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 25))

                Text("Friends Finance")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.white)

                VStack(spacing: 6) {
                    Text("Welcome to Friends Finance")
                        .font(.system(size: 18))
                        .foregroundColor(.white)

                    Text("Do not forget to pay\nyour friends back!")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.9))
                }

                Spacer()

                NavigationLink(destination: SignInView()) {
                    Text("GET STARTED")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(red: 0.10, green: 0.35, blue: 0.40))
                        .frame(width: 200, height: 50)
                        .background(Color(red: 0.95, green: 0.96, blue: 0.88))
                        .cornerRadius(25)
                }

                Spacer()
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WelcomeView()
        }
    }
}
