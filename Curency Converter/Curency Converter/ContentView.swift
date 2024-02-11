//
//  ContentView.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        tabView
            .navigationTitle(String.appTitle)
    }

    private var tabView: some View {
        TabView {
			CurrencyView()
                .tabItem {
                    Label(String.tabItemCurrency, systemImage: "coloncurrencysign.circle")
                }
			HistoryView()
                .tabItem {
					Label(String.tabItemHistory, systemImage: "coloncurrencysign.arrow.circlepath")
                }
        }
    }
}

#Preview {
    ContentView()
}
