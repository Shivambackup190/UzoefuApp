//
//  ChooseregistrationVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 05/09/25.
//

import UIKit
import AVFoundation

class ChooseregistrationVc: UIViewController {

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
    
       
    @IBAction func individualBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func bussnessBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SiguUpBussnessVc") as! SiguUpBussnessVc
        self.navigationController?.pushViewController(nav, animated: true)
    }
    @IBAction func signinAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        print("hjngj")
    }
}
    

   


