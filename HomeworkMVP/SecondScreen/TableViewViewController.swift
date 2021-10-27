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
    func addPhotoToTableView(to indexPath: IndexPath)
    func removePhotoToTableView(to indexPath: IndexPath)
    func labelIsHidden()
    func labelIsNotHidden()
    func reloadTableView()
}

class TableViewViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noPhotoLabel: UILabel!
    var presenter: TableViewPresenterProtocol = TableViewPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TableViewCell")
    }
    
    
    @IBAction func addPhotoButtonPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}


extension TableViewViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        guard let pickedImage = image.pngData() else { return }
        presenter.addPhoto(new: pickedImage)
    }
}


extension TableViewViewController: TableViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func labelIsHidden() {
        noPhotoLabel.isHidden = true
    }
    
    func labelIsNotHidden() {
        noPhotoLabel.isHidden = false
    }
    
    func removePhotoToTableView(to indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func addPhotoToTableView(to indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}


extension TableViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuation = UISwipeActionsConfiguration(actions: [UIContextualAction(
            style: .destructive,
            title: "Delete",
            handler: { _, _, _ in
                self.presenter.removePhoto(for: indexPath)
            }
        )
        ]
        )
        return configuation
    }
}


extension TableViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfElementsInPhotoArray()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        photoCell.downloadPickedView(photo: presenter.elementInPhotoArray(for: indexPath))
        return photoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}



