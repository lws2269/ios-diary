//
//  Weather.swift
//  Diary
//
//  Created by leewonseok on 2023/01/03.
//

import Foundation

struct WeatherInfo: Codable {
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
