//
//  DataViewModel.swift
//  Lab_8
//
//  Created by Yatin Parulkar on 2025-08-15.
//

import Foundation
import Foundation

class DataViewModel: ObservableObject {
    @Published var items: [DataModel] = []
    
    func fetchData(){
        guard let url = URL(string: "https://689f7f306e38a02c5816759a.mockapi.io/api/image/Lab_8") else {
            print("URL Error")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Data Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode([DataModel].self, from: data)
                DispatchQueue.main.async {
                    self.items = decoded
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
