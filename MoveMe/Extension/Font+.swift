//
//  Font+.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

extension Font {
    enum Pretendard {
        case heading1_Medium
        case heading1_Bold
        case heading2_Medium
        case heading2_Bold
        case heading3_Medium
        case heading3_Bold
        case body1_Regular
        case body1_Medium
        case body1_Bold
        case body2_Regular
        case body2_Medium
        case body2_Bold
        case body3_Regular
        case body3_Medium
        case body3_Bold
        case caption
        
        var size: CGFloat {
            switch self {
            case .heading1_Medium, .heading1_Bold: return 28
            case .heading2_Medium, .heading2_Bold: return 24
            case .heading3_Medium, .heading3_Bold: return 22
            case .body1_Regular, .body1_Medium, .body1_Bold: return 18
            case .body2_Regular, .body2_Medium, .body2_Bold: return 16
            case .body3_Regular, .body3_Medium, .body3_Bold: return 14
            case .caption: return 12
            }
        }
        
        var weight: String {
            switch self {
            case .heading1_Medium, .heading2_Medium, .heading3_Medium, .body1_Medium, .body2_Medium, .body3_Medium:
                return "Pretendard-Medium"
            case .heading1_Bold, .heading2_Bold, .heading3_Bold, .body1_Bold, .body2_Bold, .body3_Bold:
                return "Pretendard-Bold"
            case .body1_Regular, .body2_Regular, .body3_Regular, .caption:
                return "Pretendard-Regular"
            }
        }
    }

    static func pretendard(_ style: Pretendard) -> Font {
        return .custom(style.weight, size: style.size)
    }
}
