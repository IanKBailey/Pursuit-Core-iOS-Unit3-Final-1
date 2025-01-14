//
//  ElementsViewController.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    @IBOutlet weak var elementsTableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.elementsTableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsTableView.dataSource = self
        elementsTableView.delegate = self
        getElements()
    }
    
    private func getElements() {
        ElementsAPIClient.fetchElements { (result) in
            switch result {
            case .success(let elements):
                self.elements = elements
            case .failure(let appError):
                print("appError \(appError)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let elementsDetailViewController = segue.destination as? ElementsDetailViewController, let indexPath = elementsTableView.indexPathForSelectedRow else {
            fatalError("Couldn't segue")
        }
        let element = elements[indexPath.row]
        elementsDetailViewController.elements = element
    }
    
}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = elementsTableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("Failed to dequeue Cell")
        }
        
        let element = elements[indexPath.row]
        
        cell.configureCell(for: element)
        
        return cell
    }
    
    
}
extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


