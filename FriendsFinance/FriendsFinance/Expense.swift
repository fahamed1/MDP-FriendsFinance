
import SwiftUI

struct Expense: Identifiable {
    let id = UUID()
    var title: String
    var payer: String
    var youOwe: Double
    var date: String
    var imageName: String  // receipt thumbnail
}

struct HomeView: View {
    
    @State private var totalPending: Double = 149.89
    @State private var percentageChange: Double = 12.3
    
    // MOCK DATA — replace with Firebase later
    @State private var expenses = [
        Expense(title: "McDonald's", payer: "Farhat", youOwe: 8.12, date: "Dec 8", imageName: "receipt1"),
        Expense(title: "Starbucks", payer: "Mehera", youOwe: -4.50, date: "Dec 6", imageName: "receipt2"),
        Expense(title: "Chipotle", payer: "Mehera", youOwe: 12.33, date: "Dec 3", imageName: "receipt3")
    ]
    
    var body: some View {
        ZStack {
            Color(red: 0.75, green: 0.85, blue: 0.90)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                // MARK: HEADER CARD
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Pending")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text("$\(totalPending, specifier: "%.2f")")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("+\(percentageChange, specifier: "%.1f")%")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.top, 20)
                
                // MARK: RECENT EXPENSES
                Text("Recent Expenses")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(expenses) { expense in
                            NavigationLink(destination: ExpenseDetailView(expense: expense)) {
                                ExpenseRow(expense: expense)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // MARK: ADD EXPENSE BUTTON
                
                NavigationLink(destination: UploadReceiptView()) {
                    Text("+ Add Expense")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

// MARK: Expense Row View
struct ExpenseRow: View {
    var expense: Expense
    
    var body: some View {
        HStack {
            
            // Receipt Thumbnail
            Image(expense.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading) {
                Text(expense.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Paid by: \(expense.payer)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                if expense.youOwe >= 0 {
                    Text("You owe: $\(expense.youOwe, specifier: "%.2f")")
                        .foregroundColor(.red)
                } else {
                    Text("They owe you: $\(abs(expense.youOwe), specifier: "%.2f")")
                        .foregroundColor(.green)
                }
                
                Text(expense.date)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
}


// MARK: Detail Page Placeholder
struct ExpenseDetailView: View {
    var expense: Expense
    
    var body: some View {
        Text("Detail view for \(expense.title)")
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
