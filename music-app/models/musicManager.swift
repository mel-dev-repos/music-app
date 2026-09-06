import Foundation

struct MusicManager {
    let musicURL = "https://api.spotify.com/v1/search"
    let accessToken = "BQAJKCS1bVDm-dWVG6iEga7F77VDE8K0u92I8_lJ6XPAAxKMR90AwShhz1aTckwyXyfccnLo3MipC4QJp7ZM7qRM-HZgrDagTIPRE94UT3gutvjSVJiE0I4uP1PjbnB2DLJbVh6HwLh6"

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
