import Foundation

struct MusicManager {
    let musicURL = "https://api.spotify.com/v1/search"
    let accessToken = "BQD3J8uSii1SQM9TerH0CC-BQKZ7VQ5kt6oKVa3C_VhzJZ3oItTCR-SyjkbJcaGFxXQ_Dxk0ll6sBJd6TAH5lVw590PJczfS7Lm9KaQI8jVyme_U1hczPGahY81iAHs3lj-U0TGjiAtp"

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
