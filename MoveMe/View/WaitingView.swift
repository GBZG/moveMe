//
//  WaitingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import SwiftUI

struct WaitingView: View {
    @ObservedObject var viewModel = WaitingViewModel()
    @AppStorage(Constant.alarmStatus) private var alarmStatus = Constant.waiting
    
    var body: some View {
        VStack {
            Image("Mangom")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
        
            Text("알람 기다리는 중...")
            
            if (alarmStatus == Constant.changed) {
                Text("알람 시간은 \(viewModel.scheduledHour):\(viewModel.scheduledMinute)")
            } else {
                Text("알람 시간은 \(viewModel.originalHour):\(viewModel.originalMinute)")
            }

        }
    }
}
