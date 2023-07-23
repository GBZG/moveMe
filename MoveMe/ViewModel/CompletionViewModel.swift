//
//  CompletionViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import Foundation

final class CompletionViewModel: ObservableObject {
    
    func onAppear() {
        AlarmManager.instance.completeAlarm()
    }
}
