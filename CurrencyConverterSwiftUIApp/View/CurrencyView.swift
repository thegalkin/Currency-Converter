//
//  CurrencyView.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import SwiftUI

struct CurrencyView: View {
	@StateObject private var viewModel: ConversionViewModel = ConversionViewModel()
	var body: some View {
		VStack {
		Spacer()
			PickerView(viewModel: viewModel, mode: .input)
		HStack {
			Spacer() 
			Image(systemName: "arrow.down")
				.resizable()
				.frame(width: 50, height: 50)
		}
			PickerView(viewModel: viewModel, mode: .output)
		Spacer()
		}.padding(50)
	}
}

#Preview {
	CurrencyView()
}
