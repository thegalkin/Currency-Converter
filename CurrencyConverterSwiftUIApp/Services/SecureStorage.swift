//
//  SecureStorage.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

final actor SecureStorage {
	private init() {}
	static let shared = SecureStorage()
	
	func save<T: Codable>(object: T, key: String) {
		let userDefaultsKey = UUID().uuidString
		UserDefaultsManager.save(key: userDefaultsKey, object: object)
		
		if let keyData = userDefaultsKey.data(using: .utf8) {
			_ = KeychainManager.save(key: key, data: keyData)
		}
	}
	
	func load<T: Codable>(key: String, type: T.Type) -> T? {
		guard let keyData = KeychainManager.load(key: key),
			  let userDefaultsKey = String(data: keyData, encoding: .utf8) else {
			return nil
		}
		
		return UserDefaultsManager.load(key: userDefaultsKey, type: type)
	}
}
