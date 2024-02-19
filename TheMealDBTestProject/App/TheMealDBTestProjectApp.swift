//
//  TheMealDBTestProjectApp.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import SwiftUI

@main
struct TheMealDBTestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            DessertsListView(viewModel: DessertsListViewModel())
        }
    }
}
