import Foundation


protocol UpdateWeatherUIProtocol {
    
    func setWeatherUI(weather: OpenMeteoResponse)
    func updateWeatherUI(weather: OpenMeteoResponse)
    
}

protocol GeocoderUpdateUIProtocol {
    
    func updateWeatherUIWithGeocoder(place: Adress)

}

extension ViewController: UpdateWeatherUIProtocol {
    
    func setWeatherUI(weather: OpenMeteoResponse) {
        print("setWeatherUI")
        
        views.configure(weather: weather)
        
        constarints.activateConstraints(mainView: &self.view, views: views)
        
        saveLastWeather(weather: weather)
    }
    
    
    func updateWeatherUI(weather: OpenMeteoResponse) {
        print("updateWeatherUI")
        
        views.updateData(weather: weather)
        
        saveLastWeather(weather: weather)
    }
    

    
}

