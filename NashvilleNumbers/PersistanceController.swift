import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for _ in 0..<10 {
        let song1 = Song(context: viewContext)
        song1.name = "Heart Shaped Box"
        song1.key = "A#"
            
        let song2 = Song(context: viewContext)
        song2.name = "Friends In Low Places"
        song2.key = "B"
        }

        do {
           try viewContext.save()
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

      return result

    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "Song")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
