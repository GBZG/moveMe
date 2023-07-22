//
//  PairView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI

struct PairView: View {
    var leftText: String
    var rightText: String
    
    init(leftText: String, rightText: String) {
        self.leftText = leftText
        self.rightText = rightText
    }
    
    var body: some View {
        HStack {
            Text(leftText)
            Spacer()
            Text(rightText)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 2)
    }
}
