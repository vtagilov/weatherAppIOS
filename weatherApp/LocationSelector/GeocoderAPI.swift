import Foundation
import UIKit



struct Adress: Codable {
    let lat: String
    let lon: String
    let display_name: String
}



class GeocoderAPI: NSObject, URLSessionTaskDelegate {
    
    var delegate: GeocoderUpdateUIProtocol?
    
    var title: String?
    
    func makeGeocoderAPIRequest(title: String) {
        self.title = title
        print("makeGeocoderAPIRequest - \(title)")

        let urlString = "https://nominatim.openstreetmap.org/search/\(title)?format=json"
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { print("encodedString = urlString"); return }
        
        guard let url = URL(string: encodedString) else { print("url != url"); return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let data = data else { print("data != data"); return }
            print(data)
            
            guard let place = self.parseGeocoderAPIResponse(data: data) else { print("place isn't parsing"); return }
                        
            DispatchQueue.main.async {
               
                self.delegate?.updateWeatherUIWithGeocoder(place: place)

                
            }
            
            
        })
        task.resume()
    }
    
    
    
    fileprivate func parseGeocoderAPIResponse(data: Data) -> Adress? {
        let decoder = JSONDecoder()

        do {
            
            let response = try decoder.decode([Adress].self, from: data)
            if response.count == 0 {
                DispatchQueue.main.async {

                    NotificationCenter.default.post(name: Notification.Name("setAlert.WrongPlace"), object: nil, userInfo: ["title": self.title!])
                    
                }
                return nil
            }
            return response[0]
        } catch {
            print("Error parsing Adress API response: \(error.localizedDescription)")
            return nil
        }
    }
    
    
}
