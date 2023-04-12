import Foundation
import UIKit



class LocationSelectorViews: NSObject, UISearchBarDelegate {
    
//    var delegate: GeocoderUpdateUIProtocol?
    var geocoder: GeocoderAPI? = nil
    
    var favoriteLocationsCount = 0
    var favoriteLocations = [String]()
    
    var tableView = UITableView()
    var searchBar = UISearchBar()
    
    var locationButton = UIButton()
    
    
    init(geocoder: GeocoderAPI) {
        self.geocoder = geocoder
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
        
        
        locationButton = {
           let locationButton = UIButton()
            
            locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
            locationButton.translatesAutoresizingMaskIntoConstraints = false
            locationButton.addTarget(self, action: #selector(myLocationButtonFunc), for: .touchUpInside)
            return locationButton
        }()
        
    }
    
}


extension LocationSelectorViews {
    
    @objc func myLocationButtonFunc() {
        print("myLocationButtonFunc")
        
        NotificationCenter.default.post(name: Notification.Name("updateWeatherLocationNotification"), object: nil)
        
        
    }
    
}



//  MARK: UITableViewDataSource
extension LocationSelectorViews: UITableViewDataSource {
    
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
    
}



//  MARK: UISearchBarDelegate
extension LocationSelectorViews {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let titlePlace = searchBar.text else {
            return
        }
        
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
}



//  MARK: Save&Read UserData
extension LocationSelectorViews {
    
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
