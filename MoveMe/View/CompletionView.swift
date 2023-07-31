//
//  CompletionView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import CoreData
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
                Text("CompletionViewTitle".localized())
                    .style(.heading1_Bold)
                    .padding(.bottom)
                Text("CompletionViewDescription".localized())
                    .style()
                    .padding(.bottom, 10)
                Spacer()
                CustomButton(text: "CompletionViewButtonLabel".localized()) {
                    didTapReturnButton.toggle()
                }
            }
            .padding(.bottom)
        }
    }
}
