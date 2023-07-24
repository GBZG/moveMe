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
    @State private var settingDate = Date()
    
    var body: some View {
        alarmSetting
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
            .onChange(of: currentDate) { _ in
                settingDate = Date()
            }
    }
}

private extension ChangeView {
    var alarmSetting: some View {
        VStack {
            Spacer()
            Text("\(viewModel.nextAlarm.koreanDateForm)")
                .style(.body3_Regular)
            Text("\(viewModel.scheduledHour) : \(viewModel.scheduledMinute)")
                .font(.custom(Constant.pretendardBold, size: 48))
                .padding(.bottom, 20)
            Text("하루 한 번 시간을 변경할 수 있어요.")
                .style(.body3_Regular)
            
            DatePicker(
                "",
                selection: $currentDate,
                in: settingDate...Date().endOfDay,
                displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
            .datePickerStyle(.wheel)
            
            Spacer()
            
            CustomButton(text: "변경하기") {
                viewModel.didTapAlarmChangeButton(currentDate)
            }
        }
    }
}
