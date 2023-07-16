//
//  QueryBuilderProtocol.swift
//  Billiant
//
//  Created by macbook on 20.05.2023.
//

import UIKit
import Alamofire

// MARK: - Protocol

protocol QueryBuilderProtocol {
    func set(scheme: Scheme) -> Self
    func set(host: Host) -> Self
    func set(path: Path) -> Self
    func add(path: Path) -> Self
    func addPath(string: String) -> Self
    func set(method: HTTPMethod) -> Self
    func set(param: Parameter, value: String) -> Self
    func create<T>(type: T.Type, completion: @escaping (Result<T, AFError>) -> Void) throws
}
