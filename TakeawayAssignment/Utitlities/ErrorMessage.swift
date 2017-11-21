//
//  ErrorMessage.swift
//  TakeawayAssignment
//
//  Created by Alex Gordon on 19.11.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit

enum ErrorMessage {
    case unknownError()
    case custom(error: Error)
    
    public func show(on viewController: UIViewController,
                     customActionTitle: String = "Ok",
                     customAction: (() -> ())? = nil) {
        
        let alert = UIAlertController(title: title(), message: message(), preferredStyle: .alert)
        
        let action = UIAlertAction(title: customActionTitle, style: .default) {(action) in
            if let customAction = customAction {
                customAction()
            }
        }
        alert.addAction(action)
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }

    }
}

private extension ErrorMessage {
    private func title() -> String {
        switch self {
        case .custom(_):
            return "Error"
        case .unknownError():
            return "Oops..."
        }
    }
    
    private func message() -> String {
        switch self {
        case .custom(let error):
            return error.localizedDescription
        case .unknownError():
            return "We are sorry, an unknown error has happened. Please try again later or call support."
        }
    }
}
