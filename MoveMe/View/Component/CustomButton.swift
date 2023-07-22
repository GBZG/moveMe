//
//  CustomButton.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let text: String

    init(text: String, action: @escaping () -> Void) {
        self.action = action
        self.text = text
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.body)
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .padding(.horizontal, 100)
                .background(.purple)
                .cornerRadius(12)
            }
    }
}
