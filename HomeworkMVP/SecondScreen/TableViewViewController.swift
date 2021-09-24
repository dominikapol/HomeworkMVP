//
//  TableViewViewController.swift
//  HomeworkMVP
//
//  Created Dominika Poleshyck on 23.09.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol TableViewProtocol: AnyObject {

}
class TableViewViewController: UIViewController, TableViewProtocol {

	var presenter: TableViewPresenterProtocol = TableViewPresenter()

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }

}
