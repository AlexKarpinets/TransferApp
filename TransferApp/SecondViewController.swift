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
    var handleUpdatetedDataDelegate: DataUpdateProtocol?
    var completionHandler: ((String) -> Void)?
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton){
        navigationController?.viewControllers.forEach { viewcontroller in
            (viewcontroller as? UpdatableDataController)?.updateData = dataTextField.text ?? ""
        }
    }
    
    @IBAction func saveDataWithDelegate(_ sender: UIButton){
        let updateData = dataTextField.text ?? ""
        handleUpdatetedDataDelegate?.onDataUpdate(data: updateData)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveDataWithClosure(_ sender: UIButton){
        let updateData = dataTextField.text ?? ""
        completionHandler?(updateData)
        navigationController?.popViewController(animated: true)
    }
  
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    private func prepareFirstScreen(_ segue: UIStoryboardSegue){
    guard let destinationVC = segue.destination as? ViewController else { return }
    destinationVC.updateData = dataTextField.text ?? ""
}
    
}
