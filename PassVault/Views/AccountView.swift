import SwiftUI
import LocalAuthentication

struct AccountView: View {
    @State private var showingEditView = false
    @State private var revealCredentials = false
    @Environment(\.presentationMode) var presentationMode

    @State private var unlocked = false
    @State private var text = "LOCKED"

    let account: Account

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        Image("document")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)

                        Text(revealCredentials ? "\(account.username ?? "Not Available")" : getRandomizedText())
                            .italic()
                            .foregroundColor(.gray)
                            .animation(.easeInOut(duration: 0.5))
                    }
                }
                .padding()

                VStack {
                    HStack {
                        Image("key")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Text(revealCredentials ? "\(account.password ?? "Not Available")" : getRandomizedText())
                            .italic()
                            .foregroundColor(.gray)
                            .animation(.easeInOut(duration: 0.5))
                    }
                }
                .padding()

                VStack {
                    Button("Decrypt") {
                        authenticateWithFaceID { success in
                            if success {
                                withAnimation {
                                    revealCredentials.toggle()
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                    .opacity(revealCredentials ? 0 : 1)
                }
                .padding(.leading, 65)
            }
        }
        .navigationBarTitle(account.name ?? "", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton { presentationMode.wrappedValue.dismiss() })
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

    func authenticateWithFaceID(completion: @escaping (Bool) -> Void) {
        authenticate { success in
            if success {
                completion(true)
            } else {
                // Handle authentication failure, if needed
                completion(false)
            }
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

    func getRandomizedText() -> String {
        return "********************"
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
}

