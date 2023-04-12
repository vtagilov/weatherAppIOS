import UIKit
import CoreLocation


class LocationSelectorVC: UIViewController, GeocoderUpdateUIProtocol {
    
    var constraints = LocationSelectorConstraints()
    
    let geocoder = GeocoderAPI()
    
    var views: LocationSelectorViews?
    
    private var presentAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geocoder.delegate = self
        
        views = LocationSelectorViews(geocoder: geocoder)
        views!.configure()
        
        constraints.activateConstraints(mainView: &self.view, views: views!)
        
        setClearHistoryButton()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(setAlertWrongPlaceNotification(_:)), name: NSNotification.Name("setAlert.WrongPlace"), object: nil)
    }
    
}




//  MARK: Set UI
extension LocationSelectorVC {
    
    fileprivate func setClearHistoryButton() {
        
        let clearHistoryButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(setClearHistoryButtonFunc))
        
        self.navigationItem.rightBarButtonItem = clearHistoryButton
        
    }
    
    
    @objc func setClearHistoryButtonFunc(_ sender: UIButton) {
        views!.favoriteLocations = []
        views!.favoriteLocationsCount = 0
        views?.saveFavoriteLocations()
        
        views!.tableView.reloadData()
    }
    
}




//  MARK: Notifications
extension LocationSelectorVC {
    
    @objc func setAlertWrongPlaceNotification(_ notification: Notification) {
        if self.presentAlert == false {
            self.presentAlert = true
            if let userInfo = notification.userInfo {
                
                
                
                let title = userInfo["title"] as? String
                
                let alert = UIAlertController(title: "Ошибка", message: "\(title!) нет в базе.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                    self.presentAlert = false
                    
                }
                
                alert.addAction(okAction)
                
                self.present(alert, animated: false)
                
                
                views!.favoriteLocationsCount -= 1
                
                views!.favoriteLocations.remove(at: views!.favoriteLocations.firstIndex(of: title ?? "") ?? 0)
                                
                views!.tableView.reloadData()
                views!.saveFavoriteLocations()

                
            }
        }
    }
    
}




//  MARK: Protools
extension LocationSelectorVC {
    
    func updateWeatherUIWithGeocoder(place: Adress) {
        print("updateWeatherUIWithGeocoder")
        print(place.lat, place.lon)
        navigationController?.viewControllers.removeLast()
        
        NotificationCenter.default.post(name: Notification.Name("newLocation"), object: nil, userInfo: ["lon": Double(place.lon) ?? 0, "lat": Double(place.lat) ?? 0, "display_name": place.display_name])
        
    }
    
}
