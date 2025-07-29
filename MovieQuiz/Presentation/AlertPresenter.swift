import Foundation
import UIKit

class AlertPresenter {
    private weak var view: AlertPresenterProtocol?
    
    init(view: AlertPresenterProtocol?) {
        self.view = view
    }
    
    func show(alert model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        
        alert.addAction(action)
        view?.present(alert: alert, animated: true)
    }
}
