//
//  CatTableViewCell.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import UIKit

final class CatTableViewCell: UITableViewCell {
    // MARK: - Subviews -

    @IBOutlet var theImageView: ProfileImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var lastSeenLabel: UILabel!

    // MARK: - Lifecycle -

    override init(style: UITableViewCell.CellStyle, reuseIdentifier _: String?) {
        super.init(style: style, reuseIdentifier: Self.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CatTableViewCell {
    static let reuseIdentifier = "catTableViewCell"
}
