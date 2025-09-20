//
//  LoginVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 08/08/25.
//

import UIKit
import AVKit

class LoginVC: UIViewController {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var emailTf: UITextField!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var remeberImg: UIImageView!
    
    @IBOutlet weak var remeberBtn: UIButton!
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var loginModelobject:LoginModel?
    
    var regitervalue:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        remeberImg.image = UIImage(named: "unchecked")
        remeberBtn.configurationUpdateHandler = { button in
            var config = button.configuration ?? UIButton.Configuration.plain()
            config.background.backgroundColor = .clear
            button.configuration = config
        }
     let evalue  = UserDefaults.standard.string(forKey: "email")
//        emailTf.text = evalue
        //qwerty786@gmail.com
        
        emailTf.text    = "qwerty@gmail.com"
        let pvalue =  UserDefaults.standard.string(forKey: "password")
       
//        passwordTf.text = pvalue
        passwordTf.text = "1234@abcD"

        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainView.layer.masksToBounds = true
        
        
        
       
        setupVideoPlayer()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        }

        @objc func hideKeyboard() {
            view.endEditing(true)
        }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        loginApi()
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(nav, animated: true)
        
    }
    @IBAction func forgetBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(identifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func rememberBtnAction(_ sender: UIButton) {
        
        sender.isSelected.toggle()
           
           if sender.isSelected {
               remeberImg.image = UIImage(named: "check")
               UserDefaults.standard.set(emailTf.text, forKey: "email")
               UserDefaults.standard.set(passwordTf.text, forKey: "password")
           } else {
               remeberImg.image = UIImage(named: "unchecked")
               UserDefaults.standard.removeObject(forKey: "email")
               UserDefaults.standard.removeObject(forKey: "password")
           }
       }
    
    private func setupVideoPlayer() {
        guard let url = Bundle.main.url(forResource: "onboard", withExtension: "mp4") else {
            print("Video not found")
            return
        }
        videoPlayer = AVPlayer(url: url)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)

        guard let videoPlayerLayer = videoPlayerLayer else { return }

        videoPlayerLayer.frame = videoView.bounds
        videoPlayerLayer.videoGravity = .resizeAspectFill

        videoView.layer.insertSublayer(videoPlayerLayer, at: 0)
        videoPlayer?.play()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: videoPlayer?.currentItem
        )
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPlayerLayer?.frame = videoView.bounds
    }

    @objc func videoDidFinishPlaying() {
        print("Video finished playing")
         videoPlayer?.seek(to: .zero)
         videoPlayer?.play()
    }
}
extension LoginVC {
    func loginApi() {
        var param = [String:Any]()
        param = ["email":emailTf.text ?? "" ,"password":passwordTf.text ?? ""]
        LoginViewModel.loginApi(viewController: self, parameters: param as NSDictionary) {response in
            self.loginModelobject = response
            CommonMethods.showAlertMessageWithHandler(title: "", message: response?.message ?? "", view: self) {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                self.navigationController?.pushViewController(nav, animated: true)
            }
            
            print("login succsesss")
            guard let data = response?.data else { return }
            let authToken = data.token ?? ""
            UserDefaults.standard.set(authToken, forKey: "token")
            
        }
    }
    
}
