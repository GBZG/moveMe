//
//  CompletionView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

struct CompletionView: View {
    @ObservedObject private var viewModel = CompletionViewModel()
    
    var body: some View {
        completion
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
    }
}

private extension CompletionView {
    var completion: some View {
        VStack {
            Text("🎉")
                .font(.largeTitle)
            Text("축하합니다!")
                .style(.heading1_Bold)
                .padding(.bottom)
            Text("무사히 도착했어요.\n내일 다시 만나요!")
                .style()
                .padding(.bottom, 10)
            Text("(알람은 00시에 초기화 됩니다.)")
                .style(.caption)
        }
        .padding(.bottom)
    }
}
