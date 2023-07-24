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
            Text("오늘도 못갔네")
                .style(.body1_Bold, .mainGray)
            Text("귀찮아")
                .style(.body1_Bold, .mainGray)
            Text("내일 해야지")
                .style(.body1_Bold, .mainGray)
            Text("비가 와서 나가기 싫어")
                .style(.body1_Bold, .mainGray)
                .padding(.bottom)

            Text("실패는 이제 그만")
                .style(.heading3_Bold, .mainBlue)
                .padding(.bottom, 5)
            Text("뭅미는 여러분을 움직이게 만듭니다")
                .style(.body1_Bold)
                .padding(.bottom, 40)
        }
    }
}

