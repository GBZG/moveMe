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
    @State private var currentDate = Date()
    @State private var isChangeButtonTapped = false
    
    var body: some View {
        VStack {
            if viewModel.alarmData != nil {
                alarmSetting
                statistics
                Spacer()
            } else {
                Text("Alarm Data Not Found")
            }
        }
        .padding(.horizontal, 12)
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
                Text(viewModel.alarmData?.date?.convertToLocalDateForm ?? "")
                    .style(.caption, .gray)
                Spacer()
            }
            .padding(.bottom, 3)
            HStack {
                Text(viewModel.alarmTime)
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
        }
        .padding(.bottom, 8)
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
    
    @ViewBuilder
    var statistics: some View {
        VStack {
            if viewModel.history.isEmpty { }
            else {
                HStack {
                    Text("WaitingViewMyRecordTitle".localized())
                        .style(.heading3_Bold)
                    Spacer()
                }
                
                List {
                    ForEach(viewModel.history) { record in
                        HStack {
                            Text("\(record.date!.historyForm)")
                                .style(.body2_Medium)
                            Spacer()
                            if record.result { Text("✅") }
                            else { Text("❌") }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}
