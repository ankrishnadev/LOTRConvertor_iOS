//
//  ContentView.swift
//  LOTRConvertor
//
//  Created by Krishnan Singaram on 27/12/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchagneInfo = false
    @State var showSelectCurrency = false
    @State var leftAmount = ""
    @State var rightAmont = ""
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    let currencyTip = CurrecnyTip()
    
    var body: some View {
        ZStack {
            // Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height:200)
                
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                HStack {
                    
                    VStack {
                         
                        HStack {
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:32)
                            
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }.onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        //Text field
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)   
                    }
                    
                    Image (systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    VStack {
                         
                        HStack {
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:32)
                        }.onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        //Text field
                        TextField("Amount", text: $rightAmont)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                    }
                
                }
                .padding()
                .background(.black.opacity(0.4))
                
                Spacer()
                
                //Info button
                HStack {
                    Spacer()
                    Button {
                        showExchagneInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
                
            }
        
        }
        .hideKeyboardIfShown()
        .task {
            try? Tips.configure()
        }
        .keyboardType(.decimalPad)
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmont = leftCurrency.convert(amountString: leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmont) {
            if rightTyping {
                leftAmount = rightCurrency.convert(amountString: rightAmont,to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency){
            leftAmount = rightCurrency.convert(amountString: rightAmont,to: leftCurrency)
        }
        .onChange(of: rightCurrency){
            rightAmont = leftCurrency.convert(amountString: leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchagneInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(
                topCurrency: $leftCurrency,
                bottomCurrency: $rightCurrency
            )
        }
    }
}

extension View {
    func hideKeyboardIfShown() -> some View{
        self.onTapGesture {
            UIApplication.shared
                .sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
        }
    }
}

#Preview {
    ContentView()
}
