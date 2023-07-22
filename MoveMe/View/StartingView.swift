//
//  StartingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI
import CoreLocation
import BackgroundTasks

struct StartingView: View {
    @EnvironmentObject private var manager: LocationManager
    @ObservedObject private var viewModel = StartingViewModel()
    @State private var currentDate = Date()
    @State private var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection) {
            introView.tag(1)
            settingView.tag(2)
        }
        .tabViewStyle(.page)
    }
}

private extension StartingView {
    var introView: some View {
        VStack {
            Text("환영합니다")
            Text("뭅미를 시작합니다.")
        }
    }
    var settingView: some View {
        VStack {
            Text("매일 가야 하는 장소에서 알람을 설정해주세요.")
                .padding()
            Text("기본 알람 시간을 설정해주세요.")
            DatePicker("", selection: $currentDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(.wheel)
            
            Text("현재위치")
            TrackingView()
                .padding(.bottom)
            
            // Create Alarm
            CustomButton(text: "설정하기") {
                viewModel.didTapCreateAlarmButton(
                    currentDate: currentDate,
                    latitude: manager.coordinate?.latitude,
                    longitude: manager.coordinate?.longitude
                )
            }
        }
    }
}
