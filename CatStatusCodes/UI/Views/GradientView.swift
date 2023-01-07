//
//  GradientView.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 7/1/23.
//

import UIKit

final class GradientView: UIView {
    // MARK: - Properties -
        
    override class var layerClass: AnyClass {
        CAGradientLayer.classForCoder()
    }

    @IBInspectable var foregroundColor: UIColor? {
        didSet {
            setUpGradient()
        }
    }
    
    // MARK: - Lifecycle -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setUpGradient()
        }
    }
    
    // MARK: - Set up -

    private func setUp() {
        backgroundColor = .clear
        setUpGradient()
    }

    private func setUpGradient() {
        if let foregroundColor {
            (layer as? CAGradientLayer)?.colors = [
                foregroundColor.withAlphaComponent(0.0).cgColor,
                foregroundColor.cgColor
            ]
        }
    }
}
