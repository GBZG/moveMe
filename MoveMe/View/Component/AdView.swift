//
//  AdView.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI
import UIKit
import GoogleMobileAds

struct AdView: View {    
    var body: some View {
        ZStack {
            Group {
                Rectangle()
                    .foregroundColor(.white)
//                    .overlay {
//                        Text("광고")
//                            .style(.body3_Regular, .mainWhite)
//                            .padding(8)
//                            .background(Color.mainGray)
//                            .cornerRadius(99)
//                    }
                GoogleAdView()
            }
            .frame(
                width: Constant.screenWidth,
                height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(Constant.screenWidth).size.height
            )
        }
    }
}

struct GoogleAdView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let bannerSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(Constant.screenWidth)
        let banner = GADBannerView(adSize: bannerSize)
        
        banner.rootViewController = viewController
        
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        
        banner.adUnitID = Constant.realAdBanner
        banner.load(GADRequest())
        
        return viewController
    }
    
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        
    }
}
