//
//  ContentView.swift
//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var account: FetchedResults<Account>
    
    @State private var showingAddView = false
    
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
                                    
                                    Text(String(repeating: "•", count: account.username?.count ?? 0))
                                    
                                    
                                    Text(String(repeating: "•", count: account.password?.count ?? 0))
                                 
                                    
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
                                   Text("Accounts")
                                       .font(.headline)
                                       .foregroundColor(.blue)
                               }
            }
            .sheet(isPresented: $showingAddView) {
                AddAccountView()
            }
          
        }
      
        .navigationViewStyle(.stack)
       
    }
    
    // Deletes food at the current offset
    private func deleteAccount(offsets: IndexSet) {
        withAnimation {
            offsets.map { account[$0] }
                .forEach(managedObjContext.delete)
            
            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
