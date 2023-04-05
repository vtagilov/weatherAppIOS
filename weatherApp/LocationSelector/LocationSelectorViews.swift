import Foundation
import UIKit


extension LocationSelectorVC {
    
    func setMainUI() {
        
        LocationSelectorViews().configure()
        
    }
    
}

class LocationSelectorViews: NSObject, UISearchBarDelegate, UITableViewDataSource {
    
    var favoriteLocationsCount = 0
    var favoriteLocations = [String]()
    
    var tableView = UITableView()
    var searchBar = UISearchBar()
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLocationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LocationTableViewCell(reuseIdentifier: favoriteLocations[favoriteLocationsCount - indexPath.row - 1], indexPath: indexPath)
        
        return cell

    }
    
    
    func updateLocations() {
        
    }
    
    func configure() {
        
        readFavoriteLocations()
        
        
        searchBar = {
            let searchBar = UISearchBar()
            
            searchBar.placeholder = "Type any place..."
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.showsSearchResultsButton = true
            searchBar.delegate = self
            
            return searchBar
        }()
        
        tableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.dataSource = self
            
            
            return tableView
        }()
        
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
        
        favoriteLocationsCount += 1
        favoriteLocations.append(searchBar.text ?? "")
        
        saveFavoriteLocations()
        tableView.reloadData()
        
        searchBar.resignFirstResponder()
    }
    
    
    
    func readFavoriteLocations() {
        let strFavoriteLocationsCount = UserDefaults.standard.string(forKey: "favoriteLocations.count") ?? "0"
        favoriteLocationsCount = Int(strFavoriteLocationsCount) ?? 0
        
        
        for i in 0..<favoriteLocationsCount {
            favoriteLocations.append(UserDefaults.standard.string(forKey: "favoriteLocations.\(i)") ?? "")
        }

    }
    
    
    func saveFavoriteLocations() {
        
        UserDefaults.standard.set(favoriteLocationsCount, forKey: "favoriteLocations.count")
        
        for i in 0..<favoriteLocationsCount {
            UserDefaults.standard.set(favoriteLocations[i], forKey: "favoriteLocations.\(i)")
        }
        
    }
    
    
    
}
