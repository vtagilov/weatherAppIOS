import Foundation
import UIKit


extension LocationSelectorVC {

    func setMainUI() {
        
        LocationSelectorViews().configure()
        
    }
    
}

class LocationSelectorViews {
    
    
    var tableView = UITableView()
    var searchBar = UISearchBar()
    
    
    func configure() {
        searchBar = {
            searchBar = UISearchBar()
            searchBar.text = "text"
            searchBar.backgroundColor = .brown
            
            return searchBar
        }()
        
        tableView = {
           tableView = UITableView()
            tableView.backgroundColor = .gray
            
            return tableView
        }()
        
        
    }
    
}
