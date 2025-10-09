import UIKit
import AVKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var fisrtNameTf: UITextField!
    
    @IBOutlet weak var lastNameTf: UITextField!
    
    
    @IBOutlet weak var emailTf: UITextField!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var registerModel: SignUpModel?
    
    @IBOutlet weak var lengthLabel: UILabel!
       @IBOutlet weak var numberSpecialLabel: UILabel!
       @IBOutlet weak var upperLowerLabel: UILabel!
       @IBOutlet weak var spaceLabel: UILabel!
       @IBOutlet weak var emailPartLabel: UILabel!
    var userEmail: String = "testuser@example.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialstate()
        passwordTf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
           
        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainView.layer.masksToBounds = true
        
        setupVideoPlayer()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
     
    }
    @objc func textDidChange(_ textField: UITextField) {
            guard let password = textField.text else { return }
            
            updateLabel(lengthLabel,
                        text: "Between 8 and 30 characters",
                        isValid: password.count >= 8 && password.count <= 30)
        
            let numberRegex = ".*[0-9]+.*"
        
            let specialCharRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
            let hasNumber = NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password)
            let hasSpecial = NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: password)
            updateLabel(numberSpecialLabel,
                        text: "Include a number (1234) and one special character (#%!.^)",
                        isValid: hasNumber && hasSpecial)
            let hasUpper = password.range(of: "[A-Z]", options: .regularExpression) != nil
            let hasLower = password.range(of: "[a-z]", options: .regularExpression) != nil
        
            updateLabel(upperLowerLabel,
                        text: "Uppercase (ABC) and lowercase (abc) letters",
                        isValid: hasUpper && hasLower)
    
            updateLabel(spaceLabel,
                        text: "No blank spaces",
                        isValid: !password.contains(" "))
            
            
            let emailPart = userEmail.split(separator: "@").first ?? ""
            updateLabel(emailPartLabel,
                        text: "It cannot contain any part of your email address",
                        isValid: !password.lowercased().contains(emailPart.lowercased()))
        }
        
        private func updateLabel(_ label: UILabel, text: String, isValid: Bool) {
            if isValid {
                label.textColor = .systemGreen
                
                let symbol = "✅"
                
                
                let spacing = String(repeating: " ", count: 5)
                label.text = symbol + spacing + text
                
                
            } else {
                label.textColor = .systemRed
                let symbol = "❌"
                let spacing = String(repeating: " ", count: 5)
                label.text = symbol + spacing + text
            }
           
        }
    func initialstate() {
        updateLabel(lengthLabel,
                        text: "Between 8 and 30 characters",
                        isValid: false)
            
            updateLabel(numberSpecialLabel,
                        text: "Include a number (1234) and one special character (#%!.^)",
                        isValid: false)
            
            updateLabel(upperLowerLabel,
                        text: "Uppercase (ABC) and lowercase (abc) letters",
                        isValid: false)
            
            updateLabel(spaceLabel,
                        text: "No blank spaces",
                        isValid: false)
            
            updateLabel(emailPartLabel,
                        text: "It cannot contain any part of your email address",
                        isValid: false)
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func alreadyacccontBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        }
    
    @IBAction func dissmissAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func createBtnAction(_ sender: UIButton) {
        registerApi()
    }
}
extension SignUpVC {
    func registerApi() {
        var param = [String:Any]()
        param = ["contact_name":fisrtNameTf.text ?? "","last_name":lastNameTf.text ?? "" ,"email":emailTf.text ?? "","password":passwordTf.text ?? ""]
        print(param)
        
        SignUpViewModel.registerApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.registerModel = response
            print("jai hind")
            self.navigationController?.popViewController(animated: true)
        }
    }
}

  
