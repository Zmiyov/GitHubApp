//
//  View+Extensions.swift
//  GitHubApp
//
//  Created by Vladimir Pisarenko on 06.04.2023.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
