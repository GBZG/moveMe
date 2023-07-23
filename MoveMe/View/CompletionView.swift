//
//  CompletionView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

struct CompletionView: View {
    @ObservedObject private var viewModel = CompletionViewModel()
    @State private var isSettingButtonTapped = false
    
    var body: some View {
        NavigationView { bodyView }
            .onAppear { viewModel.onAppear() }
    }
}

private extension CompletionView {
    var bodyView: some View {
        VStack {
            header
            Spacer()
            completion
            Spacer()
            NavigationLink("", isActive: $isSettingButtonTapped) {
                SettingView()
            }
            .navigationBarHidden(true)
        }
    }
    
    var header: some View {
        HStack {
            Spacer()
            Button {
                isSettingButtonTapped.toggle()
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.mainNavy)
            }
        }
        .padding()
    }
    
    var completion: some View {
        VStack {
            Text("축하합니다!")
                .style(.heading1_Bold)
                .padding(.bottom)
            Text("무사히 도착했어요.\n내일 다시 만나요!")
                .style()
                .padding(.bottom, 10)
            Text("(알람은 00시에 초기화 됩니다.)")
                .style(.caption)
        }
    }
}
