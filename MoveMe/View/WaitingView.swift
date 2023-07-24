//
//  WaitingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import SwiftUI

struct WaitingView: View {
    @ObservedObject var viewModel = WaitingViewModel()
    @AppStorage(Constant.alarmStatus) private var alarmStatus = Constant.waiting
    
    var body: some View {
        waiting
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
    }
}

private extension WaitingView {
    var waiting: some View {
        VStack {
            Spacer()
            Text("\(Date().koreanDateForm)")
                .style(.body3_Regular)

            if (alarmStatus == Constant.changed) {
                Text("\(viewModel.scheduledHour) : \(viewModel.scheduledMinute)")
                    .font(.custom(Constant.pretendardBold, size: 48))
                    .padding(.bottom, 50)
            } else {
                Text("\(viewModel.originalHour) : \(viewModel.originalMinute)")
                    .font(.custom(Constant.pretendardBold, size: 48))
                    .padding(.bottom, 50)
            }
            
            Text("알람을 기다리는 중이에요...")
                .style(.body3_Regular)
                .padding(.bottom, 5)
            
            TimelineView(.periodic(from: .now, by: 1)) { _ in
                HStack {
                    Spacer()
                    Text(viewModel.nextAlarm, style: .timer)
                        .style(.heading1_Bold, .mainNavy)
                    Spacer()
                }
            }
            
            Spacer()
        }
    }
}
