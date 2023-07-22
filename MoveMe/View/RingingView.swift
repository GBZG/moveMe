//
//  RingingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI
import CoreLocation

struct RingingView: View {
    @EnvironmentObject private var manager: LocationManager
    @ObservedObject private var viewModel = RingingViewModel()
    private var currentLocation: CLLocation {
        CLLocation(
            latitude: manager.coordinate?.latitude ?? 0,
            longitude: manager.coordinate?.longitude ?? 0
        )
    }
    
    var body: some View {
        alarmIsOn
    }
}

private extension RingingView {
    var alarmIsOn: some View {
        VStack {
            Text("현재위치")
            TrackingView()
                .padding(.bottom)
            
            Text("도착 위치")
            PairView(
                leftText: "위도",
                rightText: String(UserDefaults.standard.double(forKey: Constant.latitude))
            )
            PairView(
                leftText: "경도",
                rightText: String(UserDefaults.standard.double(forKey: Constant.longitude))
            )
            
            Button {
                viewModel.didTapCompleteButton(currentLocation: currentLocation)
            } label: {
                Text("완료하기")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 100)
                    .background(.purple)
                    .cornerRadius(12)
            }
            .alert("더 가까이 가세요", isPresented: $viewModel.isAlertActive) {
                Button("확인") { viewModel.tapAlertCloseButton() }
            } message: {
                Text("남은 거리 \(viewModel.distance ?? 0)m")
            }

//            Button {
//                viewModel.didTapDiscardButton()
//            } label: {
//                Text("내일 다시 도전하기")
//                    .font(.body)
//                    .foregroundColor(.white)
//                    .padding(.vertical, 14)
//                    .padding(.horizontal, 100)
//                    .background(.red)
//                    .cornerRadius(12)
//            }
        }
    }
}

