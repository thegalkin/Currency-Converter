//
//  Currencies.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

struct Currencies: RequestModelProtocol {
	typealias Input = CurrenciesInput
	typealias Output = CurrenciesOutput
	
	struct CurrenciesInput: Codable {
		init(apikey: String, currencies: [String]?) {
			self.apikey = apikey
			self.currencies = currencies?.joined(separator: ",")
		}
	
		let apikey: String
		let currencies: String?
	}
	
	struct CurrenciesOutput: Codable {
		let data: [String: Currency]
		
		struct Currency: Codable {
			let apikey: String
			let symbol: String
			let name: String
			let symbol_native: String
			let decimal_digits: Int
			let rounding: Int
			let code: String
			let name_plural: String
		}
	}
}


