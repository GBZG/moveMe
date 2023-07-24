//
//  StartingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI

struct StartingView: View {
    @State private var selection: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            progressBar
            TabView(selection: $selection) {
                greetingView.tag(1)
                introView.tag(2)
                initialSettingView.tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

private extension StartingView {
    var progressBar: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 3)
                .foregroundColor(.white)
            withAnimation(.default) {
                Rectangle()
                    .frame(width: Constant.screenWidth * (CGFloat(selection) / 3), height: 3)
                    .foregroundColor(.mainBlue)
            }
        }
    }
    var greetingView: some View {
        GreetingView()
    }
    var introView: some View {
        VStack {
            Text("이제는 나도 갓생 마스터!")
                .style(.heading3_Bold, .mainBlue)
                .padding(.bottom, 10)
            Text("원하는 장소에서 알람을 설정해보세요\n반드시 도착할 수 있게 도와드릴게요")
                .style(.body2_Bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
        }
    }
    var initialSettingView: some View {
        InitialAlarmSettingView()
    }
}
