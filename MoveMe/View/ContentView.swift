//
//  ContentView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @AppStorage(Constant.isFirstLaunch) private var isFirstLaunch = false
    
    var body: some View {
        VStack {
            switch isFirstLaunch {
            case true: AlarmView()
            case false: StartingView()
            }
        }
        .environmentObject(viewModel.locationManager)
        .environment(\.managedObjectContext, CoreDataManager.instance.container.viewContext)
    }
}
