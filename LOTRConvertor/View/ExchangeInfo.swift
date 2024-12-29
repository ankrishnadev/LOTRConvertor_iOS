//
//  ExchangeInfo.swift
//  LOTRConvertor
//
//  Created by Krishnan Singaram on 27/12/24.
//

import SwiftUI

struct ExchangeInfo: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Exchagne")
                    .font(.largeTitle)
                    .tracking(3)
                
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title3)
                    .padding()
                
                ExtractedView(
                    leftImage: .goldpiece, rightImage: .goldpenny, 
                    label: "1 Gold Piece = 4 Gold Pennies"
                )
                ExtractedView(
                    leftImage: .goldpenny, rightImage: .silverpiece,
                    label: "1 Gold Penny = 4 Silver Pieces"
                )
                ExtractedView(
                    leftImage: .silverpiece, rightImage: .silverpenny,
                    label: "1 Silver Piece = 4 Silver Pennies"
                )
                ExtractedView(
                    leftImage: .silverpenny, rightImage: .copperpenny,
                    label: "1 Silver Penny = 100 Copper Pennies"
                )
                
                Button("Done"){
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .font(.title3)
                .padding()
                .tint(.brown.mix(with: .black, by: 0.2))
                .foregroundStyle(.white)
            }
            
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    ExchangeInfo()
}

struct ExtractedView: View {
    
    let leftImage: ImageResource
    let rightImage: ImageResource
    let label: String
    
    var body: some View {
        HStack {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 32)
            
            Text(label)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 32)
        }
    }
}
