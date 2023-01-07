//
//  ProfileImageView.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import UIKit

final class ProfileImageView: UIImageView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private func setUp() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
