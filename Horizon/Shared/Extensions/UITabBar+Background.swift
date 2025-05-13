//
//  UITabBar+Background.swift
//  Horizon
//
//  Created by Akshat Sharma on 5/13/25.
//

import UIKit

public extension UITabBar {
    func applyBlurBackground(
        backgroundColor: UIColor = .systemBackground,
        blurStyle: UIBlurEffect.Style = .regular,
        blurMutingFactor: CGFloat = 0.5
    ) {
        // Handle reduced transparency accessibility setting
        if UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundImage = UIImage()
            self.backgroundColor = backgroundColor
            return
        }
        
        // Create and configure blur effect
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Remove hairline below bar
        self.shadowImage = UIImage()
        
        // Add blur effect view
        insertSubview(blurEffectView, at: 0)
        
        // Apply tinting to match background color
        if let tintingView = blurEffectView.subviews.first(where: {
            String(describing: type(of: $0)) == "_UIVisualEffectSubview"
        }) {
            tintingView.backgroundColor = backgroundColor.withAlphaComponent(blurMutingFactor)
            self.backgroundImage = UIImage()
        } else {
            // Fallback if we can't find the tinting subview
            self.backgroundImage = UIImage()
            self.backgroundColor = backgroundColor.withAlphaComponent(blurMutingFactor)
            print("Failed to find tinting subview")
        }
    }
}
