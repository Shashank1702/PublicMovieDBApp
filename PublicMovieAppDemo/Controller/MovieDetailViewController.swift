//
//  MovieDetailViewController.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini on 31/07/24.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieDetailsTableView: UITableView!
    
    var movie:Results?
    var movieId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.setupTableCell()
    }

    func setUpViews() {
        movieDetailsTableView.delegate = self
        movieDetailsTableView.dataSource = self
        APIClient.getMovieDetails(id: "\(movieId ?? 533535)") { result in
            switch result {
            case .success(let movie):
                self.movie = movie
                let items = CoreDataManager.shared.fetchItems()
                let obj = items.first { data in
                    data.id == Int32(movie.id ?? 0)
                }
                if Int(obj?.id ?? 0) == Int(self.movie?.id ?? 0) {
                    self.movie?.favorite = true
                } else {
                    self.movie?.favorite = false
                }
                self.movieDetailsTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupTableCell() {
        self.movieDetailsTableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailsTableViewCell")
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell") as? MovieDetailsTableViewCell else {
            return UITableViewCell()
        }
        cell.setupTableData(movie: self.movie)
        return cell
    }
    
    
}
