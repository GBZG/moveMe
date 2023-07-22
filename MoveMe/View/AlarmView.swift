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
            case Constant.completed: alarmIsCompleted
            case Constant.discarded: alarmIsDiscarded
            case Constant.changed: WaitingView()
            default:
                ChangeView()
            }
        }
    }
}

private extension AlarmView {
    var alarmIsCompleted: some View {
        VStack {
            Text("성공했어요!")
            Text("내일 다시 만나요!")
            Text("00시에 초기화 됩니다.")
        }
    }

    var alarmIsDiscarded: some View {
        VStack {
            Text("내일 다시 도전해봐요!")
            Text("00시에 초기화 됩니다.")
        }
    }
}


