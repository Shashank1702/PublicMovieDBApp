//
//  MovieListTableViewCell.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini on 30/07/24.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var movieIcon: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTableData(movie: Results?) {
        if let iconPath = movie?.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + iconPath)
            movieIcon.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        titleLabel.text = movie?.title ?? ""
        descriptionLbl.text = movie?.overview ?? ""
    }
    
    func setUpforFavouriteMovies(movie: FavouriteMovieModel) {
        if let iconPath = movie.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + iconPath)
            movieIcon.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        titleLabel.text = movie.title ?? ""
        descriptionLbl.text = movie.overview ?? ""
    }
}
