//
//  EruditTextField.swift
//  Erudite
//
//  Created by Дмитрий on 19.11.2022.
//

import SwiftUI

struct EruditTextField: View {
    
    @State var word: Binding<String>
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: word)
            .font(.title2)
            .padding()
            .background(.white)
            .cornerRadius(18)
    }
}

