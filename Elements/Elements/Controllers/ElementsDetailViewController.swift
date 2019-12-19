//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {
    
    var elements: Element!
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
        elementImage.getImage(with: "http://images-of-elements.com/\(elements.name.lowercased()).jpg") {[weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "person.fill")
                }
            }
        }
    }
    
    @IBAction func favorite(_ sender: UIBarButtonItem) {
        let favoriteElement = Element.init(name: elements.name, number: elements.number, atomicMass: elements.atomicMass, boil: elements.boil, discoveredBy: elements.discoveredBy, melt: elements.melt
            , symbol: elements.symbol, favoritedBy: "Ian Bailey")
        
        ElementsAPIClient.postElements(element: favoriteElement) { [weak self](result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Element favorited", message: "Thanks for telling us your favorite")
                }
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "error sending favorite", message: "\(appError)")
                }
                
            }
        }
    }
    
    
    
    
    
}




