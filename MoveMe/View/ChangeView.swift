//
//  ChangeView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import SwiftUI

struct ChangeView: View {
    @ObservedObject private var viewModel = ChangeViewModel()
    @State private var currentDate = Date()
    
    var body: some View {
        VStack {
            Text("알람 시간은 \(viewModel.scheduledHour)시 \(viewModel.scheduledMinute)분이에요")
                .padding(.bottom, 10)
            Text("오늘만 시간을 변경할까요? 설정하지 않으면 원래 시간으로 알려드려요.")
                .padding()
            
            DatePicker(
                "",
                selection: $currentDate,
                in: Date()...Date().endOfDay,
                displayedComponents: [.hourAndMinute]
            )
                .labelsHidden()
                .datePickerStyle(.wheel)
            
            CustomButton(text: "변경하기") {
                viewModel.didTapAlarmChangeButton(currentDate)
            }
        }
    }
}
