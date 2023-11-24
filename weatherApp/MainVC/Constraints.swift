import Foundation
import UIKit







class VCConstraints {
    
    var temperatureLabelConstraints = [NSLayoutConstraint]()
    var windSpeedLabelConstraints = [NSLayoutConstraint]()
    var currentTimeLabelConstraints = [NSLayoutConstraint]()
    var weatherDescriptionLabelConstraints = [NSLayoutConstraint]()
    var weatherTimeScrollViewConstraints = [NSLayoutConstraint]()
    var weatherTimeLabelsConstraints = [[NSLayoutConstraint]]()
    var locationsButtonConstraints = [NSLayoutConstraint]()
    
    
    func activateConstraints(mainView: inout UIView, views: VCViews) {
        
        
        
        mainView.addSubview(views.temperatureLabel)
        temperatureLabelConstraints = [
            views.temperatureLabel.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 50),
            views.temperatureLabel.heightAnchor.constraint(equalToConstant: mainView.frame.height / 7),
            views.temperatureLabel.leftAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leftAnchor),
            views.temperatureLabel.rightAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.rightAnchor)
        ]
        
        
        mainView.addSubview(views.windSpeedLabel)
        windSpeedLabelConstraints = [
            views.windSpeedLabel.topAnchor.constraint(equalTo: views.temperatureLabel.bottomAnchor, constant: 10),
            views.windSpeedLabel.bottomAnchor.constraint(equalTo: views.windSpeedLabel.topAnchor, constant: 30),
            views.windSpeedLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            views.windSpeedLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor)
        ]
        
        
        mainView.addSubview(views.currentTimeLabel)
        currentTimeLabelConstraints = [
            views.currentTimeLabel.topAnchor.constraint(equalTo: views.windSpeedLabel.bottomAnchor, constant: 10),
            views.currentTimeLabel.bottomAnchor.constraint(equalTo: views.currentTimeLabel.topAnchor, constant: 30),
            views.currentTimeLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            views.currentTimeLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor)
        ]
        
        
        mainView.addSubview(views.weatherDescriptionLabel)
        weatherDescriptionLabelConstraints = [
            
            views.weatherDescriptionLabel.topAnchor.constraint(equalTo: views.currentTimeLabel.bottomAnchor, constant: 10),
            views.weatherDescriptionLabel.bottomAnchor.constraint(equalTo: views.weatherDescriptionLabel.topAnchor, constant: 70),
            views.weatherDescriptionLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 50),
            views.weatherDescriptionLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -50)
        ]
        
        
        mainView.addSubview(views.weatherTimeScrollView)
        weatherTimeScrollViewConstraints = [
            
            views.weatherTimeScrollView.topAnchor.constraint(equalTo: views.weatherDescriptionLabel.bottomAnchor, constant: 10),
            views.weatherTimeScrollView.bottomAnchor.constraint(equalTo: views.weatherTimeScrollView.topAnchor, constant: VCViews.scrollViewItemLenght),
            views.weatherTimeScrollView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            views.weatherTimeScrollView.rightAnchor.constraint(equalTo: mainView.rightAnchor)
            
        ]
        
        
        NSLayoutConstraint.activate(temperatureLabelConstraints + windSpeedLabelConstraints + currentTimeLabelConstraints + weatherDescriptionLabelConstraints + weatherTimeScrollViewConstraints)
        
        
        for i in 0..<views.weatherTimeLabels.count {
            
            let oneWeatherlabel = views.weatherTimeLabels[i]
            
            views.weatherTimeScrollView.addSubview(oneWeatherlabel)
            
            if i == 0 {
                weatherTimeLabelsConstraints.append([
                    oneWeatherlabel.topAnchor.constraint(equalTo: views.weatherTimeScrollView.topAnchor),
                    oneWeatherlabel.heightAnchor.constraint(equalTo: views.weatherTimeScrollView.heightAnchor),
                    oneWeatherlabel.leftAnchor.constraint(equalTo: views.weatherTimeScrollView.leftAnchor),
                    oneWeatherlabel.widthAnchor.constraint(equalTo: views.weatherTimeScrollView.heightAnchor)
                ])
            } else {
                weatherTimeLabelsConstraints.append([
                    
                    oneWeatherlabel.topAnchor.constraint(equalTo: views.weatherTimeScrollView.topAnchor),
                    oneWeatherlabel.heightAnchor.constraint(equalTo: views.weatherTimeScrollView.heightAnchor),
                    oneWeatherlabel.leftAnchor.constraint(equalTo: views.weatherTimeLabels[i-1].rightAnchor, constant: 3),
                    oneWeatherlabel.widthAnchor.constraint(equalTo: views.weatherTimeScrollView.heightAnchor)
                ])
            }
            NSLayoutConstraint.activate(weatherTimeLabelsConstraints.last!)
        }
        
        
        
    }
}
