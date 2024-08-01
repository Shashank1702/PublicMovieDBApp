//
//  MovieDetailsTableViewCell.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini on 31/07/24.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var movieIcon: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    var movie:Results?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heartButton.isSelected = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func heartAction(_ sender: UIButton) {
        if !heartButton.isSelected {
            heartButton.isSelected = true
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            if var result = self.movie {
                result.favorite = true
                CoreDataManager.shared.addItem(result: result)
            }
        } else {
            heartButton.isSelected = false
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            if var result = self.movie {
                result.favorite = false
                CoreDataManager.shared.deleteItem(id: result.id ?? 0)
            }
        }
    }
    
    func setupTableData(movie: Results?) {
        self.movie = movie
        if let isFavorite = self.movie?.favorite, isFavorite {
            heartButton.isSelected = true
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        } else {
            heartButton.isSelected = false
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        if let iconPath = movie?.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + iconPath)
            movieIcon.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        titleLabel.text = movie?.title ?? ""
        descriptionLbl.text = movie?.overview ?? ""
    }
}
