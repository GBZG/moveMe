//
//  AlarmView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject private var viewModel = AlarmViewModel()
    @AppStorage(Constant.alarmStatus) private var alarmStatus = Constant.waiting
    
    var body: some View {
        VStack {
            switch alarmStatus {
            case Constant.active: RingingView()
            case Constant.waiting: ChangeView()
            case Constant.completed: CompletionView()
            case Constant.changed: WaitingView()
            default:
                ChangeView()
            }
        }
    }
}

