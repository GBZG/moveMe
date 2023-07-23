//
//  Text+.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

extension Text {
    
    /**
     커스텀 폰트 세팅 (Font: Pretendard, Color: Custom)
    */
    func customFontStyle(_ style: Font.Pretendard, _ color: Color = .mainNavy) -> some View {
        self.font(.pretendard(style))
            .foregroundColor(color)
    }
}
