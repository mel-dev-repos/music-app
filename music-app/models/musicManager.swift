import Foundation

struct MusicManager {
    let musicURL = "https://api.spotify.com/v1/search"
    let accessToken = "BQA0JkY_SNXeBq291gw-VoWgeF56AltV_STJtWfO-Aesvl9HXhyHwBj3ky1_RE636tU3o4VT3T5pY0M3759uqbgBoNRzsH4XX2TxWgecfoBKwKWQwP4IvXfywxy8PSsrEp7grU2kYbF"

    func fetchMusic(musicName: String) {
        let urlString = "\(musicURL)?query=\(musicName)&type=track&limit=5"
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String) {
        if let url = URL( string:urlString) {
            
            var request = URLRequest (url :url)
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization" )
            
            let sesseion = URLSession (configuration: .default)
            
            let task = sesseion.dataTask(with: request) { data , response , error in
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data {
                    let jsonString = String(data :data , encoding: .utf8)
                    print(jsonString ?? "couldn't convert data to string")
                }
              
                
                
                
            }
            task.resume()
            
        }
       
        
    }
}
