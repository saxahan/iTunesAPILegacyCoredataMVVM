//
//  MediaPlayerViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 10.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit
import AVKit

class MediaPlayerViewController: BaseViewController {

    var videoUrl: URL!
    var player = AVPlayer()

    override func setup() {
        super.setup()

        player = AVPlayer(url: videoUrl)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.addChild(playerController)

        playerController.view.frame = self.view.frame
        self.view.addSubview(playerController.view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }
}
