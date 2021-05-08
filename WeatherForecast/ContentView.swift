//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Hung-Chun Tsai on 2021-05-08.
//


import SwiftUI

struct ContentView: View {
    
    @StateObject private var forecastListVM = ForecastListViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $forecastListVM.system, label: Text("System")) {
                    Text("°C").tag(0)
                    Text("°F").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .padding(.vertical)
                HStack {
                    TextField("Enter Location", text: $forecastListVM.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        forecastListVM.getWeatherForecast()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }//:HStack
                
                List(forecastListVM.forecasts, id: \.day) { day in
                    VStack(alignment: .leading) {
                        Text(day.day)
                            .fontWeight(.bold)
                        HStack(alignment: .center) {
                            Image(systemName: "hourglass")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .frame(width: 50, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                            VStack(alignment: .leading){
                                Text(day.overview)
                                HStack {
                                    Text("High: \(day.high)")
                                    Text("Low: \(day.low)")
                                }
                                HStack{
                                    Text("Clouds: \(day.clouds)")
                                    Text("POP: \(day.pop)")
                                }
                                Text("Humidity: \(day.humidity)")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }//:VStack
            .padding(.horizontal)
            .navigationTitle("Mobile Weather")
        }
        
    }//:NavigationView
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
