//
//  APIError.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation

enum APIError: Error{
    case invalidURL
    case server(Int)
    case decode(Error)
    case responseError(Error)
}
