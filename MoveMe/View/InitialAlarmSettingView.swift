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
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    private var authorizationStatus: Bool {
        if (manager.authorizationStatus == .authorizedAlways) { return true }
        if (manager.authorizationStatus == .authorizedWhenInUse) { return true}
        
        return false
    }
    
    var body: some View {
        VStack() {
            map
            alarmSetting
            Spacer()
        }
        .onAppear { region = viewModel.onAppear(manager) }
    }
}

private extension InitialAlarmSettingView {
    @ViewBuilder
    var map: some View {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: mapIsAllowed
        case .denied, .restricted, .notDetermined: mapIsNotAllowed
        @unknown default: mapIsNotAllowed
        }
    }
    
    var mapIsAllowed: some View{
        Map(
            coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow)
        )
        .frame(height: 350)
    }
    
    var mapIsNotAllowed: some View {
        VStack {
            Text("InitialSettingViewErrorTitle".localized())
                .style(.heading1_Bold, .gray)
                .padding(.bottom, 8)
            Text("InitialSettingViewErrorDescription".localized())
                .style(.heading2_Bold, .gray)
        }
        .frame(height: 350)
    }
    
    var alarmSetting: some View {
        VStack {
            if (authorizationStatus) {
                Text("InitialSettingViewAlarmSettingTitle".localized())
                    .style(.heading3_Bold)
                    .padding(.top, 10)
                    .padding(.bottom, 3)
                
                DatePicker(
                    "",
                    selection: $currentDate,
                    displayedComponents: .hourAndMinute
                )
                .labelsHidden()
                .datePickerStyle(.wheel)
                
                Spacer()
                
                CustomButton(text: "InitialSettingViewAlarmButtonLabel".localized()) { isAlertActive.toggle() }
                    .padding(.bottom)
                    .alert("InitialSettingViewAlertTitle".localized(), isPresented: $isAlertActive) {
                        Button("InitialSettingViewAlertBack".localized()) { }
                        Button("InitialSettingViewAlertComplete".localized()) {
                            isAlertActive.toggle()
                            viewModel.didTapCreateAlarmButton(
                                currentDate: currentDate,
                                latitude: manager.coordinate?.latitude,
                                longitude: manager.coordinate?.longitude
                            )
                        }
                    } message: {
                        Text("InitialSettingViewAlertMessage \(currentDate.hourAndMinute)")
                    }
            }
            else {
                Text("InitialSettingViewErrorRequirement".localized())
                    .style(.heading3_Bold)
                    .padding(.top, 10)
                    .padding(.bottom, 3)
                
                Text("InitialSettingViewErrorRequirementGuide".localized())
                    .style()
                
                CustomButton(text: "InitialSettingViewErrorSettingButtonLabel".localized()) {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
    }
}
