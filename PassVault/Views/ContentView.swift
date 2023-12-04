import SwiftUI
import CoreData
import LocalAuthentication

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var account: FetchedResults<Account>
    
    @State private var showingAddView = false
    @State private var unlocked = false
    @State private var text = "LOCKED"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(account) { account in
                        NavigationLink(destination: AccountView(account: account)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(account.name!)
                                        .bold()
                                        .foregroundColor(.red)
                                        .font(.system(size: 15))
                                    
                                    Text(String(repeating: "•", count: account.username?.count ?? 0))
                                    
                                    Text(String(repeating: "•", count: account.password?.count ?? 0))
                                }
                            }
                            .onTapGesture {
                                authenticate { success in
                                    // If authenticated, navigate to the AccountView
                                    if success {
                                        // You may perform additional actions if needed
                                    }   // I still ned to change this because im not sure if faceid is working
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteAccount)
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Account", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image("padlock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                        Text("Accounts")
                            .foregroundColor(.blue)
                            .font(.system(size: 22))
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddAccountView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    // Deletes account at the current offset
    private func deleteAccount(offsets: IndexSet) {
        withAnimation {
            offsets.map { account[$0] }
                .forEach(managedObjContext.delete)
            
            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
    
    func authenticate(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Security") { success, authenticationError in
                
                if success {
                    text = "UNLOCKED"
                    completion(true)
                } else {
                    text = "There was a problem"
                    completion(false)
                }
            }
        } else {
            text = "Phone does not have biometrics"
            completion(false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

