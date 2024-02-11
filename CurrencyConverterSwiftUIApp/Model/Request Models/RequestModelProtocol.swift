//
//  RequestModel.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

protocol RequestModelProtocol {
	associatedtype Input: Codable
	associatedtype Output: Codable
}
