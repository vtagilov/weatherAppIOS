import UIKit
import CoreLocation


class ViewController: UIViewController, UpdateWeatherUIProtocol, GeocoderUpdateUIProtocol {
    
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
 
        
        NotificationCenter.default.addObserver(self, selector: #selector(newLocation(_:)), name: NSNotification.Name("newLocation"), object: nil)

    }
    

    
    
    @objc func avaliableLocation() {
        weatherAPI.makeWeatherAPIRequest(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
        
    }
    
    @objc func newLocation(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let lat = userInfo["lat"] as? Double
            let lon = userInfo["lon"] as? Double
            let displayName = userInfo["display_name"] as? String
            if lat != nil && lon != nil {
                weatherAPI.makeWeatherAPIRequest(latitude: lat!, longitude: lon!)
                
                if displayName != nil {
                    var newTitle = ""
                    
                    for char in displayName! {
                        if char == "," {
                            break
                        }
                        newTitle.append(char)
                    }
                    print(newTitle)
                    self.title = newTitle
                    
                }
                
                
                
                
                
                
            }
            
        }
            
            
        
        
        
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
        
        
        
        let locationListButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(selectLocationButtonFunc))
        
        
        updateWeatherButton.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        
        self.navigationItem.leftBarButtonItem = locationListButton
        
        
    }
    
    
    
    //MARK: ButtonsTargets
    
    @objc func selectLocationButtonFunc(_ sender: UIButton) {
        

        
        navigationController?.viewControllers.append(LocationSelectorVC())
    }
    
    
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
            print("setLastWeather -> setWeatherUI")
            setWeatherUI(weather: weather)
            weatherAPI.isPlaced = true
        } else {
            return
        }
    }
    
}



