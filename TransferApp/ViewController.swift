//
//  ViewController.swift
//  TransferApp
//
//  Created by Karpinets Alexander on 04.03.2022.
//

import UIKit

protocol UpdatableDataController: AnyObject {
    var updateData: String { get set }
}

class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
    

    @IBOutlet var dataLabel: UILabel!
    
    var updateData: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updateData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editScreen = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! UpdatingDataController
        editScreen.updatingData = dataLabel.text ?? ""
        navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func editDataWithDelegate(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.handleUpdatetedDataDelegate = self
        navigationController?.pushViewController(editScreen, animated: true)
    }
    
    @IBAction func editDataWithClosure(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.completionHandler = {[unowned self] updatedValue in
            updateData = updatedValue
            updateLabel(withText: updatedValue)
        }
        navigationController?.pushViewController(editScreen, animated: true)
    }
    
    private func updateLabel(withText text: String){
        dataLabel.text = updateData
    }
    
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        guard let destinationVC = segue.destination as? SecondViewController else { return }
        destinationVC.updatingData = dataLabel.text ?? ""
    }

    func onDataUpdate(data: String) {
        updateData = data
        updateLabel(withText: data)
    }
    
}

