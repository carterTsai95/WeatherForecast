//
//  UIApplication+Extension.swift
//  WeatherForecast
//
//  Created by Hung-Chun Tsai on 2021-05-08.
//

import UIKit

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
