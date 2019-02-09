//
//  MediaDetailViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit
import AVKit

class MediaDetailViewController: BaseViewController, ViewModelBased {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var viewModel: MediaDetailViewModel!
    var playerController: AVPlayerViewController!

    override func setup() {
        super.setup()

        setupVideoPlayer()
        bindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.visit?()
    }

    func bindings() {
        viewModel.element.addObserver(fireNow: true) { [unowned self] (media) in
            if let m = media {
                self.title = "\(m.currency ?? "") \(m.trackPrice ?? 0.0)"
                self.trackNameLabel.text = m.trackName ?? m.artistName
                self.descriptionLabel.text = m.longDescription ?? m.description ?? m.shortDescription

                if let prevUrl = m.previewUrl {
                    let playerItem = AVPlayerItem(url: URL(string: prevUrl)!)
                    let videoPlayer = AVPlayer(playerItem: playerItem)
                    videoPlayer.actionAtItemEnd = .none
                    self.playerController.player = videoPlayer
                    self.playerController.player?.play()
                }
            }
        }
    }

    override func initNavbar() {
        super.initNavbar()

        let deleteBtn = UIBarButtonItem.createButton(imageName: "trash", target: self, action: #selector(deleteTapped))
        navigationItem.rightBarButtonItem = deleteBtn
    }

    func setupVideoPlayer() {
        playerController = AVPlayerViewController()
        playerController.view.backgroundColor = .clear
        
        self.addChild(playerController)
        previewView.addSubview(playerController.view)
        playerController.view.frame = previewView.frame

        // layout
        previewView.translatesAutoresizingMaskIntoConstraints = false
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerController.view.leadingAnchor.constraint(equalTo: previewView.leadingAnchor),
            playerController.view.trailingAnchor.constraint(equalTo: previewView.trailingAnchor),
            playerController.view.topAnchor.constraint(equalTo: previewView.topAnchor),
            playerController.view.bottomAnchor.constraint(equalTo: previewView.bottomAnchor)
            ])
    }

    @objc func deleteTapped() {
        ConfirmationPopup.create(title: "POPUP_ARE_YOU_SURE_WANT_TO_DELETE".localized,
                                 completion: { [weak self] state in
                                    if state == .yes {
                                        self?.navigationController?.popViewController(animated: true)
                                        self?.viewModel.delete?()
                                    }
        }).show()
    }
}
