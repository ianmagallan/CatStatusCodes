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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
