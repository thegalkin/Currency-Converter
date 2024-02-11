//
//  LatestRates.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

struct LatestRates: RequestModelProtocol {
	typealias Input = LatestInput
	typealias Output = LatestOutput
	
	struct LatestInput: Codable {
		init(apikey: String, base_currency: String? = nil, currencies: [String]? = nil) {
			self.apikey = apikey
			self.base_currency = base_currency
			self.currencies = currencies?.joined(separator: ",")
		}
		let apikey: String
		let base_currency: String?
		let currencies: String?
	}
	
	struct LatestOutput: Codable {
		let data: [String: Double]
	}
}

