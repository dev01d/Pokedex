//
//  Service.swift
//  Pokedex
//
//  Created by Jason Behnke on 7/11/19.
//  Copyright © 2019 Jason Behnke. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    let BASE_URL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    func fetchPokemon() {
                
        guard let url = URL(string: BASE_URL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
//          handle error
            if let error = error {
                print("Failed to fetch error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let resultsArray = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else { return }
                
                for (key, result) in resultsArray.enumerated() {
                    if let dictionary = result as? [String: AnyObject] {
                        let pokemon = Pokemon(id: key, dictionary: dictionary)
                        print(pokemon.name)
                    }
                }
                
            } catch let error {
                print("Failed to create json with error: ", error.localizedDescription)
            }
 
            
        }.resume()
    }
    
}
