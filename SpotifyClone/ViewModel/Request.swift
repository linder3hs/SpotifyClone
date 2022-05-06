//
//  Request.swift
//  SpotifyClone
//
//  Created by Linder Anderson Hassinger Solano    on 6/05/22.
//

import Foundation

class Request {
    
    let token = "BQChO8rdvvhsvF-_9zagbSRD5pk2ZTkLL6g5uRVKyiGpQQaGTtFlBWthGrzzSJnenbVnSJlOBXoSWMgIS0JwVOPQkJACbcrTY2IevkJYfUjgGsl49cEzGCGqVJgkAe9dREYztSX8euwrHX62vVURZb9rMk2McJe3ovA"
    
    let BASE_URL = "https://api.spotify.com/v1/"
    
    // ojo recuerden que si un type tiene el ? es porque puede ser nil
    // en este caso estamos diciendo que nuestra funcion retorna un Data o nil
    func getDataFromAPI(url: String) async -> Data? {
        do {
            var request = URLRequest(url: HelperString.getURLFromString(url: "\(BASE_URL)\(url)")!)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            return data
        } catch {
            return nil
        }
    }
}
