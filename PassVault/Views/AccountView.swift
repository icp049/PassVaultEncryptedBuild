import SwiftUI

struct AccountView: View {
    @State private var showingEditView = false
    @Environment(\.presentationMode) var presentationMode

    let account: Account

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Name: \(account.name ?? "")")
                Text("Username: \(account.username ?? "")")
                Text("Password: \(account.password ?? "")")
                Text(calcTimeSince(date: account.date!))
                    .foregroundColor(.gray)
                    .italic()
            }
        }
        .navigationBarTitle(account.name ?? "", displayMode: .inline) // Set account name as title
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .navigationBarItems(leading: BackButton { presentationMode.wrappedValue.dismiss() }) // Navigate back when clicked

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

struct BackButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .background(Color.clear)
        }
    }
}

