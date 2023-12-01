//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
//

import SwiftUI

struct AddAccountView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    

    @State private var name = ""
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
            Form {
                Section() {
                    TextField("Account", text: $name)
                    
                    TextField("Username", text: $username)
                    
                    
                    TextField("Password", text: $password)
                    
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController().addAccount(
                                name: name,
                                username: username,
                                password: password,
                                context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView()
    }
}
