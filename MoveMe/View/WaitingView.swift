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
    private var nextAlarmDate: String {
        let date = UserDefaults.standard.object(forKey: Constant.nextAlarm) as? Date
        guard let date = date else { return "" }
        return date.koreanDateForm
    }
    
    var body: some View {
        alarmSetting
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
    }
}

private extension WaitingView {
    var alarmSetting: some View {
        ZStack {
            VStack {
                Spacer()
                Text("다음 알람 시간이에요")
                    .style(.body3_Regular)
                    .padding(.bottom, 8)
                
                Text(nextAlarmDate)
                    .style(.body3_Regular)
                Text("\(hour) : \(Double(minute)! <= 9 ? "0\(minute)" : minute)")
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
