//
//  CoreDataManager.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/30.
//

import CoreData

final class CoreDataManager {
    static let instance = CoreDataManager()

    let container = NSPersistentContainer(name: CoreData.container)
    private var context: NSManagedObjectContext {
        container.viewContext
    }

    private init() {
        loadStores()
    }

    private func loadStores() {
        container.loadPersistentStores { desc, error in
              if let error = error {
                  print("🔥 [Error] CoreData Error: \(error.localizedDescription)")
              }
        }
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("FAILED TO SAVE CONTEXT")
        }
    }
}

// MARK: Alarm Setting
extension CoreDataManager {
    func getAllAlarms() -> Array<AlarmEntity> {
        let fetchRequest: NSFetchRequest<AlarmEntity> = AlarmEntity.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(AlarmEntity.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let result = try? context.fetch(fetchRequest)
        return result ?? []
    }

    func createAlarm(date: Date, hour: Int16, minute: Int16, latitude: Double, longitude: Double) {
        let alarm = AlarmEntity(context: container.viewContext)
        alarm.identifier = UUID().uuidString
        alarm.date = date
        alarm.hour = hour
        alarm.minute = minute
        alarm.latitude = latitude
        alarm.longitude = longitude
        save()
    }
    
    func editAlarm(alarm: AlarmEntity, date: Date, hour: Int16, minute: Int16) {
        alarm.date = date
        alarm.hour = hour
        alarm.minute = minute
        save()
    }

    func deletePromise(alarm: AlarmEntity) {
        container.viewContext.delete(alarm)
        save()
    }    
}

// MARK: History Setting
extension CoreDataManager {
    func getAllHistoryRecords() -> Array<HistoryEntity> {
        let fetchRequest: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(HistoryEntity.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let result = try? context.fetch(fetchRequest)
        return result ?? []
    }

    func createHistory(date: Date, result: Bool) {
        let record = HistoryEntity(context: container.viewContext)
        record.identifier = UUID().uuidString
        record.date = date
        record.result = result
        save()
    }
        
    func deleteAllHistoryRecords() {
          let fetchRequest: NSFetchRequest<NSFetchRequestResult> = HistoryEntity.fetchRequest()
          let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
          _ = try? container.viewContext.execute(batchDeleteRequest)
    }
}
