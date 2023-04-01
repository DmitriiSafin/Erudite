//
//  GameView.swift
//  Erudite
//
//  Created by Дмитрий on 19.11.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Button {
                    confirmPresent.toggle()
                } label: {
                    Text("Выход")
                        .padding(8)
                        .padding(.horizontal)
                        .background(Color("SecondPlayer"))
                        .cornerRadius(16)
                        .padding(8)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                }
                Spacer()
            }
            
            Text(viewModel.word)
                .padding(6)
                .font(.custom("AvenirNext-Bold", size: 30))
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(Color("FirstPlayer"))
                
            HStack(spacing: 12) {
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                    
                } .padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(30)
                    .shadow(color: viewModel.isFirst ? .red : .clear,
                            radius: 4,
                            x: 0,
                            y: 0)
                
                VStack {
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player2.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                    
                } .padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(30)
                    .shadow(color: viewModel.isFirst ? .clear : .blue,
                            radius: 4,
                            x: 0,
                            y: 0)
            }
            
            EruditTextField(word: $word, placeholder: "Ваше слово...")
                .padding()
            
            Button {
                
                var score = 0
                
                do {
                    try score = viewModel.check(word: word)
                } catch WordError.beforeWord {
                    alertText = "Придумай новое слово"
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "Слишком короткое слово"
                    isAlertPresent.toggle()
                } catch WordError.theSameWord {
                    alertText = "Составленное слово не должно быть исходным словом"
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Слово не может быть составлено"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Неизвестная ошибка"
                    isAlertPresent.toggle()
                }
                
                if score > 1 {
                    self.word = ""
                }
                
            } label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(14)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .padding(.horizontal)
            }
            
            List {
                ForEach(0..<self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                }
                .listRowBackground(Color.clear)
            } .onAppear(perform: {
                UICollectionView.appearance().backgroundColor = .clear
            })
            .listStyle(.plain)
            .frame(maxWidth: .infinity,  maxHeight: .infinity)
            
        } .background(Image("Balda2"))
            .confirmationDialog("Вы уверены, что хотите выйти?",
                                isPresented: $confirmPresent,
                                titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                
                Button(role: .cancel) {
                    
                } label: {
                    Text("Нет")
                }
            }.alert(alertText, isPresented: $isAlertPresent) {
                Text("Ok")
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(
            player1: Player(name: "Игрок 1"),
            player2: Player(name: "Игрок 2"),
            word: "привет"))
    }
}
