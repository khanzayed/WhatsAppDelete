//
//  ViewController.swift
//  WhatsAppDelete
//
//  Created by Faraz on 16/12/18.
//  Copyright © 2018 Faraz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    
    var isEdit = false
    var selectedIndex = [IndexPath]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = isEdit
        tableView.allowsMultipleSelectionDuringEditing = !isEdit
        tableView.reloadData()
    }

    @IBAction func editButtonTapped(_ sender: UIButton) {
        isEdit = !isEdit
        tableView.setEditing(isEdit, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        cell.index = indexPath.row + 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEdit {
            if (indexPath.row + 1) % 2 == 0 {
                selectedIndex.append(indexPath)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
                let alertVC = UIAlertController(title: "Validation", message: "Cannot select this row", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertVC.addAction(okayAction)
                DispatchQueue.main.async {
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            // Perform navigation
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if isEdit {
            selectedIndex.removeAll(where: { $0.row == indexPath.row })
        }
    }
    
}
