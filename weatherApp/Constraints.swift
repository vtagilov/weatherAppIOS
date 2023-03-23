import Foundation
import UIKit


extension ViewController {
    
    
    func updateMainWeatherUI(weather: OpenMeteoResponse) {
        print("updateMainWeatherUI")
        temperatureLabel.text = String(weather.current_weather.temperature) + "°C"
        
        windSpeedLabel.text = String(weather.current_weather.windspeed) + " м/с"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var timeString = formatter.string(from: Date())
        
        currentTimeLabel.text = "на " + timeString
        
        
        weatherDescriptionLabel.text = weatherCodes[weather.current_weather.weathercode] ?? ""
        
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        for i in (1 ..< weather.hourly.time.count - 1) {
            guard weatherTimeLabels.count != 23 else { return }
            
            timeString = weather.hourly.time[i]
            
            guard let date = formatter.date(from: timeString) else { return }
            
            if date.timeIntervalSince1970 < Date().timeIntervalSince1970 { continue }
            formatter.dateFormat = "HH:mm"
            timeString = formatter.string(from: date)
            
            weatherTimeLabels[i].text = timeString + "\n\n" + String(weather.hourly.temperature_2m[i]) + "°C"
            
        }
        
        
    }
    

func setWeatherUI(weather: OpenMeteoResponse) {
    print("setWeatherUI")
    
w    temperatureLabel.font = UIFont.systemFont(ofSize: 60)
    temperatureLabel.textColor = .black
    temperatureLabel.textAlignment = .center
    
    temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    temperatureLabel.adjustsFontForContentSizeCategory = true
    temperatureLabel.adjustsFontSizeToFitWidth = true
    
    self.view.addSubview(temperatureLabel)
    
    temperatureLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    temperatureLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    temperatureLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    temperatureLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    
    
    
    
    
    windSpeedLabel.text = String(weather.current_weather.windspeed) + " м/с"
    windSpeedLabel.textColor = .black
    windSpeedLabel.textAlignment = .center
    
    windSpeedLabel.font = UIFont.systemFont(ofSize: 30)
    
    windSpeedLabel.adjustsFontSizeToFitWidth = true
    windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(windSpeedLabel)
    
    windSpeedLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10).isActive = true
    windSpeedLabel.bottomAnchor.constraint(equalTo: windSpeedLabel.topAnchor, constant: 30).isActive = true
    windSpeedLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    windSpeedLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    
    
    
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    let timeString = formatter.string(from: Date())
    
    currentTimeLabel.text = "на " + timeString
    currentTimeLabel.textColor = .black
    currentTimeLabel.textAlignment = .center
    
    currentTimeLabel.font = UIFont.systemFont(ofSize: 20)
    
    currentTimeLabel.adjustsFontSizeToFitWidth = true
    currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(currentTimeLabel)
    
    currentTimeLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 10).isActive = true
    currentTimeLabel.bottomAnchor.constraint(equalTo: currentTimeLabel.topAnchor, constant: 30).isActive = true
    currentTimeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    currentTimeLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    
    
    
    weatherDescriptionLabel.text = weatherCodes[weather.current_weather.weathercode] ?? ""
    
    weatherDescriptionLabel.textColor = .black
    weatherDescriptionLabel.textAlignment = .center
    weatherDescriptionLabel.numberOfLines = 2
    weatherDescriptionLabel.font = UIFont.systemFont(ofSize: 20)
    
    weatherDescriptionLabel.adjustsFontSizeToFitWidth = true
    weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(weatherDescriptionLabel)
    
    weatherDescriptionLabel.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 10).isActive = true
    weatherDescriptionLabel.bottomAnchor.constraint(equalTo: weatherDescriptionLabel.topAnchor, constant: 70).isActive = true
    weatherDescriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
    weatherDescriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
    
    
    
    
    
    
    
    
    
    weatherTimeScrollView.contentSize = CGSize(width: 23 * (100 + 3) - 3, height: 100)
    
    weatherTimeScrollView.backgroundColor = .black
    weatherTimeScrollView.bounces = false
    
    self.view.addSubview(weatherTimeScrollView)
    
    weatherTimeScrollView.translatesAutoresizingMaskIntoConstraints = false
    
    weatherTimeScrollView.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 10).isActive = true
    weatherTimeScrollView.bottomAnchor.constraint(equalTo: weatherTimeScrollView.topAnchor, constant: 100).isActive = true
    weatherTimeScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    weatherTimeScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    
    
    for i in (1 ..< weather.hourly.time.count - 1) {
        guard weatherTimeLabels.count != 23 else { return }
        
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
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
        
        weatherTimeScrollView.addSubview(oneWeatherlabel)
        
        
        if weatherTimeLabels.count == 0 {
            
            oneWeatherlabel.topAnchor.constraint(equalTo: weatherTimeScrollView.topAnchor).isActive = true
            oneWeatherlabel.heightAnchor.constraint(equalTo: weatherTimeScrollView.heightAnchor).isActive = true
            oneWeatherlabel.leftAnchor.constraint(equalTo: weatherTimeScrollView.leftAnchor).isActive = true
            oneWeatherlabel.widthAnchor.constraint(equalTo: weatherTimeScrollView.heightAnchor).isActive = true
            
            weatherTimeLabels.append(oneWeatherlabel)
            
            continue
        }
        oneWeatherlabel.topAnchor.constraint(equalTo: weatherTimeScrollView.topAnchor).isActive = true
        oneWeatherlabel.heightAnchor.constraint(equalTo: weatherTimeScrollView.heightAnchor).isActive = true
        oneWeatherlabel.leftAnchor.constraint(equalTo: weatherTimeLabels[weatherTimeLabels.count - 1].rightAnchor, constant: 3).isActive = true
        oneWeatherlabel.widthAnchor.constraint(equalTo: weatherTimeScrollView.heightAnchor).isActive = true
        
        
        
        
        weatherTimeLabels.append(oneWeatherlabel)
        
        
        
        
        if weatherTimeLabels.count == 0 {
            let oneWeatherlabel = UILabel()
            
            
            oneWeatherlabel.text = timeString + "\n\n" + String(weather.hourly.temperature_2m[i]) + "°C"
            oneWeatherlabel.numberOfLines = 4
            oneWeatherlabel.font = UIFont.systemFont(ofSize: 15)
            oneWeatherlabel.backgroundColor = .systemBlue
            oneWeatherlabel.textAlignment = .center
            
            oneWeatherlabel.translatesAutoresizingMaskIntoConstraints = false
            oneWeatherlabel.adjustsFontForContentSizeCategory = true
            oneWeatherlabel.adjustsFontSizeToFitWidth = true
            
            weatherTimeScrollView.addSubview(oneWeatherlabel)
            
            
            
        } else {
            
            
            
            
        }
        
        
    }
    
    
}
    
}
