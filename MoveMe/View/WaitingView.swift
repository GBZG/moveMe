//
//  WaitingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import SwiftUI

struct WaitingView: View {
    @ObservedObject private var viewModel = WaitingViewModel()
    @AppStorage(Constant.scheduledHour) private var hour = ""
    @AppStorage(Constant.scheduledMinute) private var minute = ""
    @State private var currentDate = Date()
    @State private var isChangeButtonTapped = false
    
    var body: some View {
        alarmSetting
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
            .onChange(of: isChangeButtonTapped) { newValue in
                viewModel.onChange()
            }
    }
}

private extension WaitingView {
    var alarmSetting: some View {
        ZStack {
            VStack {
                Spacer()
                Text("다음 알람은..")
                    .style(.body3_Regular)
                    .padding(.bottom, 20)
                Text("\(viewModel.nextAlarm.koreanDateForm)")
                    .style(.body3_Regular)
                Text("\(hour) : \(minute)")
                    .font(.custom(Constant.pretendardBold, size: 48))
                    .padding(.bottom, 20)
                
                Spacer()
                
                CustomButton(text: "변경하기") {
                    isChangeButtonTapped.toggle()
                }
            }
        }
        .sheet(isPresented: $isChangeButtonTapped) {
            HalfSheet {
                Spacer()
                Text("알람 시간을 변경할 수 있어요")
                    .style()
                    .padding(.bottom, 3)
                DatePicker(
                    "",
                    selection: $currentDate,
                    displayedComponents: [.hourAndMinute]
                )
                .labelsHidden()
                .datePickerStyle(.wheel)
                Spacer()
                CustomButton(text: "완료") {
                    viewModel.didTapAlarmChangeButton(currentDate)
                    isChangeButtonTapped.toggle()
                }
            }
        }
    }
}
