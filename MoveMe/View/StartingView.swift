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

            Text("StartingViewTitle".localized())
                .style(.heading3_Bold, .mainBlue)
                .padding(.bottom, 10)
            Text("StartingViewExplanation".localized())
                .style(.body2_Bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
            
            Text("StartingViewFYITitle".localized())
                .style(.body3_Medium, .mainRed)
                .padding(.bottom, 8)
            
            Text("StartingViewFYIDescription".localized())
                .style(.body3_Medium)
                .multilineTextAlignment(.center)
                .lineSpacing(2.0)
                .padding(.bottom, 8)

            Text("StartingViewSettingGuide".localized())
                .style(.body3_Medium)
            
            Spacer()
            Text("StartingViewButtonDescription".localized())
                .style(.caption, .gray)
            CustomButton(text: "StartingViewButtonLabel".localized()) {
                viewModel.didTapAccessButton(manager)
            }
            .padding(.bottom)
        }
    }
    var initialSettingView: some View {
        InitialAlarmSettingView()
    }
}
