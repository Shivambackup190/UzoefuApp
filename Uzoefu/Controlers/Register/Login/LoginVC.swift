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
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
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
        self.view.endEditing(true) // Hide keyboard
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            tabBarVC.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.first?.rootViewController = tabBarVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        signup.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.first?.rootViewController = signup
            UIApplication.shared.windows.first?.makeKeyAndVisible()
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
