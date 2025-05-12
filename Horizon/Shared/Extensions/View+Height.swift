//
//  View+Height.swift
//  Horizon
//
//  Created by Akshat Sharma on 4/20/25.
//
import SwiftUI

extension View {
  func readHeight(onChange: @escaping (CGFloat) -> Void) -> some View {
    overlay(
      GeometryReader { geometryProxy in
          Color.clear.onAppear {
              onChange(geometryProxy.size.height)
          }
      }
    )
  }
}

// Preference key to get the height of ProfileInfoView
struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
