import Foundation
import UIKit



class LocationSelectorViews: NSObject, UISearchBarDelegate, UITableViewDataSource {
    
    var delegate: GeocoderUpdateUIProtocol?
    
    
    var favoriteLocationsCount = 0
    var favoriteLocations = [String]()
    
    var tableView = UITableView()
    var searchBar = UISearchBar()
    
    var geocoder: GeocoderAPI? = nil
    
    init(geocoder: GeocoderAPI) {
        self.geocoder = geocoder
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLocationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationTableViewCell
        if geocoder != nil {
            cell = LocationTableViewCell(reuseIdentifier: favoriteLocations[favoriteLocationsCount - indexPath.row - 1], indexPath: indexPath, geocoder: geocoder!)
        } else {
            cell = LocationTableViewCell(reuseIdentifier: favoriteLocations[favoriteLocationsCount - indexPath.row - 1], indexPath: indexPath, geocoder: GeocoderAPI())

        }
        
        
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
        
        guard let titlePlace = searchBar.text else {
            return
        }
        print(titlePlace)
        
        for location in favoriteLocations {
            if location.lowercased() == titlePlace.lowercased() {
                favoriteLocations.remove(at: favoriteLocations.firstIndex(of: location)!)
                favoriteLocationsCount -= 1
            }
        }
        
        favoriteLocationsCount += 1
        favoriteLocations.append(titlePlace)
        
        saveFavoriteLocations()
        tableView.reloadData()
        
        searchBar.text = ""
        
        searchBar.resignFirstResponder()
        
        tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.setSelected(true, animated: false)
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
