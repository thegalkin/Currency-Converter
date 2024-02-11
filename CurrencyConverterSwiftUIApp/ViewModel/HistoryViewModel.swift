//
//  HistoryViewModel.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import SwiftUI
import Combine

final class HistoryViewModel: ObservableObject {
	@Published
	var conversions: Array<Conversion> = []

	private var cancellables: Set<AnyCancellable> = []

	init() {
		Task {
			await setConversionsFromMemory()
		}
	}

	private func setConversionsFromMemory() async {
		self.conversions = await getConversionsFromStorage()
	}
}

extension HistoryViewModel {
	func getConversionsFromStorage() async -> Array<Conversion> {
		await SecureStorage.shared.load(key: "conversion_from", type: Array<Conversion>.self) ?? []
	}
	
	func setConversionsToStorage(_ value: Array<Conversion>?) async {
		await SecureStorage.shared.save(object: value, key: "conversion_from")
	}
}
