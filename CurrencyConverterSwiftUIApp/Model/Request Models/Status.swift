//
//  Status.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

struct Status: RequestModelProtocol {
	typealias Input = StatusInput
	typealias Output = StatusOutput
	
	struct StatusInput: Codable {
		let apikey: String
	}
	
	struct StatusOutput: Codable {
		let quotas: Quotas
		
		struct Quotas: Codable {
			let apikey: String
			let month: Month
			
			struct Month: Codable {
				let apikey: String
				let total: Int
				let used: Int
				let remaining: Int
			}
		}
	}
}


