//
//  RicknMortyService.swift
//  MVVM RickandMorty
//
//  Created by Halimcan Dayal on 18.03.2022.
//

import Alamofire

enum RicknMortyServiceEndPoint: String {
    
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRicknMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void)
}

struct RickMortyService: IRicknMortyService {
    
    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RicknMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }

}
