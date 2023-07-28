//
//  String+.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/28.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
