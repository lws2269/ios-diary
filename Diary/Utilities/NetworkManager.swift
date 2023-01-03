//
//  NetworkManager.swift
//  Diary
//
//  Created by leewonseok on 2023/01/03.
//

import Foundation

func testfunc() {
    NetworkManager.shared.fetchWeatherData(lat: "37.591044371951206", lon: "126.98934531676166") { weather in
        guard let weather else { return }
        NetworkManager.shared.fetchIconData(iconCode: weather.icon) { data in
//            print(UIImage(data: data))
        }
    }
}
struct NetworkManager {
    static let shared = NetworkManager()

    let apiKey = "9724e2b2877f4efc388e9d60713b532b"
    
    private init () { }
    
    func fetchWeatherData(lat: String, lon: String, completion: @escaping (Weather?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        
        guard let url: URL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("response error")
                return
            }
            
            guard let data = data else {
                print("empty data")
                return
            }
            
            let weatherInfo: WeatherInfo? = try? JSONDecoder().decode(WeatherInfo.self, from: data)
            
            completion(weatherInfo?.weather.first)
        
        }.resume()

    }
    
    func fetchIconData(iconCode: String, completion: @escaping (Data) -> Void) {
        let urlString = "https://openweathermap.org/img/wn/\(iconCode).png"
        
        guard let url: URL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("response error")
                return
            }
            
            guard let data else {
                print("empty data")
                return
            }
            
            completion(data)
        }.resume()
    }
}
