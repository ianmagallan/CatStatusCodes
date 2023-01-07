//
//  CatTableViewCell.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import UIKit

final class CatTableViewCell: UITableViewCell {
    // MARK: - Subviews -
    
    @IBOutlet weak var theImageView: ProfileImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lastSeenLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CatTableViewCell {
    static let reuseIdentifier = "catTableViewCell"
}
