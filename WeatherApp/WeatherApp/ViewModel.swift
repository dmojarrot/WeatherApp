//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Diego Mojarro on 20/09/21.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var cityInfo = [Data]()
    
    func search(city: String){
        cityInfo.removeAll()
        
        let cityNameSPaces = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
        let APIKey = "237211e02d4369ba0b9bc89be88da973"
        let url = URL(string: "api.openweathermap.org/data/2.5/weather?q=\(cityNameSPaces ?? "London")&units=metric&appid=\(APIKey)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do{
                if let JSONData = data{
                    print("JSONSize: \(JSONData)")
                    
                    let decodedData = try JSONDecoder().decode(Results.self, from: JSONData)
                    
                    print("DecodedJSON: \(decodedData)")
                    
                    DispatchQueue.main.async {
                        self.cityInfo.append(contentsOf: decodedData.results)
                    }
                }else{
                    print("Null JSON")
                }
            }catch{
                print("error \(error)")
            }
        }.resume()
    }

}
