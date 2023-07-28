//
//  SettingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isAcknowledmentButtonTapped = false
    @State private var isProductInfoTapped = false
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.mainBlue)]
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        bodyView
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: dismissButton)
            .navigationTitle("SettingViewSetting".localized())
            .navigationBarTitleDisplayMode(.inline)
            .popover(isPresented: $isAcknowledmentButtonTapped) {
                acknowledment
            }
            .popover(isPresented: $isProductInfoTapped) {
                productInfo
            }
    }
}

private extension SettingView {
    var bodyView: some View {
        buttonList
    }
    
    var buttonList: some View {
        VStack {
            Button {
                // Get the settings URL and open it
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            } label: {
                VStack {
                    HStack {
                        Text("SettingViewSetting".localized())
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(10)
                }
                .foregroundColor(.mainNavy)
            }
            Button {
                isAcknowledmentButtonTapped.toggle()
            } label: {
                VStack {
                    HStack {
                        Text("SettingViewSoundInfo".localized())
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(10)
                }
                .foregroundColor(.mainNavy)
            }
            Button {
                isProductInfoTapped.toggle()
            } label: {
                VStack {
                    HStack {
                        Text("SettingViewServiceInfo".localized())
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(10)
                }
                .foregroundColor(.mainNavy)
            }
            Spacer()
        }
    }
    
    var acknowledment: some View {
        List {
            Text("Message Ringtone - SergeQuadrado (Pixabay, https://pixabay.com)")
        }
    }
    
    var productInfo: some View {
        List {
            Text("SettingViewServiceInfoAuthorEmail".localized())
        }

    }
    
    var dismissButton: some View {
        Button(action : {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
        }
    }
}
