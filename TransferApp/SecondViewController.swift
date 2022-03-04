//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Karpinets Alexander on 04.03.2022.
//

import UIKit

protocol UpdatingDataController {
    var updatingData: String { get set }
}

class SecondViewController: UIViewController, UpdatingDataController {
    
    @IBOutlet var dataTextField: UITextField!
    
    var updatingData: String = ""
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton){
        navigationController?.viewControllers.forEach { viewcontroller in
            (viewcontroller as? UpdatableDataController)?.updateData = dataTextField.text ?? ""
        }
    }
  
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
}
