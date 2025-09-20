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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func alreadyacccontBtnAction(_ sender: UIButton) {
//        let nav = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        nav.regitervalue = "1"
//        self.navigationController?.pushViewController(nav, animated: false)
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

  
