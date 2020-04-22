//
//  MSContactsController.swift
//  MSContactsPicker
//
//  Created by Matías Spinelli on 21/04/2020.
//

import UIKit

public class MSContactsController: NSObject {

    public static let sharedInstance = MSContactsController()
    
    var contactsViewController: MSContactsViewController?

    private override init() {
        let bundle = Bundle(for: MSContactsController.self)
        contactsViewController = MSContactsViewController(nibName: "MSContactsViewController", bundle: bundle)
    }
    
    // push navigation
    public func push(in viewController: UIViewController) {
//        viewController.present(navigationController, animated: true, completion: nil)
    }
    
    // present
    public func present(in viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: contactsViewController ?? UIViewController())
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
