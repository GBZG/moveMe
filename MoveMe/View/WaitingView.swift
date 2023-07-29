//
//  WaitingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import SwiftUI
import MapKit

struct WaitingView: View {
    @StateObject private var viewModel = WaitingViewModel()
    @AppStorage(Constant.scheduledHour) private var hour = ""
    @AppStorage(Constant.scheduledMinute) private var minute = ""
    @AppStorage(Constant.latitude) private var latitude = ""
    @AppStorage(Constant.longitude) private var longitude = ""
    @State private var currentDate = Date()
    @State private var isChangeButtonTapped = false
    private var nextAlarmDate: String {
        guard let date = UserDefaults.standard.object(forKey: Constant.nextAlarm) as? Date
        else { return "" }
        if #available(iOS 16, *) {
            guard let string = Locale.current.language.languageCode?.identifier else { return "" }
            if string == "ko" { return date.koreanDateForm }
            else { return date.americanDateForm}
        } else {
            guard let string = Locale.current.languageCode else { return "" }
            if string == "ko" { return date.koreanDateForm }
            else { return date.americanDateForm}
        }
    }

    var body: some View {
        alarmSetting
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
            .onChange(of: viewModel.count) { _ in
                viewModel.onChange()
            }
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
                    Text("WaitingViewDestinationTitle".localized())
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
                Text("WaitingViewNextAlarmTitle".localized())
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
            
            Text("WaitingViewChangeGuide".localized())
                .style(.caption, .gray)
                .padding(.top, 12)
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .sheet(isPresented: $isChangeButtonTapped) {
            VStack {
                map
                Spacer()
                Text("WaitingViewChangeDescription".localized())
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
                CustomButton(text: "WaitingViewChangeButtonLabel".localized()) {
                    viewModel.didTapAlarmChangeButton(currentDate)
                    isChangeButtonTapped.toggle()
                }
            }
        }
    }
}
