//
//  CompletionView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

struct CompletionView: View {
    @ObservedObject private var viewModel = CompletionViewModel()
    @Binding var didTapReturnButton: Bool
    
    var body: some View {
        completion
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
            .onDisappear { viewModel.onDisappear() }
    }
}

private extension CompletionView {
    var completion: some View {
        ZStack {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: -100, y : -50)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: 60, y : 70)
            }
            VStack {
                Spacer()
                Text("🎉")
                    .font(.largeTitle)
                Text("축하합니다!")
                    .style(.heading1_Bold)
                    .padding(.bottom)
                Text("무사히 도착했어요.")
                    .style()
                    .padding(.bottom, 10)
                Spacer()
                CustomButton(text: "돌아가기") {
                    didTapReturnButton.toggle()
                }
            }
            .padding(.bottom)
        }
    }
}
