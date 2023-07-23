//
//  Font+.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI

extension Font {
    enum Pretendard {
        case heading1
        case heading2
        case heading3
        case body1
        case body2
        case body3
        case caption
        
        var size: CGFloat {
            switch self {
            case .heading1: return 28
            case .heading2: return 24
            case .heading3: return 22
            case .body1: return 18
            case .body2: return 16
            case .body3: return 14
            case .caption: return 12
            }
        }
    }

    static func pretendard(style size: Pretendard) -> Font {
        return .custom("PretendardVariable", size: size.size)
    }
}
