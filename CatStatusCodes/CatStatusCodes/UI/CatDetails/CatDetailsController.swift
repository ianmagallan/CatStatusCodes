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

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var theImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet var headerHeightConstraint: NSLayoutConstraint!

    // MARK: - Public properties -

    var statusCode: Int! {
        didSet {
            viewModel = .init(statusCode: statusCode)
        }
    }

    // MARK: - Private properties -

    private var headerHeight = 300.0
    private var viewModel: CatDetailsViewModel? {
        didSet {
            fetchCatImage()
        }
    }

    private var anyCancellableBag = Set<AnyCancellable>()
    private var isGradientViewHidden = false {
        didSet {
            if oldValue != isGradientViewHidden {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    guard let isGradientViewHidden = self?.isGradientViewHidden else {
                        return
                    }
                    self?.gradientView.alpha = isGradientViewHidden ? 0 : 1
                }
            }
        }
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        titleLabel.text = Localized("cat_details.description")
    }

    // MARK: - Requests -

    private func fetchCatImage() {
        viewModel?.fetchCatImage()
            .sink { [weak self] result in
                self?.activityIndicator.isHidden = true
                guard case .failure = result else {
                    return
                }
                self?.theImageView.image = UIImage(named: "imPlaceholderCat")
                self?.showErrorAlert()
            } receiveValue: { [weak self] data in self?.setUpImage(data: data) }
            .store(in: &anyCancellableBag)
    }

    private func setUpImage(data: Data) {
        guard let uiImage = UIImage(data: data) else {
            return
        }
        let aspectRatio = 2 - uiImage.size.width / uiImage.size.height
        theImageView.image = uiImage
        headerHeight = aspectRatio * (view.bounds.width + Constants.additionalValueForParallax)
        headerHeightConstraint.constant = headerHeight
    }

    // MARK: - Alert -

    private func showErrorAlert() {
        let alertController = UIAlertController(
            title: Localized("cat_details.alert.title"),
            message: Localized("cat_details.alert.description"),
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: Localized("cat_details.alert.cancel"), style: .cancel)
        alertController.addAction(cancelAction)

        let retryAction = UIAlertAction(title: Localized("cat_details.alert.retry"), style: .default) { [weak self] _ in self?.fetchCatImage() }
        alertController.addAction(retryAction)

        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UIScrollViewDelegate -

extension CatDetailsController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateParallaxEffectIfNeeded(scrollViewYOffset: scrollView.contentOffset.y)
        isGradientViewHidden = scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height
    }

    private func updateParallaxEffectIfNeeded(scrollViewYOffset: Double) {
        let isScrollingDown = scrollView.contentOffset.y >= 0
        guard isScrollingDown else {
            return
        }
        let yOffset = scrollViewYOffset * Constants.parallaxFactor
        let availableOffset = min(yOffset, Constants.minYOffset)
        let contentRectYOffset = availableOffset / headerHeight
        headerTopConstraint?.constant = view.frame.origin.y
        headerHeightConstraint?.constant =
            max(headerHeight - scrollViewYOffset, 0)
        theImageView.layer.contentsRect =
            CGRect(x: 0, y: -contentRectYOffset, width: 1, height: 1)
    }
}

// MARK: - Constants -

extension CatDetailsController {
    private enum Constants {
        static let parallaxFactor = 0.25
        static let minYOffset = 8.0
        static let gradientViewHeight = 150.0
        static let additionalValueForParallax = 100.0
    }
}
