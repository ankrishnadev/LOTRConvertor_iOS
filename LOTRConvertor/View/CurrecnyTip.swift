//
//  CurrecnyToolTip.swift
//  LOTRConvertor
//
//  Created by Krishnan Singaram on 29/12/24.
//


import TipKit

struct CurrecnyTip: Tip {
    var title = Text("Change Currency")
    var message: Text? = Text("You can tap left or right currency to bring up the Selecte Currency screen.")
    var image: Image? = Image(.goldpenny)
}
