import Foundation


protocol UpdateWeatherUIProtocol {
    
    func setWeatherUI(weather: OpenMeteoResponse)
    func updateWeatherUI(weather: OpenMeteoResponse)
    
}

protocol GeocoderUpdateUIProtocol {
    
    func updateWeatherUIWithGeocoder(place: Adress)

}

extension ViewController {
    
    func setWeatherUI(weather: OpenMeteoResponse) {
        print("setWeatherUI")
        
        views.configure(weather: weather)
        
        constarints.activateConstraints(mainView: &self.view, views: views)
        
        saveLastWeather(weather: weather)
    }
    
    
    func updateWeatherUI(weather: OpenMeteoResponse) {
        
        views.updateData(weather: weather)
        
        saveLastWeather(weather: weather)
    }
    

    
}


extension ViewController {
    
    func updateWeatherUIWithGeocoder(place: Adress) {
        print("updateWeatherUI(place)")
        print(place.lat, place.lon)
        
        navigationController?.viewControllers.removeLast()
        weatherAPI.makeWeatherAPIRequest(latitude: Double(place.lat) ?? 0, longitude: Double(place.lon) ?? 0)

    }
}
