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
    func viewDidLoad()
    var view: TableViewProtocol? { get set }
    func addPhoto(new photo: Data)
    func numberOfElementsInPhotoArray() -> Int
    func elementInPhotoArray(for indexPath: IndexPath) -> Data
    func removePhoto(for indexPath: IndexPath)
}

class TableViewPresenter: TableViewPresenterProtocol {
    
    private var photoArray: [TableView] = []
    weak var view: TableViewProtocol?
    
    func viewDidLoad() {
        DatabaseService.shared.entitiesFor(
            type: TableView.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: {
                photoesInArray in
                self.photoArray = photoesInArray
                self.view?.reloadTableView()
                if self.photoArray.isEmpty {
                    self.view?.labelIsNotHidden()
                } else {
                    self.view?.labelIsHidden()
                }
            }
        )
    }
    
    func removePhoto(for indexPath: IndexPath) {
        DatabaseService.shared.delete(photoArray[indexPath.row], context: DatabaseService.shared.persistentContainer.mainContext, closure: {
            _ in
            self.photoArray.remove(at: indexPath.row)
            DatabaseService.shared.saveMain(nil)
            self.view?.removePhotoToTableView(to: indexPath)
        })
    }
    
    func elementInPhotoArray(for indexPath: IndexPath) -> Data {
        photoArray[indexPath.row].creationData! as Data
    
    }
    
    func numberOfElementsInPhotoArray() -> Int {
        return photoArray.count
    }
    
    func addPhoto(new photo: Data) {

        DatabaseService.shared.insertEntityFor(
            type: TableView.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: {
                photoes in
                photoes.creationData = NSData(data: photo)
                self.photoArray.append(photoes)
                DatabaseService.shared.saveMain(nil)
                self.view?.addPhotoToTableView(
                    to: IndexPath(
                        row: self.numberOfElementsInPhotoArray() - 1,
                        section: 0
                    )
                )
                self.view?.labelIsHidden()
            }
        )
    }
}



