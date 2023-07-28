//
//  GreetingView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI
import GoogleMobileAds

struct GreetingView: View {
    var body: some View {
        VStack {
            Text("GreetingViewTodayFailure".localized())
                .style(.body1_Bold, .mainGray)
            Text("GreetingViewBothersome".localized())
                .style(.body1_Bold, .mainGray)
            Text("GreetingViewTomorrow".localized())
                .style(.body1_Bold, .mainGray)
            Text("GreetingViewWeather".localized())
                .style(.body1_Bold, .mainGray)
                .padding(.bottom)

            Text("GreetingViewTitle".localized())
                .style(.heading3_Bold, .mainBlue)
                .padding(.bottom, 5)
            Text("GreetingViewIntroduction".localized())
                .style(.body1_Bold)
                .padding(.bottom, 40)
        }
    }
}

