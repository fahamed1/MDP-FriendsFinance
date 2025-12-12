import SwiftUI
import PhotosUI

struct AddExpenseView: View {
    
    // MARK: - Receipt
    @State private var receiptImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    
    // MARK: - Expense Fields
    @State private var storeName: String = ""
    @State private var payer: String = ""
    @State private var totalAmount: String = ""
    
    @State private var date: Date = Date()
    
    @State private var friendsCost: [String: String] = [
        "Mehera": "",
        "Raisa": "",
        "Fizza": "",
        "Farhat": ""
    ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            ZStack {
                Color(red: 0.75, green: 0.85, blue: 0.90).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Text("Add Expense")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // MARK: Upload Receipt Box
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 200)
                        
                        if let img = receiptImage {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        } else {
                            VStack(spacing: 8) {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                                Text("Upload Receipt (Optional)")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    // MARK: Upload Button
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Choose Receipt Image")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                receiptImage = uiImage
                            }
                        }
                    }
                    
                    // MARK: Store Name
                    VStack(alignment: .leading) {
                        Text("Store / Restaurant Name")
                            .foregroundColor(.white)
                        TextField("Ex: Halal Guys", text: $storeName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    
                    // MARK: Who Paid
                    VStack(alignment: .leading) {
                        Text("Who Paid?")
                            .foregroundColor(.white)
                        TextField("Enter name", text: $payer)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    
                    // MARK: Total Amount
                    VStack(alignment: .leading) {
                        Text("Total Amount")
                            .foregroundColor(.white)
                        TextField("$0.00", text: $totalAmount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    
                    // MARK: Date Picker
                    VStack(alignment: .leading) {
                        Text("Date")
                            .foregroundColor(.white)
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                    }
                    .padding(.horizontal)
                    
                    // MARK: Friend Costs
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Individual Costs (Optional)")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ForEach(friendsCost.keys.sorted(), id: \.self) { friend in
                            HStack {
                                Text(friend)
                                    .foregroundColor(.white)
                                TextField("$0.00", text: Binding(
                                    get: { friendsCost[friend] ?? "" },
                                    set: { friendsCost[friend] = $0 }
                                ))
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: Submit Button
                    Button {
                        saveExpense()
                        dismiss()
                    } label: {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: Save Expense Function
    func saveExpense() {
        let newExpense = Expense(
            title: storeName,
            payer: payer,
            youOwe: Double(totalAmount) ?? 0,
            date: formattedDate(date),
            imageName: "" // We'll handle actual saving later
        )
        
        ExpenseManager.shared.addExpense(newExpense)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// TEMP REFERENCE
class ExpenseManager {
    static let shared = ExpenseManager()
    private init() {}
    
    @Published var expenses: [Expense] = []
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }
}

