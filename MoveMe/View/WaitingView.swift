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
    @State private var isSettingButtonTapped = false
    
    var body: some View {
        NavigationView {
            bodyView
        }
    }
}

private extension WaitingView {
    var bodyView: some View {
        VStack {
            header
            Spacer()
            waiting
            Spacer()
            NavigationLink("", isActive: $isSettingButtonTapped) {
                SettingView()
            }
            .navigationBarHidden(true)
        }
    }
    
    var header: some View {
        HStack {
            Spacer()
            Button {
                isSettingButtonTapped.toggle()
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.mainNavy)
            }
        }
        .padding()
    }
    
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
