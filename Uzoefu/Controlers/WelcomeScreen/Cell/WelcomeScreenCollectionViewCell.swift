//
//  HomeScreenCollectionViewCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 07/08/25.
//

import UIKit
import AVKit

class WelcomeScreenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var exploreLable: UILabel!
    @IBOutlet weak var VideoView: UIView!
    @IBOutlet weak var gradiantView: UIView!
    @IBOutlet weak var pageControlBtn: UIPageControl!
    @IBOutlet weak var screenImage: UIImageView!
    
    var skipBtnClick: (() -> ()) = {}
    var videoPlayer: AVPlayer?
    var avpController = AVPlayerViewController()
    var videoName: String? {
        didSet {
            setupVideoPlayer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //  applyGradientToView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientToView()
    }
    
    @IBAction func skipBtnAct(_ sender: UIButton) {
        skipBtnClick()
    }
    
    func configurePageControl(currentPage: Int, totalPages: Int) {
        pageControlBtn.numberOfPages = totalPages
        pageControlBtn.currentPage = currentPage
    }
    
    private func setupVideoPlayer() {
        guard let videoName = videoName,
              let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("Video file not found for name: \(videoName ?? "nil")")
            return
        }
        
        
        videoPlayer?.pause()
        avpController.view.removeFromSuperview()
        
        videoPlayer = AVPlayer(url: url)
        avpController = AVPlayerViewController()
        avpController.player = videoPlayer
        avpController.view.translatesAutoresizingMaskIntoConstraints = false
        avpController.videoGravity = .resizeAspectFill
        avpController.showsPlaybackControls = false
        
        VideoView.addSubview(avpController.view)
        
        NSLayoutConstraint.activate([
            avpController.view.leadingAnchor.constraint(equalTo: VideoView.leadingAnchor),
            avpController.view.trailingAnchor.constraint(equalTo: VideoView.trailingAnchor),
            avpController.view.topAnchor.constraint(equalTo: VideoView.topAnchor),
            avpController.view.bottomAnchor.constraint(equalTo: VideoView.bottomAnchor)
        ])
        
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: videoPlayer?.currentItem)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: videoPlayer?.currentItem
        )
        
        videoPlayer?.play()
    }
    
    
    
    @objc func videoDidFinishPlaying() {
        
        print(" Video finished playing.")
        videoPlayer?.seek(to: .zero)
        videoPlayer?.play()
    }
    
    private func applyGradientToView() {
        gradiantView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradiantView.bounds
        
        gradientLayer.colors = [
            UIColor(red: 126/255, green: 210/255, blue: 0/255, alpha: 0.0).cgColor,  // Top - transparent
            UIColor(red: 126/255, green: 210/255, blue: 0/255, alpha: 0.5).cgColor,  // Middle - semi
            UIColor(red: 126/255, green: 210/255, blue: 0/255, alpha: 1.0).cgColor   // Bottom - solid
        ]
        
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradiantView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
