//
//  AlarmView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject private var viewModel = AlarmViewModel()
    @AppStorage(Constant.alarmStatus) private var alarmStatus = Constant.waiting
    @State private var isSettingButtonTapped = false
    
    var body: some View {
        NavigationView {
            VStack {
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
        .onAppear { viewModel.onAppear(alarmStatus) }
        .onDisappear { viewModel.onDisappear() }
        .onChange(of: alarmStatus) { newValue in
            viewModel.onAppear(newValue)
        }
    }
}

private extension AlarmView {
    var header: some View {
        HStack {
            if (alarmStatus != Constant.changed) {
                TimelineView(.periodic(from: .now, by: 1)) { _ in
                    Text(viewModel.nextAlarm, style: .timer)
                        .style(.body2_Bold, Date() >= viewModel.nextAlarm ? .mainRed : .mainNavy)
                }
            }
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
    
    var googleAd: some View {
        AdView()
    }
    
    @ViewBuilder
    var bodyView: some View {
        switch alarmStatus {
        case Constant.active: RingingView()
        case Constant.waiting: ChangeView()
        case Constant.completed: CompletionView()
        case Constant.changed: WaitingView()
        default:
            ChangeView()
        }
    }
}
