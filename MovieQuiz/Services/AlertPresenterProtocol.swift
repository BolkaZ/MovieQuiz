import Foundation
import UIKit

protocol AlertPresenterProtocol: AnyObject {
    func present(alert: UIAlertController, animated: Bool)
}
