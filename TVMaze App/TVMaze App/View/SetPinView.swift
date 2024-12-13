//
//  SetPinView.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 13/12/24.
//

import SwiftUI

struct SetPinView: View {
    @State private var enteredPin: String = ""
    @Binding private var isPinSet: Bool
    @Binding private var isAuthenticated: Bool
    @State private var showError: Bool = false
    
    public init(isPinSet: Binding<Bool>, isAuthenticated: Binding<Bool>) {
        self._isPinSet = isPinSet
        self._isAuthenticated = isAuthenticated
    }
    
    var body: some View {
        VStack {
            Text(getTitle())
                .font(.headline)
                .padding()
            
            SecureField("PIN", text: $enteredPin)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding()
                .frame(width: 120, height: 50)
                .border(Color.gray, width: 1)
            
            VStack {
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(1..<4) { column in
                            let number = row * 3 + column
                            Button(action: {
                                appendNumber(number)
                            }) {
                                Text("\(number)")
                                    .font(.largeTitle)
                                    .frame(width: 70, height: 70)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(35)
                            }
                        }
                    }
                }
                HStack {
                    
                    Button(action: {
                        
                        appendNumber(0)
                    }) {
                        Text("0")
                            .font(.largeTitle)
                            .frame(width: 70, height: 70, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(35)
                    }.frame(alignment: .center)
                    
                    
                    Button(action: {
                        clearPin()
                    }) {
                        Text("Clear")
                            .frame(width: 70, height: 70)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(35)
                    }
                }
            }
            .padding()
            Button("Submit") {
                isPinSet ? validatePin() : savePin()
            }
            .padding()
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"), message: Text("Invalid PIN"), dismissButton:
                    .default(Text("OK")))
        }
    }
    
    private func getTitle() -> String {
        isPinSet ? "Enter you PIN" : "Set you PIN"
    }
    
    private func appendNumber(_ number: Int) {
        if enteredPin.count < 4 {
            enteredPin.append("\(number)")
        }
    }
    
    private func clearPin() {
        enteredPin = ""
        
    }
    
    private func savePin() {
        if enteredPin.count == 4 {
            KeychainHelper.save(key: KeychainKeys.userPIN.rawValue, data: enteredPin)
            isPinSet = true
            isAuthenticated = true
        } else {
            showError = true
        }
    }
    
    private func validatePin() {
        if enteredPin == KeychainHelper.load(key: KeychainKeys.userPIN.rawValue) {
            isAuthenticated = true
        } else {
            showError = true
        }
    }
}

#Preview {
    SetPinView(isPinSet: .constant(false), isAuthenticated: .constant(false))
}
