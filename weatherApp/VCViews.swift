import Foundation
import UIKit

class VCViews {
    
    var temperatureLabel = UILabel()
    var windSpeedLabel = UILabel()
    var currentTimeLabel = UILabel()
    var weatherDescriptionLabel = UILabel()
    var weatherTimeScrollView = UIScrollView()
    var weatherTimeLabels: [UILabel] = []
    var locationsButton = UIButton()
    
    let backgroundColour = UIColor.white
    
    
    static let scrollViewItemLenght: CGFloat = 75
    
    
    
    
    
    func setTemperatureLabel() {
        
    }
    func configure(weather: OpenMeteoResponse) {
        
        
        temperatureLabel = {
            
            let label = UILabel()
            
            label.text = String(weather.current_weather.temperature) + "°C"
            
            if label.text!.first != "-" {
                label.text = "+" + label.text!
            }
            
            
            label.font = UIFont.systemFont(ofSize: 60)
            label.textColor = .black
            label.textAlignment = .center
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontForContentSizeCategory = true
            label.adjustsFontSizeToFitWidth = true
            
            return label
        }()
        
        
        
        windSpeedLabel = {
            let label = UILabel()
            label.text = String(weather.current_weather.windspeed) + " м/с"
            label.textColor = .black
            label.textAlignment = .center
            
            label.font = UIFont.systemFont(ofSize: 30)
            
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        
        currentTimeLabel = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let timeString = formatter.string(from: Date())
            
            let label = UILabel()
            label.text = "на " + timeString
            label.textColor = .black
            label.textAlignment = .center
            
            label.font = UIFont.systemFont(ofSize: 20)
            
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        weatherDescriptionLabel = {
            let label = UILabel()
            
            label.text = weatherCodes[weather.current_weather.weathercode] ?? ""
            
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 2
            label.font = UIFont.systemFont(ofSize: 20)
            
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        
        weatherTimeScrollView = {
            let scrollView = UIScrollView()
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.contentSize = CGSize(width: 23 * (VCViews.scrollViewItemLenght + 3) - 3, height: VCViews.scrollViewItemLenght)
            scrollView.backgroundColor = .black
            scrollView.bounces = false
            
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            return scrollView
        }()
        
        
        
        
        
        for i in (1 ..< weather.hourly.time.count - 1) {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            
            guard weatherTimeLabels.count != 23 else { break }
            
            var timeString = weather.hourly.time[i]
            
            guard let date = formatter.date(from: timeString) else { return }
            
            if date.timeIntervalSince1970 < Date().timeIntervalSince1970 { continue }
            
            
            formatter.dateFormat = "HH:mm"
            timeString = formatter.string(from: date)
            
            let oneWeatherlabel = UILabel()
            
            oneWeatherlabel.text = timeString + "\n\n" + String(weather.hourly.temperature_2m[i]) + "°C"
            oneWeatherlabel.numberOfLines = 4
            oneWeatherlabel.font = UIFont.systemFont(ofSize: 15)
            oneWeatherlabel.backgroundColor = backgroundColour
            oneWeatherlabel.textAlignment = .center
            
            oneWeatherlabel.translatesAutoresizingMaskIntoConstraints = false
            oneWeatherlabel.adjustsFontForContentSizeCategory = true
            oneWeatherlabel.adjustsFontSizeToFitWidth = true

            self.weatherTimeLabels.append(oneWeatherlabel)
            
        }
        

        
        
    }
    
    
    
    
    func updateData(weather: OpenMeteoResponse) {
        
    }
    
}
