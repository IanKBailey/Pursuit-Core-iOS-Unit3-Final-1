//
//  ElementCell.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellDiscoveredByLabel: UILabel!
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    
    func configureCell(for element: Element) {
        cellNameLabel.text = element.name
        cellDiscoveredByLabel.text = element.discoveredBy
        cellImageView.getImage(with: "http://www.theodoregray.com/periodictable/Tiles/\(String(format: "%03d", element.number))/s7.JPG") { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cellImageView.image = image
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.cellImageView.image = UIImage(systemName: "person.fill")
                }
            }
        }
    }
}
