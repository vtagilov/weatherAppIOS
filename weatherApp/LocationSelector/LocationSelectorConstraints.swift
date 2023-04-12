import Foundation
import UIKit


class LocationSelectorConstraints {
    
    var searchBarConstraints = [NSLayoutConstraint]()
    var tableViewConstraints = [NSLayoutConstraint]()
    
    var locationButtonConstraints = [NSLayoutConstraint]()
    
    
    func activateConstraints(mainView: inout UIView, views: LocationSelectorViews) {
        
        mainView.addSubview(views.searchBar)
        
        searchBarConstraints = [
            views.searchBar.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 10),
            views.searchBar.bottomAnchor.constraint(equalTo: views.searchBar.topAnchor, constant: 50),
            views.searchBar.rightAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.rightAnchor, constant: -50),
            views.searchBar.leftAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leftAnchor, constant: 0)
        ]
        
        
        mainView.addSubview(views.locationButton)
        
        locationButtonConstraints = [
            views.locationButton.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 10),
            views.locationButton.bottomAnchor.constraint(equalTo: views.locationButton.topAnchor, constant: 50),
            
            views.locationButton.leftAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.rightAnchor, constant: -50),
            
            views.locationButton.rightAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.rightAnchor, constant: 0)
        ]
        
        
        
        mainView.addSubview(views.tableView)
        
        tableViewConstraints = [
            views.tableView.topAnchor.constraint(equalTo: views.searchBar.bottomAnchor, constant: 10),
            views.tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            views.tableView.rightAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.rightAnchor, constant: 0),
            views.tableView.leftAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leftAnchor, constant: 0)
        ]
        
        
        
        
        
        
        NSLayoutConstraint.activate(searchBarConstraints + locationButtonConstraints + tableViewConstraints)
    }
    
}
