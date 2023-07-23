//
//  GreetingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI
import GoogleMobileAds

struct GreetingView: View {
    
    var body: some View {
        VStack {            
            Text("환영합니다")
                .style(.heading1_Bold)
                .padding(.bottom, 10)
            
            Text("실천하는 습관 만들기\n뭅미를 시작합니다.")
                .style()
                .multilineTextAlignment(.center)
        }
    }
}
