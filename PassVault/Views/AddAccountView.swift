import SwiftUI

struct AddAccountView: View {
   
   @Environment (\.managedObjectContext) var managedObjectContext
   @Environment(\.dismiss) var dismiss

   @State private var name = ""
   @State private var password = ""




    var body: some View {
              Form{
                Section {
                    TextField("Account Name:", text: $name)

                    VStack{
                        TextField("Password:", text: $password)
                    }
                }
              }
    }
}

struct AddAccountView_Previews: PreviewProvider{
    static var previews: some View {
        AddAccountView()
    }
}

