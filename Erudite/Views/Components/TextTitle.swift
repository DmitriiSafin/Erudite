

import SwiftUI

struct TextTitle: View {
    
    @State var text = ""
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("AvenirNext-Bold", size: 42))
            .frame(maxWidth: .infinity)
            .background(Color("FirstPlayer"))
            .foregroundColor(.white)
    }
}

struct TextTitle_Previews: PreviewProvider {
    static var previews: some View {
        TextTitle(text: "text")
    }
}
