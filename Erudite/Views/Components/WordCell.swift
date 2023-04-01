//
//  WordCell.swift
//  Erudite
//
//  Created by Дмитрий on 25.11.2022.
//

import SwiftUI

struct WordCell: View {
    
    let word: String
    
    var body: some View {
        
        HStack {
            Text(word)
                .foregroundColor(Color.white)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.system(size: 20))
            
            Text("\(word.count)")
                .padding()
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
        
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "!")
    }
}
