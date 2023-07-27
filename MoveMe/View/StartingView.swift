//
//  StartingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI

struct StartingView: View {
    @EnvironmentObject private var manager: LocationManager
    @ObservedObject private var viewModel = StartingViewModel()
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
        .onAppear { viewModel.onAppear() }
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
            Spacer()

            Text("이제는 나도 갓생 마스터!")
                .style(.heading3_Bold, .mainBlue)
                .padding(.bottom, 10)
            Text("원하는 장소에서 알람을 설정해보세요\n반드시 도착할 수 있게 도와드릴게요")
                .style(.body2_Bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
            
            Text("잠깐!")
                .style(.body3_Medium, .mainRed)
                .padding(.bottom, 8)
            
            Text("뭅미는 위치 정보를 기억하는 알람이에요\n서비스 제공을 위해 여러분의 동의가 필요해요")
                .style(.body3_Medium)
                .multilineTextAlignment(.center)
                .lineSpacing(2.0)
                .padding(.bottom, 8)

            Text("아래 버튼을 눌러 설정을 완료하세요")
                .style(.body3_Medium)
            
            Spacer()
            Text("위치 사용, 알림 허용하기")
                .style(.caption, .gray)
            CustomButton(text: "알겠어요!") {
                viewModel.didTapAccessButton(manager)
            }
            .padding(.bottom)
        }
    }
    var initialSettingView: some View {
        InitialAlarmSettingView()
    }
}
