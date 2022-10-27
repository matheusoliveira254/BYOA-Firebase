//
//  DreamDetailViewController.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import UIKit

class DreamDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var dreamTitleTextField: UITextField!
    @IBOutlet weak var dreamBodyTextView: UITextView!
    
    var viewModel: DreamDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = dreamTitleTextField.text,
              let body = dreamBodyTextView.text else {return}
        
        viewModel?.saveDream(title: title, body: body)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateUI() {
        guard let dream = viewModel?.dream else {return}
        dreamTitleTextField.text = dream.dreamTitle
        dreamBodyTextView.text = dream.dreamBody
    }
}
