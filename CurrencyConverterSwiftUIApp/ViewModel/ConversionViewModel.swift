//
//  ConversionViewModel.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import SwiftUI
import Combine

final class ConversionViewModel: ObservableObject {
	var currenciesList: Set<String> = []
	var selectedFrom: Conversion.From?
	var selectedTo: Conversion.To?
	
	var currenciesRefreshTimer: Timer?
	var conversionRefreshTimer: Timer?
	private var cancellables: Set<AnyCancellable> = []

	init() {
		setupListeners()
		setupTimers()
		fetchCurrencies()
	}

	private func setupListeners() {
		selectedFrom.publisher
			.sink { [weak self] (newValue: Conversion.From) in
				self?.performConversion()
			}
			.store(in: &cancellables)
		selectedTo.publisher
			.sink { [weak self] (newValue: Conversion.To) in
				self?.performConversion()
			}
			.store(in: &cancellables)
	}

	private func setupTimers() {
		currenciesRefreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
			self?.fetchCurrencies()
		}
		conversionRefreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
			self?.performConversion()
		}
	}

	func fetchCurrencies() {
		Task {
			do {
				let currencies = try await NetworkService().getCurrencies()
				currenciesList = Set(currencies.data.keys)
			} catch {
				print(error.localizedDescription)
			}
		}
	}

	func performConversion() {
		guard let from = selectedFrom, let to = selectedTo else { return }
		Task {
			do {
				let latest = try await NetworkService().getLatest()
				let rate = latest.data
				let fromRate = rate[from.name] ?? 1
				let toRate = rate[to.name] ?? 1
				selectedTo?.amount = from.amount * fromRate / toRate
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}

extension ConversionViewModel {
	func getSelectedFrom() async -> Conversion.From? {
		await SecureStorage.shared.load(key: "conversion_from", type: Conversion.From.self)
	}
	
	func setSelectedFrom(_ value: Conversion.From?) async {
		await SecureStorage.shared.save(object: value, key: "conversion_from")
	}
	
	func getSelectedTo() async -> Conversion.To? {
		await SecureStorage.shared.load(key: "conversion_to", type: Conversion.To.self)
	}
	
	func setSelectedTo(_ value: Conversion.To?) async {
		await SecureStorage.shared.save(object: value, key: "conversion_to")
	}
}
