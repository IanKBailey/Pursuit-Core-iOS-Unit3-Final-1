//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {

    var elements: ElementData!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var DiscoveredByLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = elements?.name
        updateUI()
    }
    

    private func updateUI() {
        symbolLabel.text = "The Atomic symbol is \(elements.symbol)"
        numberLabel.text = "Its number is \(elements.number)"
        if elements.atomicMass != nil {
            weightLabel.text = "Its Weight is \(elements.atomicMass!)"
        } else {
            weightLabel.text = "Its Weight is unknown"
        }
        if elements?.melt != nil {
            meltingPointLabel.text = "Its melting Point is \(elements.melt!)"
        } else {
            meltingPointLabel.text = "The melting point is unknown"
        }
        if elements?.boil != nil {
            boilingPointLabel.text = "Its boiling Point is \(elements.boil!)"
        } else {
            boilingPointLabel.text = "The Boiling point is unknown"
        }
        if elements?.discoveredBy != nil {
            DiscoveredByLabel.text = "It was discovered by \(elements.discoveredBy!)"
        } else {
            DiscoveredByLabel.text = "Unsure of who discovered \(elements.name)"
        }
        elementImage.getImage(with: "http://images-of-elements.com/\(elements.name.lowercased()).jpg") { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.elementImage.image = image
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.elementImage.image = UIImage(systemName: "person.fill")
                }
            }
        }
    }
    
    @IBAction func favorite(_ sender: UIBarButtonItem) {
        let favoriteElement = FavoriteElements.init(elementName: elements.name, favoritedBy: "Ian K. Bailey", elementSymbol: elements.symbol)
        
        ElementsAPIClient.postElements(element: favoriteElement) { (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(title: "Element favorited", message: "Thanks for telling us your favorite")
                }
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlert(title: "error sending favorite", message: "\(appError)")
                }
                
            }
        }
    }
    
    
    
    
    
}




