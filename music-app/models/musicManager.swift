import Foundation

//پس به جای اینکه ViewController برود و جواب را بخواند، باید MusicManager هر وقت جواب آمد خودش به ViewController خبر بدهد
protocol MusicManagerDelegate  {
    func didUpdateMusic(results : [ResultData])
}

nonisolated struct MusicManager {
    
    var delegate : MusicManagerDelegate?
    
    let musicURL = "https://api.spotify.com/v1/search"
    let accessToken = "BQDu0XstoP-Sj4oRVavyvnsqij6TBFSEqlgD6Owf2NW0-mRmvxgbD_tyswylTQ_Cxe5XtAR7WlePssYIvK_x-4lK8bRa7njS3nkI48uOpjxyOuJ45HsJdoME3NapyvHUSPAdipT9CzQX"

    func fetchMusic(musicName: String) {
        let urlString = "\(musicURL)?query=\(musicName)&type=track&limit=5"
        performRequest(address: urlString)
    }

    func performRequest (address:String) {
//اول url رو میسازسم
        //بعدش برای اون url, request درست میکنیم
        // بعدش به اون request ارسال میکنیم با سشن
        // بعد کاری که باید انجام بشه رو ست میکنیم با data task


        if let url = URL(string: address) {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    self.parseJson(musicData: safeData)
                
                }
                
              
            }
            task.resume()
        }
        

       
    }
    
    func parseJson (musicData : Data) {
        let decoder = JSONDecoder()
    
        do {
           let decodedData = try decoder.decode(MusicData.self, from: musicData)
           let results = decodedData.tracks.items.map{
                let artists = $0.artists.map{
                    let artistName = $0.name
                    return artistName
                }.joined(separator: ", ")
                
                let result = ResultData(title:$0.name, artist:artists, image: $0.album.images.first?.url)
                return result
            
            }
            DispatchQueue.main.async {
                self.delegate?.didUpdateMusic(results: results)

            }

        }
        catch {
            print(error)
        }
    }
}
  
