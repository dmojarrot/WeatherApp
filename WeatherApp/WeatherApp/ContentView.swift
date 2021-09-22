//
//  ContentView.swift
//  WeatherApp
//
//  Created by Diego Mojarro on 20/09/21.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct Home: View{
    @State var city: String = ""
    @State var cityName: String = ""
    @State var weather: String = ""
    @State var tempMin: String = ""
    @State var tempMax: String = ""
    @State var country: String = ""
    @State var description: String = ""
    @StateObject var locationManager = LocationManager()
    
    
    @State var isCityEmpty: Bool = false
    @ObservedObject var data = ViewModel()
    
    var body: some View{
        ZStack{
            Color("background").edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    HStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text("WeatherApp")
                            .font(.title)
                            .bold()
                            .padding(.top, 20)
                    }.padding(.bottom,20)
                    
                    HStack {
                        Button(action: {lookData(city: city)}, label: {
                            Image(systemName: "magnifyingglass").foregroundColor(city.isEmpty ? Color.gray : Color.blue )
                        }).alert(isPresented: $isCityEmpty) {
                            Alert(title: Text("Error"), message: Text("Couldn't find that city "), dismissButton: .default(Text("Understood")))
                        }
                        
                        
                        ZStack(alignment: .leading){
                            if city.isEmpty { Text("Look for a city").foregroundColor(Color(red: 174/255, green: 177/255, blue: 185/255, opacity: 1.0)) }
                            
                            TextField("", text: $city)
                            
                        }
                        Button(action: {lookDataLonLat()}, label: {
                            Image(systemName: "location").foregroundColor(Color.blue)
                        })
                    }.padding().background(Color(UIColor.systemBackground))
                    .clipShape(Capsule()).padding(.horizontal,30).padding(.bottom,20)
                }
                VStack(alignment: .center){
                    Text("\(cityName) \(country)")
                        .font(.title)
                        .bold()
                    Text(description)
                        .font(.callout)
                        .fontWeight(.light)
                    Text(weather)
                        .font(.largeTitle)
                        .bold()
                    HStack {
                        Text(tempMin)                        .fontWeight(.light)
                        
                        Text(tempMax)
                            .fontWeight(.light)
                        
                        
                    }
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            
        }
    }
    
    func lookDataLonLat(){
        CLLocationManager().requestWhenInUseAuthorization()
        var latitude: String {
            return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
        }
        
        var longitude: String {
            return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
        }
        
        print(latitude,longitude)
        
        
        data.searchLatLon(lat: latitude, lon: longitude)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            if data.cityInfo.count == 0{
                isCityEmpty = true
            }else{
                cityName = (String(data.cityInfo[0].name)+",")
                country = String(data.cityInfo[0].sys.country)
                weather = (String(data.cityInfo[0].main.temp)+"º")
                description = String(data.cityInfo[0].weather[0].description)
                tempMin = ("L:"+String(data.cityInfo[0].main.temp_min)+"º")
                tempMax = ("H:"+String(data.cityInfo[0].main.temp_max)+"º")
                
            }
        }
        
    }
    
    func lookData(city: String){
        data.search(city: city)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            if data.cityInfo.count == 0{
                isCityEmpty = true
            }else{
                cityName = (String(data.cityInfo[0].name)+",")
                country = String(data.cityInfo[0].sys.country)
                weather = (String(data.cityInfo[0].main.temp)+"º")
                description = String(data.cityInfo[0].weather[0].description)
                tempMin = ("L:"+String(data.cityInfo[0].main.temp_min)+"º")
                tempMax = ("H:"+String(data.cityInfo[0].main.temp_max)+"º")
                
            }
        }
        
    }
}

struct CityWeather: View{
    var body: some View{
        Image("")
        Text("City Name")
        Text("Temperature")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
        
    }
}
