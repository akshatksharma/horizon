//
//  Tabs.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import Foundation
import SwiftUI

enum Tabs: Equatable, Hashable, CaseIterable {
    case home
    case profile
}

// MARK: - Environment Key for Current Tab

private struct CurrentTabKey: EnvironmentKey {
    static let defaultValue: Tabs = .home
}

extension EnvironmentValues {
    var currentTab: Tabs {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }
} 