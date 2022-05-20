import Foundation


enum JsonSyncError: Error {
 
}


//protocol JSONSyncable: Decodable {
//    static func sync(url: URL, completion: ((Result<Void, Error>) -> Void)?)
//}
//
//extension JSONSyncable {
//    static func sync(url: URL, completion: ((Result<Void, Error>) -> Void)?) {
//        
//    }
//}


final class JsonSync {
    
    let urlReq: URLRequest
    var dataTask: URLSessionDataTask?
    var json: [String : Any]?
    
    init(jsonURL: URL) {
        self.urlReq = URLRequest(url: jsonURL)
    }
    
    func sync(completion: ((Result<Self, Error>) -> Void)?) {
        if let dataTask = dataTask {
            dataTask.cancel()
        }
        
        dataTask = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            self.dataTask = nil
            guard let data = data else { return }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                self.json = json
                
                if let name = json["name"] as? String {
                    print(name) // hyeon
                }
            } else {
                
            }
        }
        dataTask?.resume()
    }
    
//    func setBool(key: String, value: Bool) {
//        
//    }
//    
//    func getBool(key: String) -> Bool? {
//        
//    }
//    
//    func setInt(key: String, value: Int) {
//        
//    }
//    
//    func getInt(key: String) -> Int? {
//        
//    }
//    
//    func float(key: String) -> Float? {
//        
//    }
//    
//    func string(key: String) -> String? {
//        
//    }
}
