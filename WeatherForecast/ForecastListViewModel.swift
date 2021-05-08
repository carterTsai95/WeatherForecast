//
//  ForecastListViewModel.swift
//  WeatherForecast
//
//  Created by Hung-Chun Tsai on 2021-05-08.
//

import Foundation
import CoreLocation

class ForecastListViewModel: ObservableObject {
    @Published var forecasts: [ForecastViewModel] = []
    var location: String = ""
    
    func getWeatherForecast() {
        let apiService = APIService.shared
        
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                // Don't forget to use your own key
                        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=f67cda0b893737623cc1cc52f3ff0aac",
                                           dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIService.APIError>) in
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async{
                            self.forecasts = forecast.daily.map {ForecastViewModel(forecast: $0)}
                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                }
            }
        }

    }
    
}
