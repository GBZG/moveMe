//
//  SettingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Button {
                // Get the settings URL and open it
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            } label: {
                VStack {
                    HStack {
                        Text("알림 설정")
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
}

