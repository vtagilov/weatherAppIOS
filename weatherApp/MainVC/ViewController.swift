import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    var lastUpdateTime = Date().timeIntervalSince1970

    let backgroundColour = UIColor.white
    
    let locationManager = LocationManager()
    var location = CLLocation()
    let weatherAPI = WeatherAPI()

    let views = VCViews()
    let constarints = VCConstraints()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(avaliableLocation), name: NSNotification.Name("avaliableLocation"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newLocation(_:)), name: NSNotification.Name("newLocation"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeatherLocationNotification), name: NSNotification.Name("updateWeatherLocationNotification"), object: nil)

        
        self.title = "Your Location"
        
        self.view.backgroundColor = backgroundColour
        weatherAPI.delegate = self
        
        setMainUI()
        
        setLastWeather()
        
        locationManager.updateLocation()
        

    }
    
}



//  MARK: Set UI
extension ViewController {
    
    fileprivate func setMainUI() {
        setNavigationButton()
    }
    
    
    fileprivate func setNavigationButton() {
        
        let updateWeatherButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateWeatherButtonFunc))
        self.navigationItem.rightBarButtonItem = updateWeatherButton
        
        let locationListButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(selectLocationButtonFunc))
        self.navigationItem.leftBarButtonItem = locationListButton
    }
    

    
    @objc func selectLocationButtonFunc(_ sender: UIButton) {
        navigationController?.viewControllers.append(LocationSelectorVC())
    }
    
    
    @objc func updateWeatherButtonFunc(_ sender: UIButton) {
        
        if Double(Date().timeIntervalSince1970 - lastUpdateTime) > 20 {
            lastUpdateTime = Date().timeIntervalSince1970
            if self.title == "Your Location" {
                locationManager.updateLocation()
            } else {
                weatherAPI.makeWeatherAPIRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
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


//  MARK: Notifications
extension ViewController {
    
    @objc func avaliableLocation() {
        self.title = "Your Location"
        weatherAPI.makeWeatherAPIRequest(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
        
        lastUpdateTime = Date().timeIntervalSince1970

        
    }
    
    
    
    @objc func newLocation(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let lat = userInfo["lat"] as? Double
            let lon = userInfo["lon"] as? Double
            let displayName = userInfo["display_name"] as? String
            if lat != nil && lon != nil {
                weatherAPI.makeWeatherAPIRequest(latitude: lat!, longitude: lon!)
                location = CLLocation(latitude: lat!, longitude: lon!)
                
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
    
    @objc func updateWeatherLocationNotification() {
        navigationController?.popViewController(animated: true)
        if self.title == "Your Location" {
            
            weatherAPI.makeWeatherAPIRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

            
        } else {
            
            locationManager.updateLocation()
            self.title = "Your Location"
            
        }
        
    }
    
}

