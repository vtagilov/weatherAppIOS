import UIKit
import CoreLocation


class LocationSelectorVC: UIViewController, GeocoderUpdateUIProtocol {
    
    func updateWeatherUIWithGeocoder(place: Adress) {
        print("updateWeatherUIWithGeocoder")
        print(place.lat, place.lon)
        navigationController?.viewControllers.removeLast()
        
        NotificationCenter.default.post(name: Notification.Name("newLocation"), object: nil, userInfo: ["lon": Double(place.lon) ?? 0, "lat": Double(place.lat) ?? 0, "display_name": place.display_name])
        
    }
    
    
    var constraints = LocationSelectorConstraints()
    
    let geocoder = GeocoderAPI()
    
    var views: LocationSelectorViews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        views = LocationSelectorViews(geocoder: geocoder)
        
        
        geocoder.delegate = self
        views!.configure()
        
        constraints.activateConstraints(mainView: &self.view, views: views!)
        setClearHistoryButton()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(setAlertWrongPlace), name: NSNotification.Name("setAlert.WrongPlace"), object: nil)

    }
    
    
    

    fileprivate func setClearHistoryButton() {
        
        let clearHistoryButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(setClearHistoryButtonFunc))
        
        
//        clearHistoryButton.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        
        self.navigationItem.rightBarButtonItem = clearHistoryButton
        
    }
    
    
    @objc func setClearHistoryButtonFunc(_ sender: UIButton) {
        views!.favoriteLocations = []
        views!.favoriteLocationsCount = 0
        
        views!.tableView.reloadData()
    }
}





extension LocationSelectorVC {
    
    @objc func setAlertWrongPlace() {
        let alert = UIAlertController(title: "Ошибка", message: "Данного места не существует", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }

        alert.addAction(okAction)

        present(alert, animated: true)
        
    }
    
    
    
}
