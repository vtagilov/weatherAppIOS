import UIKit
import CoreLocation


class ViewController: UIViewController, UpdateWeatherUIProtocol {
    
    var lastUpdateTime = Date().timeIntervalSince1970

    let backgroundColour = UIColor.white
    
    let locationManager = LocationManager()
    let weatherAPI = WeatherAPI()
    let views = VCViews()
    let constarints = VCConstraints()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColour
        weatherAPI.delegate = self
        
        
        setMainUI()
        setLastWeather()
        
        locationManager.updateLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(avaliableLocation), name: NSNotification.Name("avaliableLocation"), object: nil)
        
        
        
        
        
        
        
    }
    
    
    
    @objc func avaliableLocation() {
        weatherAPI.makeWeatherAPIRequest(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
        
        
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
        
        self.navigationItem.rightBarButtonItem = updateWeatherButton
        
        
    }
    
    
    
    //MARK: ButtonsTargets
    
    @objc func updateWeatherButtonFunc(_ sender: UIButton) {
        
        if Double(Date().timeIntervalSince1970 - lastUpdateTime) > 60 {
            lastUpdateTime = Date().timeIntervalSince1970
            locationManager.updateLocation()
        } else {
            print("aсtual yet")
        }
        
    }
    
    
    func setLastWeather() {
        let weather = readLastWeather()
        if weather.hourly.temperature_2m.count != 0 {
            setWeatherUI(weather: weather)
        } else {
            return
        }
    }
    
}



