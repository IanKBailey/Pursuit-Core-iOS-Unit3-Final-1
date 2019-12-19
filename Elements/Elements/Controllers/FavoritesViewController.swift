//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favorites = [Element](){
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        favoritesTableView.dataSource = self
        
    }
    
    private func getFavorites() {
        ElementsAPIClient.fetchFavorites { (result) in
                   switch result {
                   case .success(let favorites):
                    self.favorites = favorites.filter{$0.favoritedBy == "Ian Bailey"}
                   case .failure(let appError):
                       print("appError \(appError)")
                   }
               }
           }
    }
    
    

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.name
        cell.detailTextLabel?.text = favorite.favoritedBy
        return cell
    }
        
    
    
}
