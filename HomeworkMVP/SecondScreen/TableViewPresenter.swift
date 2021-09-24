//
//  TableViewPresenter.swift
//  HomeworkMVP
//
//  Created Dominika Poleshyck on 23.09.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation


// MARK: Presenter -
protocol TableViewPresenterProtocol {
	var view: TableViewProtocol? { get set }
    func viewDidLoad()
}

class TableViewPresenter: TableViewPresenterProtocol {

    weak var view: TableViewProtocol?

    func viewDidLoad() {

    }
}
