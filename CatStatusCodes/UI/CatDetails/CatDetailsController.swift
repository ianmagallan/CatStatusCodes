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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Public properties -

    var statusCode: Int! {
        didSet {
            viewModel = .init(statusCode: statusCode)
        }
    }
    
    // MARK: - Private properties -
    
    private var viewModel: CatDetailsViewModel? {
        didSet {
            bindViewModel()
        }
    }
    private var anyCancellableBag = Set<AnyCancellable>()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        titleLabel.text = Localized("cat_details.description")
    }
    
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
            }
            .store(in: &anyCancellableBag)
    }
}

// MARK: - UIScrollViewDelegate -

extension CatDetailsController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isScrollingDown = scrollView.contentOffset.y >= 0
        guard isScrollingDown else {
            return
        }

        let yOffset = scrollView.contentOffset.y * Constants.parallaxFactor
        let availableOffset = min(yOffset, Constants.minYOffset)
        let contentRectYOffset = availableOffset / Constants.headerHeight
        headerTopConstraint?.constant = view.frame.origin.y
        headerHeightConstraint?.constant =
            max(Constants.headerHeight - scrollView.contentOffset.y, 0)
        theImageView.layer.contentsRect =
            CGRect(x: 0, y: -contentRectYOffset, width: 1, height: 1)
    }
}

// MARK: - Constants -

extension CatDetailsController {
    private enum Constants {
        static let headerHeight = 300.0
        static let parallaxFactor = 0.25
        static let minYOffset = 8.0
    }
}
