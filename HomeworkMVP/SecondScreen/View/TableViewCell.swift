//
//  TableViewCell.swift
//  HomeworkMVP
//
//  Created by Dominika Poleshyck on 26.09.21.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private weak var pickedImageView: UIImageView!
    
    func downloadPickedView(photo: Data) {
        guard let choosenPhoto = UIImage(data: photo) else { return }
        pickedImageView.image = choosenPhoto
    }
}
