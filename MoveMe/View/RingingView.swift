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
    
    var body: some View {
        VStack {
            map
            alarmIsOn
        }
        .navigationBarHidden(true)
        .onAppear { region = viewModel.onAppear(manager) }
    }
}

private extension RingingView {
    var map: some View {
        VStack {
            Text("움직일 시간이에요!")
                .style(.heading1_Bold)
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
            Text("남은 거리")
                .padding(.bottom, 3)
            Text(" \(viewModel.distance ?? 0)m")
                .style(.heading2_Bold)
                .padding(.bottom)
            
            CustomButton(text: "완료하기") {
                viewModel.didTapCompleteButton(currentLocation: currentLocation)
            }
            .alert("더 가까이 가세요", isPresented: $viewModel.isAlertActive) {
                Button("확인") { viewModel.tapAlertCloseButton() }
            } message: {
                Text("남은 거리 \(viewModel.distance ?? 0)m")
            }
        }
    }
}

