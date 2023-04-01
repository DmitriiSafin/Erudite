//
//  ContentView.swift
//  Erudite
//
//  Created by Дмитрий on 19.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var startWord = ""
    @State var playerOne = ""
    @State var playerTwo = ""
    
    @State var isShowedGame = false
    @State var isAlertPresented = false
    
    var body: some View {
        
        VStack {
            TextTitle(text: "Erudit")
            
            EruditTextField(word: $startWord, placeholder: "Введите слово")
                .padding(20)
                .padding(.top, 30)
            
            EruditTextField(word: $playerOne, placeholder: "Игрок 1")
                .padding(.horizontal, 20)
            
            EruditTextField(word: $playerTwo, placeholder: "Игрок 2")
                .padding(.horizontal, 20)
            
            Button {
                
                if startWord.count > 6 {
                    isShowedGame.toggle()
                } else {
                    isAlertPresented.toggle()
                }
                
            } label: {
                Text("Start")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 50)
                    
                    .background(Color("SecondPlayer"))
                    .cornerRadius(30)
                
            }
        } .background(Image("Balda2"))
            .alert("Слово слишком короткое!",
                   isPresented: $isAlertPresented,
                   actions: {
                Text("Ok!")
            })
            
            .fullScreenCover(isPresented: $isShowedGame) {
                
                let name1 = playerOne == "" ? "Игрок 1" : playerOne
                let name2 = playerTwo == "" ? "Игрок 2" : playerTwo
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)
                
                let gameViewModel = GameViewModel(player1: player1, player2: player2, word: startWord)
                
                GameView(viewModel: gameViewModel)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
