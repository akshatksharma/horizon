import SwiftUI

struct LoginView: View {
    @State private var handle: String = ""
    @State private var password: String = ""
    
    var onLogin: (String, String) async -> Void

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Username", text: $handle)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("Login") {
                Task {
                    await onLogin(handle, password)
                    self.handle = ""
                    self.password = ""
                }
            }
            .padding(.horizontal, 24)
        }
    }
} 
