//
//  APIService.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/6/22.
//

import Foundation

struct ApiService {

    static let shared = ApiService()
    func fetchApiData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        print("*************")
        print("Endpoint url: \(url)")
        print("*************")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get data:", error)
                return
            }
            if let error = self.checkResponse(response: response, data: data) {
                DispatchQueue.main.async {
                    print("Error code : \(error.Code ?? "")")
                    print("Message : \(error.Message ?? "")")
                    completion(nil, error)
                }
            }
            if let responseData: T = self.handleSuccess(data: data) {
                DispatchQueue.main.async {
                    completion(responseData, nil)
                }
            }
        }.resume()

    }

    func handleSuccess<T: Decodable>(data: Data?) -> T? {
        guard let data = data else { return nil }
        do {
            let responseModel = try JSONDecoder().decode(T.self, from: data)
            return responseModel
        } catch let jsonErr {
            print("Failed to serialize json:", jsonErr)
        }
        return nil
    }

    func checkResponse(response: URLResponse?, data: Data?) -> APIServiceError? {
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != 200 {
                let error = self.errorHandle(httpResponse: httpResponse, data: data)
                return error
            }
        }
        return nil
    }

    func errorHandle(httpResponse: HTTPURLResponse, data: Data?) -> APIServiceError? {
        print("Status code: \(httpResponse.statusCode)")
        var error: APIServiceError?
        guard let data = data else { return nil }
        do {
            error = try JSONDecoder().decode(APIServiceError.self, from: data)
        } catch let jsonErr {
            print("Failed to serialize error in json:", jsonErr)
        }
        return error
    }

}

struct APIServiceResult: Decodable {
    let result: Bool
}

struct APIServiceError: Error, Decodable {
    let Code: String?
    let Message: String?
}
