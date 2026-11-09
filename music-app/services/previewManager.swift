//
//  previewManager.swift
//  music-app
//
//  Created by melina  on 06.11.26.
//

import Foundation

struct PreviewManager  {
    
    
    
    func fetchPreview (songName : String , singer : String, completion : @escaping (String?,Error?) -> Void) {
        let term = "\(singer) \(songName)"
        guard let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(nil, nil)
            return
        }
        let urlString = "https://itunes.apple.com/search?term=\(encodedTerm)&entity=song&limit=1"
        
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task =  session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(nil,error )
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(PreviewData.self, from: data)
                    completion(decodedData.results.first?.previewUrl , nil)
                    
                } catch {
                    completion( nil , error )
                }
                
                
            }
        }
        
        task.resume()
    }
    
    
    
    
}
