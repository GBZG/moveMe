//
//  InitialAlarmSettingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI
import MapKit

struct InitialAlarmSettingView: View {
    @EnvironmentObject private var manager: LocationManager
    @ObservedObject private var viewModel = InitialAlarmSettingViewModel()
    @State private var currentDate = Date()
    @State private var isAlertActive = false
    @State var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var body: some View {
        VStack() {
            map
            alarmSetting
        }
        .onAppear { region = viewModel.onAppear(manager) }
    }
}

private extension InitialAlarmSettingView {
    var map: some View {
        Map(
            coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow)
        )
        .frame(height: 350)
    }
    
    var alarmSetting: some View {
        VStack {
            Text("현재 위치에서 알람을 설정해보세요")
                .style(.heading3_Bold)
                .padding(.top, 10)
                .padding(.bottom, 3)
            Text("알람은 지정된 위치에서 해제 가능합니다.")
                .style(.caption)
                .padding(.bottom)
            
            DatePicker(
                "",
                selection: $currentDate,
                displayedComponents: .hourAndMinute
            )
                .labelsHidden()
                .datePickerStyle(.wheel)
            
            Spacer()
            
            CustomButton(text: "설정하기") { isAlertActive.toggle() }
            .padding(.bottom)
            .alert("알람 설정", isPresented: $isAlertActive) {
                Button("돌아가기") { }
                Button("완료하기") {
                    isAlertActive.toggle()
                    viewModel.didTapCreateAlarmButton(
                        currentDate: currentDate,
                        latitude: manager.coordinate?.latitude,
                        longitude: manager.coordinate?.longitude
                    )
                }
            } message: {
                Text("현재 위치에서 알람을 설정할까요?\n알람 시간은 \(currentDate.hourAndMinute) 입니다.")
            }
        }
    }
}
