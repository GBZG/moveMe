//
//  ContentView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @AppStorage("isAlarmSet") private var isAlarmSet = false
    
    var body: some View {
        VStack {
            switch isAlarmSet {
            case true: AlarmView()
            case false: StartingView()
            }
        }
        .environmentObject(viewModel.locationManager)
        .onAppear { viewModel.onAppear() }
        .onDisappear { viewModel.onDisappear() }
    }
}




