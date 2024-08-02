//
//  ViewController.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini on 29/07/24.
//

import UIKit
import SVProgressHUD

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var searchContainerView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    var movieList:[Results]?
    var searchListData: [Results]?
    
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpViews()
        self.setupTableCell()
        self.searchButton.addTarget(self, action: #selector(searchActionCall), for: .touchUpInside)
        view.backgroundColor = .clear
    }
    
    func setUpViews() {
        searchContainerView.layer.borderWidth = 2.0
        searchContainerView.layer.borderColor = UIColor.lightGray.cgColor
        searchContainerView.layer.cornerRadius = 6
        searchButton.layer.cornerRadius = 6
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        searchTextField.delegate = self
        SVProgressHUD.show()
        APIClient.getAllMovies{ result in
            switch result {
            case .success(let movies):
                self.movieList = movies.results
                self.movieListTableView.reloadData()
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupTableCell() {
        //MovieListTableViewCell
        self.movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
    }
    
    @objc func searchActionCall() {
        print("search button call")
        searchTextField.resignFirstResponder()
        if !self.searchText.isEmpty {
            APIClient.searchMovie(query: self.searchText) { result in
                switch result {
                case .success(let movie):
                    self.searchListData = movie.results
                    self.movieListTableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    @IBAction func favouriteAction(_ sender: UIButton) {
        let favouriteMovieList = FavouriteMovieListViewController()
        self.navigationController?.pushViewController(favouriteMovieList, animated: true)
    }
            
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.searchText.isEmpty ? (self.movieList?.count ?? 0) : (self.searchListData?.count ?? 0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        cell.setupTableData(movie: self.searchText.isEmpty ? self.movieList?[indexPath.row] : self.searchListData?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = MovieDetailViewController()
        secondVC.movieId = self.searchText.isEmpty ? self.movieList?[indexPath.row].id : self.searchListData?[indexPath.row].id
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension MovieListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Get the current text in the text field
        let currentText = textField.text ?? ""
        
        // Get the text after the change
        guard let textRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        // Check if the updated text contains only alphanumeric characters
        let allowedCharacterSet = CharacterSet.alphanumerics
        let disallowedCharacterSet = allowedCharacterSet.inverted
        if updatedText.rangeOfCharacter(from: disallowedCharacterSet) != nil {
            return false
        }
        
        // Check if the updated text length is within the allowed range
        if updatedText.count > 50 {
            return false
        }
        
        // Check if the updated text is empty
        if updatedText.isEmpty {
            self.searchText = ""
            self.movieListTableView.reloadData()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchText = textField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

