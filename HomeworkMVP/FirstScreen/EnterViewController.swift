//
//  ViewController.swift
//  HomeworkMVP
//
//  Created by Dominika Poleshyck on 23.09.21.
//

import UIKit

protocol EnterViewControllerProtocol: AnyObject {
    func showNextScreen()
    func alertSorry()
}

class EnterViewController: UIViewController {
    @IBOutlet weak var enterYourPassword: UITextField!
    var presenter: EnterPresenterProtocol = EnterPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
    }
    @IBAction private func loginButton() {
        let password = enterYourPassword.text ?? ""
        presenter.enterYourPassword(password: password)
    }
}

extension EnterViewController: EnterViewControllerProtocol {
    func showNextScreen() {
        let secondStoryboard = UIStoryboard(name: "TableView", bundle: Bundle.main)
        guard let nextVC = secondStoryboard.instantiateViewController(identifier: "TableViewViewController") as? TableViewViewController else {
            return
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    func alertSorry() {
        let alertSorry = UIAlertController(title: "Sorry, you entered uncurrect password", message: "Concentrate and try to remember the password", preferredStyle: .alert)
        let alertSorryAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertSorry.addAction(alertSorryAction)
        present(alertSorry, animated: true, completion: nil)
    }
}

