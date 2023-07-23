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
            Text("아.. 오늘도 안갔네..")
                .style(.heading1_Bold)
                .padding(.bottom)
            Text("뭅미(MoveMe)는 헬스장, 독서실 등 매일 가기로 약속한 장소에 갈 수 있도록 돕는 습관 형성 서비스예요.")
                .style()
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 30)
                .padding(.bottom, 10)
            Text("뭅미와 함께 실천하는 습관을 만들어보세요.")
                .style()
        }
    }
    var initialSettingView: some View {
        InitialAlarmSettingView()
    }
}
