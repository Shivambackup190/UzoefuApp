//
//  DemoClass.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 08/08/25.
//

import UIKit
import AVKit

class DemoClass: UIViewController {

    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
      // MARK: Global property

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var myscrolleview: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        myscrolleview.contentInsetAdjustmentBehavior = .never
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
        // Optionally loop or navigate here
         videoPlayer?.seek(to: .zero)
         videoPlayer?.play()
    }
}
