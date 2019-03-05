//
//  ParentViewController.swift
//  WhatsAppDelete
//
//  Created by Faraz on 09/01/19.
//  Copyright © 2019 Faraz. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shadowView.layer.cornerRadius = 20.0
        
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 10.0).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 15
        
        shadowView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    @IBAction func presentTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        
        pvc.modalPresentationStyle = .custom
        
        self.navigationController?.present(pvc, animated: true, completion: nil)
    }
}
