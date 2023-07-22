//
//  TrackingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI
import CoreLocation

struct TrackingView: View {
    @EnvironmentObject var manager: LocationManager
    
    var body: some View {
        VStack {
            PairView(
                leftText: "위도:",
                rightText: String(manager.coordinate?.latitude ?? 0)
            )
            PairView(
                leftText: "경도:",
                rightText: String(manager.coordinate?.longitude ?? 0)
            )
        }
    }
}
