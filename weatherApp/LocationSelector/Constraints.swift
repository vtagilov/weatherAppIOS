import Foundation
import UIKit


class LocationSelectorConstraints {
    
    var searchBarConstraints = [NSLayoutConstraint]()
    var tableViewConstraints = [NSLayoutConstraint]()
    
    
    func activateConstraints(mainView: inout UIView, views: LocationSelectorViews) {
        
        mainView.addSubview(views.searchBar)
        
        searchBarConstraints = [
            views.searchBar.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0)
            views.searchBar.bottomAnchor.constraint(equalTo: views.searchBar.topAnchor, constant: 100)
            views.searchBar.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0)
            views.searchBar.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0)
        ]
    }
    
}
