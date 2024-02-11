//
//  HistoryView.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import SwiftUI

struct HistoryView: View {
	@StateObject private var historyViewModel: HistoryViewModel = .init()
	var body: some View {
		if historyViewModel.conversions.isEmpty {
			emptyView
		} else {
			listView
		}
	}

	private var emptyView: some View {
		Label(String.noHistory, systemImage: "exclamationmark.triangle")
	}

	private var listView: some View {
		List {
			ForEach(historyViewModel.conversions) { (conversion: Conversion) in
				Text(conversion.combinedLabel)
			}
		}
	}
}
