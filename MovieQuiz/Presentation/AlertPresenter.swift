import Foundation
import UIKit

final class AlertPresenter {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func present(alert: AlertModel) {
        let alertController = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )

        let action = UIAlertAction(title: alert.buttonText, style: .default) { _ in
            alert.completion()
        }

        alertController.addAction(action)

        viewController?.present(alertController, animated: true, completion: nil)
    }
}
