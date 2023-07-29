//
//  AlarmView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI

struct AlarmView: View {
    @StateObject private var viewModel = AlarmViewModel()
    @AppStorage(Constant.alarmStatus) private var alarmStatus = Constant.waiting
    @State private var isSettingButtonTapped = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header
                googleAd
                Spacer()
                bodyView
                Spacer()
                NavigationLink("", isActive: $isSettingButtonTapped) {
                    SettingView()
                }
            }
        }
        .onAppear { viewModel.onAppear() }
    }
}

private extension AlarmView {
    var header: some View {
        HStack {
            Spacer()
            Button {
                isSettingButtonTapped.toggle()
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.mainWhite)
            }
        }
        .padding()
        .background(Color.mainBlue)
    }
    
    var googleAd: some View {
        AdView()
    }
    
    @ViewBuilder
    var bodyView: some View {
        switch alarmStatus {
        case Constant.active: RingingView()
        case Constant.waiting: WaitingView()
        default:
            WaitingView()
        }
    }
}
