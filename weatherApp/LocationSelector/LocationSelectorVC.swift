import UIKit
import CoreLocation


class LocationSelectorVC: UIViewController {
    
    var views = LocationSelectorViews()
    var constraints = LocationSelectorConstraints()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        views.configure()
        constraints.activateConstraints(mainView: &self.view, views: views)
        setClearHistoryButton()
    }
    
    
    

    fileprivate func setClearHistoryButton() {
        
        let clearHistoryButton = UIBarButtonItem(barButtonSystemItem: .undo     , target: self, action: #selector(setClearHistoryButtonFunc))
        
        
//        clearHistoryButton.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        
        self.navigationItem.rightBarButtonItem = clearHistoryButton
        
    }
    
    
    @objc func setClearHistoryButtonFunc(_ sender: UIButton) {
        views.favoriteLocations = []
        views.favoriteLocationsCount = 0
        
        views.tableView.reloadData()
    }
}


