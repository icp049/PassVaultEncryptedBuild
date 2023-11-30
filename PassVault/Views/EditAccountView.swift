import SwiftUI

struct EditAccountView: View {

    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss

    var account: FetchedResults<Account>.Element

    @State private var name = ""
    @State private var password = ""



var body: some View {

    Form{
        Section {
            TextField ("\(account.name!)", text: $name)

             TextField ("\(account.password!)", text: $password)
            .onAppear{
                name = account.name!
                password = account.password!
            }

            HStack{
                Spacer()
                  Button("Submit"){
                    DataController().editAccount(account: account, name: name, password: password,
                    context: managedObjContext)
                    dismiss()
                  }
                Spacer()
            }
        }
    }

}

}
