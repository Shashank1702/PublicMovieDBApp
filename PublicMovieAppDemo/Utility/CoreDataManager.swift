//
//  CoreDataManager.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini on 01/08/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).context
    }

    func addItem(result: Results) {
        
        // Check if a movie with the same UUID already exists
        let fetchRequest: NSFetchRequest<FavouriteMovieModel> = FavouriteMovieModel.fetchRequest()
        let idToMatch = Int32(result.id ?? 0)
        fetchRequest.predicate = NSPredicate(format: "id == %d", idToMatch)
        
        do {
            let existingMovies = try context.fetch(fetchRequest)
            if existingMovies.isEmpty {
                // No duplicates found, safe to add new movie
                let newItem = FavouriteMovieModel(context: context)
                newItem.adult = result.adult ?? false
                newItem.backdrop_path = result.backdrop_path
                newItem.favorite = result.favorite
                newItem.id = Int32(result.id ?? 0)
                newItem.original_language = result.original_language
                newItem.original_title = result.original_title
                newItem.overview = result.overview
                newItem.popularity = result.popularity!
                newItem.poster_path = result.poster_path
                newItem.release_date = result.release_date
                newItem.title = result.title
                newItem.video = result.video ?? false
                newItem.vote_average = result.vote_average ?? 0.0
                newItem.vote_count = Int32(result.vote_count ?? 0)
                newItem.favorite = result.favorite
                try context.save()
                print("Movie added successfully.")
            } else {
                print("Movie with this ID already exists.")
            }
        } catch {
            print("Failed to fetch movies: \(error)")
        }
    }

    func fetchItems() -> [FavouriteMovieModel] {
        let fetchRequest: NSFetchRequest<FavouriteMovieModel> = FavouriteMovieModel.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            return items
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }

    func updateItem(result: Results) {

        do {
            try context.save()
        } catch {
            print("Failed to update item: \(error)")
        }
    }

    func deleteItem(id: Int) {
        // Check if a movie with the same UUID already exists
        let items = CoreDataManager.shared.fetchItems()
        let obj = items.first { data in
            data.id == id
        }
        if let nsObj = obj {
            context.delete(nsObj)
        }
        do {
            try context.save()
        } catch {
            print("Failed to delete item: \(error)")
        }
    }
}
