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
        VStack {
            Text("성공했어요!")
            Text("내일 다시 만나요!")
            Text("00시에 초기화 됩니다.")
        }
        .onAppear { viewModel.onAppear() }
    }
}
