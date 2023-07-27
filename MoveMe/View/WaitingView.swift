//
//  WaitingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import SwiftUI
import MapKit

struct WaitingView: View {
    @ObservedObject private var viewModel = WaitingViewModel()
    @AppStorage(Constant.scheduledHour) private var hour = ""
    @AppStorage(Constant.scheduledMinute) private var minute = ""
    @AppStorage(Constant.latitude) private var latitude = ""
    @AppStorage(Constant.longitude) private var longitude = ""
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
    var map: some View {
        
        Map(
            coordinateRegion: $viewModel.region,
            showsUserLocation: true,
            annotationItems: viewModel.mapLocations
        ) {
            MapAnnotation(coordinate: $0.coordinate) {
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.mainBlue)
                    .overlay { Text("✓").foregroundColor(.mainWhite) }
            }
        }
        .frame(height: 250)
        .disabled(true)
        .padding(.bottom)
        .overlay {
            VStack {
                HStack {
                    Text("목적지를 확인해보세요")
                        .style(.body3_Medium, .mainWhite)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(12)
                    Spacer()
                }
                Spacer()
            }
            .padding(12)
        }
    }
    
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
            VStack {
                map
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
