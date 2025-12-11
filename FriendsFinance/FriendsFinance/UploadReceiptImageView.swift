
import SwiftUI
import PhotosUI

struct UploadReceiptImageView: View {
    
    @State private var receiptImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        ZStack {
            Color(red: 0.75, green: 0.85, blue: 0.90).ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Upload Receipt")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // MARK: Receipt Preview Box
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.3))
