//
//  EditFoodView.swift
//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
//

import SwiftUI

struct EditAccountView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var account: FetchedResults<Account>.Element
    
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""
    
    
    var body: some View {
        Form {
            Section() {
                TextField("\(account.name!)", text: $name)
                
                TextField("\(account.username!)", text: $username)
                
                TextField("\(account.password!)", text: $password)
                    .onAppear {
                        name = account.name!
                        username = account.username!
                        password = account.password!
                        
                    }
               
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editAccount(account: account, name: name, username: username, password: password, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
