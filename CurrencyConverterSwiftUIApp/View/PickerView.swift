//
//  PickerView.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import SwiftUI

struct PickerView: View {
	@ObservedObject var viewModel: ConversionViewModel
	var mode: Self.Mode
	var body: some View {
		HStack {
			currencyPickerView
			amountInputView
		}
	}
	
	private var currencyPickerView: some View {
		Menu(content: {
			ForEach(viewModel.currenciesList.sorted(), id: \.self) { currency in
				Button(action: {
					switch mode {
						case .input:
							viewModel.selectedFrom = Conversion.From(name: currency, amount: 1)
						case .output:
							viewModel.selectedTo = Conversion.To(name: currency, amount: 1)
					}
					
				}, label: {
					Text(currency)
				})
			}
		}, label: {
			Text(viewModel.selectedFrom?.name ?? String.selectCurrency)
		})
	}
	
	private var amountInputView: some View {
		TextField("", text: self.amountBinding, prompt: Text("0.1"))
			.keyboardType(.numberPad)
			
	}
	
	private var amountBinding: Binding<String> {
		Binding<String>(get: {
			switch self.mode {
				case .input:
					String(self.viewModel.selectedFrom?.amount ?? 0)
				case .output:
					String(self.viewModel.selectedTo?.amount ?? 0)
			}
		}, set: { (newValue: String) in
			switch self.mode {
				case .input:
					self.viewModel.selectedFrom?.amount = Double(newValue) ?? 0
				case .output:
					self.viewModel.selectedTo?.amount = Double(newValue) ?? 0
			}
		})
	}
}

extension PickerView {
	enum Mode {
		case input
		case output
	}
}
