//
//  View+Height.swift
//  Horizon
//
//  Created by Akshat Sharma on 4/20/25.
//
import SwiftUI

extension View {
  func readFrame(onChange: @escaping (CGRect) -> Void) -> some View {
    overlay(
      GeometryReader { geometryProxy in
          Color.clear.onAppear {
              onChange(geometryProxy.frame(in: .local))
          }
      }
    )
  }
}