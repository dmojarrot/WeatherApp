//
//  ContentView.swift
//  WeatherApp
//
//  Created by Diego Mojarro on 20/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct Home: View{
    @State var city: String = ""
    @State var weather: String = ""
    @State var isCityEmpty: Bool = false
    @ObservedObject var data = ViewModel()
    var body: some View{
        ZStack{
            Color("background").edgesIgnoringSafeArea(.all)
            VStack{
                Text("WeatherApp")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                Image("logo")
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
                }.padding().background(Color(UIColor.systemBackground))
                .clipShape(Capsule()).padding(.horizontal,30)
                Text(weather)
                
            }
        }
    }
    
    func lookData(city: String){
        data.search(city: city)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            if data.cityInfo.count == 0{
                isCityEmpty = true
            }else{
                weather = String( data.cityInfo[0].main.temp)
                
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
        
    }
}
