//
//  FavouriteMovieListViewController.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini (Digital,ISC)(X-Kellton) on 01/08/24.
//

import UIKit

class FavouriteMovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var items: [FavouriteMovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = CoreDataManager.shared.fetchItems()
        self.movieTableView.reloadData()
    }
    
    func setupTableCell() {
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.movieTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        cell.setUpforFavouriteMovies(movie: self.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = MovieDetailViewController()
        secondVC.movieId = Int(self.items[indexPath.row].id)
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
