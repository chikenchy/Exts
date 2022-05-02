import XCTest
@testable import Extensions
@testable import MVVM
@testable import Bases

final class ExtsTests: XCTestCase {
    func testExample() throws {
//        XCTAssertEqual(Exts().text, "Hello, World!")
        
//        Config.sync(url: URL(string: "")!) { result in
//            switch result {
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            case .success(let config):
//                print(config)
//            }
//        }
    }
}


//struct Config: JSONSyncable {
//    var latestVersion: String
//
//}

//struct SendChatReq: HTTPPostable {
//
//}

struct ChatReq: Codable {
    
}

enum ChatAPI {
    case postChat(chatReq: ChatReq)
}


protocol NetworkProviderable {
    var enableDummyJSON: Bool { get }
    var dummyJSON: String? { get }
}

extension ChatAPI: NetworkProviderable {
    
    var enableDummyJSON: Bool {
        switch self {
        case .postChat(_):
            return true
        }
    }
    
    var dummyJSON: String? {
        switch self {
        case .postChat(_):
            return ""
        }
    }
}


//let chatAPI = NetworkProvider<ChatAPI>()
//chatAPI.requestData(.getChats(), retryCount: 3) { result, response in
//    
//}
//
//chatAPI.requestJSON(.getChats, retryCount: 3) { result, response in
//    switch result {
//    case .failure(let error):
//    case .success(let json):
//}
//
//chatAPI.requestDecodable(Chat.self, .getChats, retryCount: 3) { result, response in
//    
//}
//
//class NetworkProvider<API> {
//    
//    @discarableResult
//    func request(_ api: API, completion: ((Result<Response, Error>) -> Void)?) -> Cancelable {
//        if api.enableDummyJSON,
//           let dummyJSON = api.dummyJSON,
//           let data = dummyJSON.data(using: .utf8)
//            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
//            
//        } else {
//            
//        }
//    }
//}
