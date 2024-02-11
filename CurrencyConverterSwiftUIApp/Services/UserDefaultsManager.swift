//
//  UserDefaultsManager.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

final actor UserDefaultsManager {
	static func save<T: Codable>(key: String, object: T) {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(object) {
			UserDefaults.standard.set(encoded, forKey: key)
		}
	}
	
	static func load<T: Codable>(key: String, type: T.Type) -> T? {
		if let data = UserDefaults.standard.data(forKey: key) {
			let decoder = JSONDecoder()
			return try? decoder.decode(type, from: data)
		}
		return nil
	}
}

