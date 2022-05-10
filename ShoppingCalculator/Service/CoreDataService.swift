import Foundation
import CoreData

final class CoreDataService {
    lazy var context = persistentContainer.viewContext
    
    // MARK: - CoreData

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "ShoppingCalculator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func trySaveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func reset() {
        context.reset()
    }
    
    func deleteAll() {
        let entities = persistentContainer.managedObjectModel.entities
        for entitie in entities {
            delete(entityName: entitie.name!)
        }
    }
    
    private func delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint("Delete ERROR \(entityName)")
            debugPrint(error)
        }
    }
}
