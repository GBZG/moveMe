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
        VStack(spacing: 0) {
            HStack {
                Text("다음 알람")
                    .style(.heading3_Bold)
                Spacer()
            }
            .padding(.bottom, 12)
            
            HStack {
                Text(nextAlarmDate)
                    .style(.caption, .gray)
                Spacer()
            }
            .padding(.bottom, 3)
            HStack {
                Text("\(hour) : \(Double(minute)! <= 9 ? "0\(minute)" : minute)")
                    .font(.custom(Constant.pretendardBold, size: 36))
                    .padding(.vertical, 20)
                    .padding(.horizontal, 12)
                Spacer()
            }
            .frame(height: 72)
            .background(Color.mainGray.opacity(0.3))
            .cornerRadius(12)
            .onTapGesture {
                isChangeButtonTapped.toggle()
            }
            
            Text("터치해서 시간을 변경할 수 있어요!")
                .style(.caption, .gray)
                .padding(.top, 12)
            
            Spacer()
        }
        .padding(.horizontal, 12)
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
