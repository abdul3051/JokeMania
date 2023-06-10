//
//  JMCoreDataStack.swift
//  JokeMania
//
//  Created by Abdul Rahman Khan on 10/06/23.
//

import CoreData

class JMCoreDataStack {
    static let shared = JMCoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JMDataModel")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()

    func saveJoke(_ joke: String) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Joke> = Joke.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
            fetchRequest.fetchLimit = 10
            
            if let jokes = try? context.fetch(fetchRequest), jokes.count >= 10 {
                for joke in jokes[9..<jokes.count] {
                    context.delete(joke)
                }
            }
            
            let newJoke = Joke(context: context)
            newJoke.text = joke
            newJoke.timestamp = Date() // Set the timestamp for the new joke
            
            do {
                try context.save()
            } catch {
                print("Failed to save joke: \(error.localizedDescription)")
            }
        }
    }

    func fetchJokes(limit: Int) -> [Joke] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Joke> = Joke.fetchRequest()
        fetchRequest.fetchLimit = limit

        do {
            let jokes = try context.fetch(fetchRequest)
            return jokes
        } catch {
            print("Failed to fetch jokes: \(error)")
            return []
        }
    }
}

