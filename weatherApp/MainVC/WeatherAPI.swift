import Foundation


struct OpenMeteoResponse: Codable {
    let current_weather: Weather
    let hourly: Forecast
}

struct Weather: Codable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
}

struct Forecast: Codable {
    let time: [String]
    let temperature_2m: [Double]
}




class WeatherAPI: NSObject, URLSessionTaskDelegate {
    
    var isPlaced = false
    
    var delegate: UpdateWeatherUIProtocol?
    
    
    func makeWeatherAPIRequest(latitude: Double, longitude: Double) {
        print("makeWeatherAPIRequest")

        let urlString = "https://api.open-meteo.com/v1/forecast" + "?latitude=\(latitude)&longitude=\(longitude)" + "&hourly=temperature_2m&current_weather=true" + "&windspeed_unit=ms&timezone=auto"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let data = data else { return }
            print(data)
            guard let weather = self.parseOpenMeteoAPIResponse(data: data) else { return }
                        
            DispatchQueue.main.async {
                
                if self.isPlaced == false {
                    self.delegate?.setWeatherUI(weather: weather)
                    self.isPlaced = true
                } else {
                    self.delegate?.updateWeatherUI(weather: weather)
                }
                
            }
            
            
        })
        task.resume()
    }
    
    
    
    fileprivate func parseOpenMeteoAPIResponse(data: Data) -> OpenMeteoResponse? {
        let decoder = JSONDecoder()

        do {
            let response = try decoder.decode(OpenMeteoResponse.self, from: data)
            return response
        } catch {
            print("Error parsing OpenMeteo API response: \(error.localizedDescription)")
            return nil
        }
    }
    
    
}
