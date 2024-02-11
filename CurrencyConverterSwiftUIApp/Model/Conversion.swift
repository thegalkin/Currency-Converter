//
//  Conversion.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

struct Conversion: Codable, Identifiable {
	let id: UUID = .init()
	var from: From
	var to: To
	var date: Date = .init()

	struct From: Codable {
		var name: String
		var amount: Double
	}
	
	struct To: Codable {
		var name: String
		var amount: Double
	}
	
	var combinedLabel: String {
		let compileTimeOptimisatonArray: Array<String> = [from.name, String(" "), String(from.amount), String("->"), to.name, String(" "), String(to.amount)]
		return compileTimeOptimisatonArray.joined()
	}
}
