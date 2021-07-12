//
//  SignUpVC.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 18/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class SignUpVC: UIViewController {
    @IBOutlet weak var lblSignUp: UILabel!
        @IBOutlet weak var profileImageView: UIImageView!
        @IBOutlet weak var txtName: DTTextField!
        @IBOutlet weak var txtEmailId: DTTextField!
        @IBOutlet weak var txtPassword: DTTextField!
    @IBOutlet weak var txtConfirmPassWord: DTTextField!
        @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var imagePicker: CustomImagePicker!
    var signUpViewModel:SignUpViewModel!
    var profileImage:UIImage!
    var timer :Timer!
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroudImage(self.view.bounds.size)
        self.initialization()
    }
    
    func initialization()
    {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        signUpViewModel = SignUpViewModel(webservice: Webservice())
        signUpViewModel.delegate = self
        txtName.dtborderStyle = .rounded
        txtEmailId.dtborderStyle = .rounded
        txtPassword.dtborderStyle = .rounded
        txtConfirmPassWord.dtborderStyle = .rounded
        self.imagePicker = CustomImagePicker(presentationController: self, delegate: self)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        self.profileImageView.addGestureRecognizer(tap)
    }
    
 

    override func viewWillAppear(_ animated: Bool) {
        
        btnSignUp.layer.cornerRadius = btnSignUp.frame.height/2
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
    
    override func viewDidAppear(_ animated: Bool) {
    }
        
    @IBAction func signUpBtnClickAction(_ sender: Any) {
        if self.validateData()
        {
            self.view.endEditing(true)
           let param = [
            "username":txtName.text!,
            "password":txtPassword.text!,
            "emailaddress":txtEmailId.text!,
            "deviceid":Userdefault.shared.getDeviceId(),
            "socialid":0,
            "socialtype":0,
            "platform":2,
            "registertype":1] as [String : Any]
            signUpViewModel.signUp(param: param, image: self.profileImageView.image!)
        }
    }
    
    @IBAction func loginBtnClickAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func googleBtnClickAction(_ sender: Any) {
         GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func facebookBtnClickAction(_ sender: Any) {
        self.facebooklogin()
    }
}

// MARK: User Define Methods
extension SignUpVC{
    @objc func handleTap(_ recognizer: UIGestureRecognizer) {
        self.imagePicker.present(from: profileImageView)
    }
    @objc func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
    }
    
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        let orientation = UIDevice.current.orientation
        print(orientation)
        self.setBackgroudImage(self.view!.frame.size)
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
        timer.invalidate()
        timer = nil
        ProgressHUD.shared()?.hide()
    }
    
    func validateData() -> Bool {
       // ProgressHUD.shared()?.show()
        //timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        guard !txtName.text!.isEmptyStr else {
            txtName.showError(message: "Name is required.")
            return false
        }
        
        guard !txtEmailId.text!.isEmptyStr else {
            txtEmailId.showError(message: "Email Id is required.")
            return false
        }
        
        guard !txtPassword.text!.isEmptyStr else {
            txtPassword.showError(message: "Password is required.")
            return false
        }
        
        guard !txtConfirmPassWord.text!.isEmptyStr else {
            txtConfirmPassWord.showError(message: "Confirm password is required.")
            return false
        }
        
        guard txtPassword.text == txtConfirmPassWord.text else {
            txtConfirmPassWord.text = ""
            txtConfirmPassWord.showError(message: "Password and Confirm password are not matching.")
            return false
        }
        guard let _ = profileImage else {
            app_Delegate.alertViewController(title: "Warning", message: "Please select profile image", viewcontroller: self)
            return false
        }
        
        return true
    }
}

extension SignUpVC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpVC: CustomImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        self.profileImageView.image = image
        profileImage = image
    }
}

extension  SignUpVC:SignUpViewModelDelegate{
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
            app_Delegate.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            
            // Set up the Tab Bar Controller to have two tabs
            let tabBarController  = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController
            // Make the Tab Bar Controller the root view controller
            
            
            
            if #available(iOS 13.0, *){
                if let scene = UIApplication.shared.connectedScenes.first{
                    guard let windowScene = (scene as? UIWindowScene) else { return }
                    print(">>> windowScene: \(windowScene)")
                    let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
                    window.windowScene = windowScene //Make sure to do this
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                    app_Delegate.window = window
                }
            } else {
                app_Delegate.window?.rootViewController = tabBarController
                app_Delegate.window?.makeKeyAndVisible()
            }
        }
    }
}

// MARK: User Define Methods
extension SignUpVC{
    func facebooklogin() {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) in
            print("\n\n result: \(result)")
            print("\n\n Error: \(error)")
            
            if (error == nil) {
                let fbloginresult : LoginManagerLoginResult = result!
                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    self.returnUserData()
                    //fbLoginManager.logOut()
                }
            }
        }
    }
    func returnUserData() {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"email,name,picture.type(large)"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                print("\n\n Error: \(error)")
            } else {
                let resultDic = result as! NSDictionary
                var image = UIImage(named: "profile")
                print("\n\n  fetched user: \(result)")
                var name = ""
                if (resultDic.value(forKey:"name") != nil) {
                    name = resultDic.value(forKey:"name")! as! String
                    print("\n User Name is: \(name)")
                }
                
                var email = ""
                if (resultDic.value(forKey:"email") != nil) {
                    email = resultDic.value(forKey:"email")! as! String
                    print("\n User Email is: \(email)")
                }
                
                var id = ""
                if (resultDic.value(forKey:"id") != nil) {
                    id = resultDic.value(forKey:"id")! as! String
                    print("\n User Email is: \(id)")
                }
                
                if (resultDic.value(forKey:"picture") != nil) {
                    let picture = resultDic.value(forKey:"picture")! as! [String:Any]
                    let data = picture["data"] as! [String:Any]
                    if let url = data["url"] as? String
                    {
                        DispatchQueue.global(qos: .background).async {
                            do
                            {
                                let data = try Data.init(contentsOf: URL.init(string:url)!)
                                DispatchQueue.main.async {
                                    image = UIImage(data: data)!
                                    let param = [
                                        "username":name,
                                        "emailaddress":email,
                                        "deviceid":Userdefault.shared.getDeviceId(),
                                        "socialid":id,
                                        "socialtype":Socialtype.Facebook.rawValue,
                                        "platform":Platform.iOS.rawValue,
                                        "registertype":Registertype.Social.rawValue] as [String : Any]
                                    self.signUpViewModel.signUp(param: param, image: image!)
                                }
                            }
                            catch let error{
                                print("error:",error.localizedDescription)
                            }
                        }
                    }
                    print("\n User Email is: \(id)")
                }
                else{
                    let param = [
                        "username":name,
                        "emailaddress":email,
                        "deviceid":Userdefault.shared.getDeviceId(),
                        "socialid":id,
                        "socialtype":Socialtype.Facebook.rawValue,
                        "platform":Platform.iOS.rawValue,
                        "registertype":Registertype.Social.rawValue] as [String : Any]
                    self.signUpViewModel.signUp(param: param, image: image!)
                }
            }
        })
    }
}

extension SignUpVC: GIDSignInDelegate
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil)
        {
            // Perform any operations on signed in user here.
            //let userId = user.userID // For client-side use only!
            let idToken = user.userID //Safe to send to the server
            let name = user.profile.name
            let email = user.profile.email
            var image = UIImage(named: "profile")
            if (user.profile.hasImage)
            {
                let userImageURL = user.profile.imageURL(withDimension: 200)
                DispatchQueue.global(qos: .background).async {
                    do
                    {
                        let data = try Data.init(contentsOf: userImageURL!)
                        DispatchQueue.main.async {
                            image = UIImage(data: data)!
                            // ...
                            let param = [
                                "username":name!,
                                "emailaddress":email!,
                                "deviceid":Userdefault.shared.getDeviceId(),
                                "socialid":String(idToken!),
                                "socialtype":Socialtype.Google.rawValue,
                                "platform":Platform.iOS.rawValue,
                                "registertype":Registertype.Social.rawValue] as [String : Any]
                            self.signUpViewModel.signUp(param: param, image: image!)
                        }
                    }
                    catch let error{
                        print("error:",error.localizedDescription)
                    }
                }
            }
            else{
                let param = [
                    "username":name!,
                    "emailaddress":email!,
                    "deviceid":Userdefault.shared.getDeviceId(),
                    "socialid":String(idToken!),
                    "socialtype":Socialtype.Google.rawValue,
                    "platform":Platform.iOS.rawValue,
                    "registertype":Registertype.Social.rawValue] as [String : Any]
                self.signUpViewModel.signUp(param: param, image: image!)
            }
           
        }
        else
        {
            print("\(error.localizedDescription)")
        }
    }
    
}
