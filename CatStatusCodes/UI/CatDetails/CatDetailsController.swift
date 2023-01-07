//
//  CatDetailsController.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Combine
import UIKit

final class CatDetailsController: UIViewController {
    // MARK: - Subviews -

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  //  @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    // MARK: - Public properties -

    var statusCode: Int! {
        didSet {
            viewModel = .init(statusCode: statusCode)
        }
    }
    
    private init(statusCode: Int) {
        self.statusCode = statusCode
        super.init(nibName: "CatDetailsController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private properties -
    
    private var viewModel: CatDetailsViewModel? {
        didSet {
            bindViewModel()
        }
    }
    private var anyCancellableBag = Set<AnyCancellable>()
    
    private func bindViewModel() {
        viewModel?.fetchCatImage()
            .sink { [weak self] result in
                self?.activityIndicator.isHidden = true
                switch result {
                case .finished:
                    break
                case .failure:
                    break
                }
            } receiveValue: { [weak self] data in
                self?.theImageView.image = UIImage(data: data)
                self?.setUpImageHeight()
            }
            .store(in: &anyCancellableBag)
    }
    
    private func setUpImageHeight() {
        guard let image = theImageView.image else {
            return
        }
  //      imageHeightConstraint.constant = image.size.height * image.scale
    }
}

extension CatDetailsController {
    static func make(statusCode: Int) -> UIViewController {
        CatDetailsController(statusCode: statusCode)
    }
}
