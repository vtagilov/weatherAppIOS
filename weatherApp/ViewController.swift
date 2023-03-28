import UIKit
import CoreLocation


class ViewController: UIViewController, UpdateWeatherUIProtocol {

    
    let locationManager = LocationManager()
    let weatherAPI = WeatherAPI()
    
    
    var lastUpdateTime = Date().timeIntervalSince1970
    
    let location = CLLocation()

    let temperatureLabel = UILabel()
    let windSpeedLabel = UILabel()
//    let currentTimeLabel = UILabel()
//    let weatherDescriptionLabel = UILabel()
//
//    let weatherTimeScrollView = UIScrollView()
//    var weatherTimeLabels: [UILabel] = []
//
//    let locationsButton = UIButton()
//
//    let backgroundColour = UIColor.white
    
    
    
    var views: [UIView] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColour
        
        
        
//        locationManager.updateLocation()
        
        
        let temperatureLabel = UILabel()
        let windSpeedLabel = UILabel()
        
        views = [temperatureLabel, windSpeedLabel]
        
        
        
        
        
        
        
        
        
        
        setMainUI()
        weatherAPI.delegate = self
        
        
        weatherAPI.makeWeatherAPIRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        
        
        

        
        
        
    }
    
    
}



//MARK: Set Buttos, ButtonsTargets, Labels
extension ViewController {
    
    fileprivate func setMainUI() {
        setUpdateButton()
    }
    
    
    //MARK: Buttons
    
    fileprivate func setUpdateButton() {
        
        let updateWeatherButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateWeatherButtonFunc))
        
        
        updateWeatherButton.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        //        view.addSubview(updateWeatherButton)
        
        self.navigationItem.rightBarButtonItem = updateWeatherButton
        
        //        updateWeatherButton.addTarget(self, action: #selector(updateWeatherButtonFunc), for: .touchUpInside)
        
        
        
    }
    
    
    
    //MARK: ButtonsTargets
    
    @objc func updateWeatherButtonFunc(_ sender: UIButton) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeString = formatter.string(from: date)
        print("Current Time: \(timeString)")
        
        //            updateLocation()
        
        
        print(Double(Date().timeIntervalSince1970 - lastUpdateTime) > 60)
        
//        if Double(Date().timeIntervalSince1970 - lastUpdateTime) > 6 || temperatureLabel.text == nil {
//            lastUpdateTime = Date().timeIntervalSince1970
//            weatherAPI.makeWeatherAPIRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        }
        
    }
    
    
}



