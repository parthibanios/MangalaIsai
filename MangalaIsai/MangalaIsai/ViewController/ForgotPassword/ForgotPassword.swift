//
//  ForgotPassword.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 18/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController {
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var txtEmailId: DTTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSubmit: UIButton!
    var signUpViewModel:SignUpViewModel!
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroudImage(self.view.bounds.size)
        self.initialization()
    }
    
    func initialization()
    {
        signUpViewModel = SignUpViewModel(webservice: Webservice())
        signUpViewModel.delegate = self
        txtEmailId.dtborderStyle = .rounded
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnSubmit.layer.cornerRadius = btnSubmit.frame.height/2
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func submitBtnClickAction(_ sender: Any) {
        if self.validateData()
        {
            self.view.endEditing(true)
            let param = [
                "emailaddress":txtEmailId.text!] as [String : Any]
            self.signUpViewModel.forgotpassword(param: param)
        }
    }
    
    @IBAction func loginBtnClickAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: User Define Methods
extension ForgotPassword{

    @objc func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
    }
    
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        let orientation = UIDevice.current.orientation
        print(orientation)
        self.setBackgroudImage(self.view!.frame.size)
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    func validateData() -> Bool {
        guard !txtEmailId.text!.isEmptyStr else {
            txtEmailId.showError(message: "Email Id is required.")
            return false
        }

        return true
    }
}

extension ForgotPassword:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension  ForgotPassword:SignUpViewModelDelegate{
    func apiError(error: String) {
        DispatchQueue.main.async {
            print(error)
            ProgressHUD.shared().hide()
            app_Delegate.alertViewController(title: "Warning", message: error, viewcontroller: self)
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            ProgressHUD.shared().show()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            ProgressHUD.shared().hide()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
