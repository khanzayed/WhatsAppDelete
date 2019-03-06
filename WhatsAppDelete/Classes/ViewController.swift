//
//  ViewController.swift
//  WhatsAppDelete
//
//  Created by Faraz on 16/12/18.
//  Copyright © 2018 Faraz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint! // 22
    
    var isEdit = false
    var selectedIndex = [IndexPath]()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = isEdit
        tableView.allowsMultipleSelectionDuringEditing = !isEdit
        tableView.reloadData()
        
        self.view.layoutIfNeeded()
        
        scrollView.layer.masksToBounds = false
        
        bottomView.layer.cornerRadius = 20.0
        
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bottomView.bounds, cornerRadius: 10.0).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 10
        
        bottomView.layer.insertSublayer(shadowLayer, at: 0)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollViewHeightConstraint.constant + scrollView.contentOffset.y
        let changeValue = min(max(112, value), 315.0)
        scrollViewHeightConstraint.constant = changeValue
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        self.widthConstraint.constant = self.isEdit ? 0 : 22
        self.isEdit = !self.isEdit
        self.tableView.setEditing(self.isEdit, animated: true)
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
