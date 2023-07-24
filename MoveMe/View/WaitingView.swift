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
    }
}

private extension WaitingView {
    var waiting: some View {
        VStack {
            Text("알람을 기다리는 중이에요...")
                .padding(.bottom, 10)
            
            if (alarmStatus == Constant.changed) {
                Text("\(viewModel.scheduledHour):\(viewModel.scheduledMinute)")
                    .style(.heading1_Bold)
                    .padding(.bottom, 10)
            } else {
                Text("\(viewModel.originalHour):\(viewModel.originalMinute)")
                    .style(.heading1_Bold)
                    .padding(.bottom, 10)
            }
        }
    }
}
