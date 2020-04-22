//
//  ViewController.swift
//  MSContactsPicker
//
//  Created by matiasspinelli4 on 04/20/2020.
//  Copyright (c) 2020 matiasspinelli4. All rights reserved.
//

import UIKit
import MSContactsPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func showContacts(_ sender: Any) {        
        MSContactsController.sharedInstance.present(in: self)
    }
}

