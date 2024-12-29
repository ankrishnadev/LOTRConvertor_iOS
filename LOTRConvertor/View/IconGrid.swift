//
//  IconGrid.swift
//  LOTRConvertor
//
//  Created by Krishnan Singaram on 28/12/24.
//

import SwiftUI

struct IconGrid: View {
    
    @Binding var currency: Currency
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(Currency.allCases){ item in
                if self.currency == item {
                    CurrencyIcon( currencyImage: item.image,
                                  currencyName: item.name)
                        .shadow(color:.black, radius: 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                        }
                } else {
                    CurrencyIcon( currencyImage: item.image, currencyName: item.name)
                        .onTapGesture {
                            self.currency = item
                        }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var currency : Currency = .silverPenny
    IconGrid(currency: $currency)
}
