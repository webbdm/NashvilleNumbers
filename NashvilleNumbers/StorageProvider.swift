//
//  StorageProvider.swift
//  StorageProvider
//
//  Created by Russell Gordon on 2021-07-16.
//

import CoreData
import Foundation

// Must conform to ObservableObject to be passed through the environment
class StorageProvider: ObservableObject {
    
    // For showing the list of movies
    @Published private(set) var songs: [Song] = []

    // For initializing the Core Data stack and loading the Core Data model file
    let persistentContainer: NSPersistentContainer
    
    // For use with Xcode Previews, provides some data to work with for examples
    static var preview: StorageProvider = {
        
        // Create an instance of the provider that runs in memory only
        let storageProvider = StorageProvider(inMemory: true)
        
                    
         for i in 0..<4 {
            storageProvider.saveSong(name: "Test", key: "A")
        }
        
        // Now save these movies in the Core Data store
        do {
            try storageProvider.persistentContainer.viewContext.save()
        } catch {
            // Something went wrong 😭
            print("Failed to save test movies: \(error)")
        }

        return storageProvider
    }()
    
    init(inMemory: Bool = false) {
        
        // Access the model file
        persistentContainer = NSPersistentContainer(name: "PracticalCoreData")
        
        // Don't save information for future use if running in memory...
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Attempt to load persistent stores (the underlying storage of data)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                
                // For now, any failure to load the model is a programming error, and not recoverable
                fatalError("Core Data store failed to load with error: \(error)")
            } else {
                
                print("Successfully loaded persistent stores.")
                
                // Get all the movies
                self.songs = self.getAllSongs()
            }
            
        }
    }
    
}

// Get all the movies
extension StorageProvider {
    
    // Made private because views will access the movies retrieved from Core Data via the movies array in StorageProvider
    private func getAllSongs() -> [Song] {
        
        // Must specify the type with annotation, otherwise Xcode won't know what overload of fetchRequest() to use (we want to use the one for the Movie entity)
        // The generic argument <Movie> allows Swift to know what kind of managed object a fetch request returns, which will make it easier to return the list of movies as an array
        let fetchRequest: NSFetchRequest<Song> = Song.fetchRequest()
        
        do {
            
            // Return an array of Movie objects, retrieved from the Core Data store
            return try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            
            print("Failed to fetch songs \(error)")
            
        }
        
        // If an error occured, return nothing
        return []
    }
    
}

// Save a movie
extension StorageProvider {
    
    func saveSong(name: String, key: String) {
        
        // New Movie instance is tied to the managed object context
        let song = Song(context: persistentContainer.viewContext)
        
        // Set the name for the new movie
        song.name = name
        song.key = key
        
        do {
            
            // Persist the data in this managed object context to the underlying store
            try persistentContainer.viewContext.save()
            
            print("Songsaved successfully")
            
            // Refresh the list of movies
          // song = getAllSongs()
            
        } catch {
            
            // Something went wrong 😭
            print("Failed to save movie: \(error)")
            
            // Rollback any changes in the managed object context
            persistentContainer.viewContext.rollback()
            
        }
        
    }

}
