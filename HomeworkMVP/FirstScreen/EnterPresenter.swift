//
//  EnterPresenter.swift
//  HomeworkMVP
//
//  Created by Dominika Poleshyck on 23.09.21.
//

import Foundation

protocol EnterPresenterProtocol {
    var view: EnterViewControllerProtocol? { get set }
    func enterYourPassword(password: String)
}

class EnterPresenter: EnterPresenterProtocol {
    weak var view: EnterViewControllerProtocol?
    private let hardPassword: String = "HomeworkMVP"
    func enterYourPassword(password: String) {
        if password == hardPassword {
            view?.showNextScreen()
        } else {
            view?.showAlert()
        }
    }
    
}
