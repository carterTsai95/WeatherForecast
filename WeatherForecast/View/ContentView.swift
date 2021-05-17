//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Hung-Chun Tsai on 2021-05-08.
//


import SDWebImageSwiftUI
import SwiftUI

struct ContentView: View {
    
    @StateObject private var forecastListVM = ForecastListViewModel()
    var body: some View {
        ZStack {
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
                        TextField("Enter Location", text: $forecastListVM.location,
                                  onCommit: {
                                    forecastListVM.getWeatherForecast()
                                  })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                Button(action: {
                                    forecastListVM.location = ""
                                    forecastListVM.getWeatherForecast()
                                }){
                                    Image(systemName: "xmark.circle")
                                }
                                .padding(.horizontal),alignment: .trailing
                            )
                                
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
                                WebImage(url: day.weatherIconURL)
                                    .resizable()
                                    .placeholder {
                                        Image(systemName: "hourglass")
                                    }
                                    .scaledToFit()
                                    .frame(width: 75)
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
                .alert(item: $forecastListVM.appError) { appAlert in
                    Alert(title: Text("Error"),
                          message: Text("""
                            \(appAlert.errorString)
                            Please try again later!
                            """
                          )
                    )
                }//:Alert
            }//:NavigationView
            if forecastListVM.isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView("Fetching Weather")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                        )
                        .shadow(radius: 10)
                }
                
            }
        }//:ZStack

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
