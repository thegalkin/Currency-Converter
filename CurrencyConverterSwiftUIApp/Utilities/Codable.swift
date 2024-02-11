//
//  Codable.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/12/24.
//

import Foundation

extension Encodable {
	func toDictionary() -> [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
			.flatMap { $0 as? [String: Any] }
	}
}
