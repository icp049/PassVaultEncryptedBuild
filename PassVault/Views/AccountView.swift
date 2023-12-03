import SwiftUI

struct AccountView: View {
    @State private var showingEditView = false
    @State private var revealCredentials = false
    @Environment(\.presentationMode) var presentationMode

    let account: Account

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue).opacity(0.4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 0)
                    )
                    .frame(height: min(geometry.size.height - 40, 300))
                    .padding()

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
                                    .animation(.easeInOut(duration: 0.5)) // Add animation for smooth reveal
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
                            Text(calcTimeSince(date: account.date!))
                                .foregroundColor(.gray)
                                .font(.system(size: 10))
                        }
                        .padding()
                        
                        VStack{
                            Button("Decrypt") {
                                withAnimation {
                                    revealCredentials.toggle()
                                }
                            }
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.bottom, 20)
                            .padding(.trailing, 20)
                            .opacity(revealCredentials ? 0 : 1) // Hide the button after revealing credentials
                        }
                        .padding(.leading, 65)
                    }
                }
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

    func getRandomizedText() -> String {
        let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var randomizedText = ""

        for _ in 0..<15 {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomizedText.append(randomCharacter)
        }

        return randomizedText
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

