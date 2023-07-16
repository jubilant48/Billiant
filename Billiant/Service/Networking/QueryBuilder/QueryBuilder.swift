//
//  QueryBuilder.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit
import Alamofire

// MARK: - Class

final class QueryBuilder: QueryBuilderProtocol {
    // MARK: - Properties
    
    private var scheme: String?
    private var host: String?
    private var path: String?
    private var method: HTTPMethod = HTTPMethod.get
    private var params: [String: String] = [:]
    private var parameters: Encodable?
    
    // MARK: - Protocol methods
    
    func set(scheme: Scheme) -> Self {
        self.scheme = scheme.value
        
        return self
    }
    
    func set(host: Host) -> Self {
        self.host = host.value
        
        return self
    }
    
    func set(path: Path) -> Self {
        self.path = path.value
        
        return self
    }
    
    func add(path: Path) -> Self {
        if var updatePath = self.path {
            updatePath += path.value
            self.path = updatePath
        } else {
            self.path = path.value
        }
        
        return self
    }
    
    func addPath(string: String) -> Self {
        if var updatePath = self.path {
            updatePath += string
            self.path = updatePath
        } else {
            self.path = string
        }
        
        return self
    }
    
    func set(method: HTTPMethod) -> Self {
        self.method = method
        
        return self
    }
    
    func set(param: Parameter, value: String) -> Self {
        self.params[param.rawValue] = value
        
        return self
    }
    
    func create<T>(type: T.Type, completion: @escaping (Result<T, AFError>) -> Void) throws {
        switch method {
        case .get:
            if type is Data.Type {
            } else {
                throw QueryBuilderError.typeMustBe("Data.self")
            }
        case .post:
            if type is Data.Type {
            } else {
                throw QueryBuilderError.typeMustBe("Data.self")
            }
        case .patch:
            if type is Bool.Type {
            } else {
                throw QueryBuilderError.typeMustBe("Bool.self")
            }
        case .delete:
            if type is Bool.Type {
            } else {
                throw QueryBuilderError.typeMustBe("Bool.self")
            }
        default:
            throw QueryBuilderError.methodsNotFound
        }
        
        switch method {
        case .get:
            try standartRequest { result in
                guard let result = result as? Result<T, AFError> else { return }
                
                completion(result)
            }
        case .post:
            try postRequest { result in
                guard let result = result as? Result<T, AFError> else { return }
                
                completion(result)
            }
        case .patch:
            try patchRequest { result in
                guard let result = result as? Result<T, AFError> else { return }
                
                completion(result)
            }
        case .delete:
            try deleteRequest { result in
                guard let result = result as? Result<T, AFError> else { return }
                
                completion(result)
            }
        default:
            throw QueryBuilderError.methodsNotFound
        }
    }
}

// MARK: - Methods

extension QueryBuilder {
    private func url(setParams isSet: Bool = true) throws -> URL {
        guard let path = path else { throw CommonError.unwrappingError(#fileID, #line) }
        
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = path
        
        if isSet {
            components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        }
        
        return try components.asURL()
    }
    
    private func standartRequest(completion: @escaping (Result<Data, AFError>) -> Void) throws {
        let url = try url()
        
        AF.request(url, method: method).validate(statusCode: 200..<300).responseData { response in
            completion(response.result)
        }
    }
    
    private func postRequest(completion: @escaping (Result<Data, AFError>) -> Void) throws {
        let url = try url(setParams: false)
        
        AF.request(url, method: method, parameters: params, encoder: URLEncodedFormParameterEncoder.default)
            .validate(statusCode: 200..<300).responseData { response in
                completion(response.result)
            }
    }
    
    private func patchRequest(completion: @escaping (Result<Bool, AFError>) -> Void) throws {
        let url = try url(setParams: false)
        print(url)
        
        AF.request(url, method: method, parameters: params, encoder: .json).validate(statusCode: 200..<300).responseData { response in
            let statusCode = response.response!.statusCode

            let isUpdated = statusCode == 200
            
            if isUpdated {
                completion(.success(isUpdated))
            } else {
                if let error = response.error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func deleteRequest(completion: @escaping (Result<Bool, AFError>) -> Void) throws {
        let url = try url(setParams: false)
        
        AF.request(url, method: method).validate(statusCode: 200..<300).responseData { response in
            let statusCode = response.response!.statusCode

            let isDeleted = statusCode == 200
            
            if isDeleted {
                completion(.success(isDeleted))
            } else {
                if let error = response.error {
                    completion(.failure(error))
                }
            }
        }
    }
}
