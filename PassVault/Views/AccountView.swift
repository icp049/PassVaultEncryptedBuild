import SwiftUI

struct AccountView: View {
    @State private var showingEditView = false
    
    let account: Account
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
            Text("Name: \(account.name ?? "")")
            Text("Username: \(account.username ?? "")")
            Text("Password: \(account.password ?? "")")
            Text(calcTimeSince(date: account.date!))
                .foregroundColor(.gray)
                .italic()
            
            
        
        }
        }
       
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditView.toggle()
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            EditAccountView(account: account)
        }
    }
}






