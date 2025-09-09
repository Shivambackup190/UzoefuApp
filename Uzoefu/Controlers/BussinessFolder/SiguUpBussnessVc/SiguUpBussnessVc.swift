//
//  SiguUpBussnessVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 01/09/25.
//

import UIKit
import AVFoundation

class SiguUpBussnessVc: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var videoView: UIView!
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
        self.view.endEditing(true)
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
    
    @IBAction func signInAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        nav.regitervalue = "2"
        self.navigationController?.pushViewController(nav, animated: false)
    }
}

    
  

