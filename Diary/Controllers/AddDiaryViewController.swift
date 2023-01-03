//
//  AddDiaryViewController.swift
//  Diary
//
//  Created by jin on 12/22/22.
//

import UIKit
import CoreLocation

final class AddDiaryViewController: DiaryViewController {
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        fetchCurrentLocation()
    }

    override func configureNavigationItem() {
        super.configureNavigationItem()
        let currentDate = DateFormatter.conversionLocalDate(date: Date(), locale: .current, dateStyle: .long)
        self.navigationItem.title = currentDate
    }
    
    func fetchCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocation
extension AddDiaryViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        NetworkManager.shared.fetchWeatherData(lat: locValue.latitude.description, lon: locValue.longitude.description) { weather in
            self.iconCode = weather?.icon
        }
    }
}
