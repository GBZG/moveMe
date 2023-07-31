//
//  RingingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI
import MapKit

struct RingingView: View {
    @EnvironmentObject private var manager: LocationManager
    @ObservedObject private var viewModel = RingingViewModel()
    @State private var didTapStopRepititionButton = false
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    private var currentLocation: CLLocation {
        CLLocation(
            latitude: manager.coordinate?.latitude ?? 0,
            longitude: manager.coordinate?.longitude ?? 0
        )
    }
    private var distance: Int {
        guard let alarmData = viewModel.alarmData else { return 0 }
        let latitude = alarmData.latitude
        let longitude = alarmData.longitude
        let coordinate = CLLocation(latitude: latitude, longitude: longitude)
        let distanceInMeters = currentLocation.distance(from: coordinate)
        
        return Int(distanceInMeters)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            map
            alarmIsOn
            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear { region = viewModel.onAppear(manager) }
        .fullScreenCover(isPresented: $viewModel.isAlarmCompleted) {
            CompletionView(
                didTapReturnButton: $viewModel.isAlarmCompleted
            )
        }
        .toast(
            message: "RingingViewStopRepititionToastMessage".localized(),
            isShowing: $didTapStopRepititionButton,
            duration: Toast.short
        )
    }
}

private extension RingingView {
    var map: some View {
        VStack {
            Map(
                coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow)
            )
            .frame(height: 250)
        }
        .padding(.bottom)
    }
    
    var alarmIsOn: some View {
        VStack {
            Text("RingingViewTitle".localized())
                .style(.heading1_Bold)
                .padding(.bottom, 12)
            Text("RingingViewDistanceLabel".localized())
                .style()
                .padding(.bottom, 3)
            Text("\(distance)m")
                .style(.heading1_Bold, distance <= 12 ? .mainRed : .mainBlue)
            
            Spacer()
            
            Button {
                viewModel.didTapStopRepitition()
                didTapStopRepititionButton.toggle()
            } label: {
                Text("RingingViewStopRepititionButtonLabel".localized())
                    .style(.body2_Medium, .mainRed)
            }
            
            .padding(.bottom, 12)
            CustomButton(text: "RingingViewStopCompleteButtonLabel".localized()) {
                viewModel.didTapCompleteButton(currentLocation: currentLocation)
            }
            .alert("RingingViewStopAlertMessage".localized(), isPresented: $viewModel.isAlertActive) {
                Button("RingingViewStopAlertButtonLabel".localized()) { viewModel.tapAlertCloseButton() }
            } message: {
                Text("RingingViewStopAlertDistance \(viewModel.distance ?? 0)")
            }
            
        }
        .padding(.bottom)
    }
}

