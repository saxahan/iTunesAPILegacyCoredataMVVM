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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var trackButton: HoldableButton!
    @IBOutlet weak var toggleButton: HoldableButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    var viewModel: MediaDetailViewModel!
    var playerController: AVPlayerViewController!

    override func setup() {
        super.setup()

        trackButton.setImage(trackButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)

//        setupVideoPlayer()
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
                self.topImageView.setImage(m.pictureUrl(width: Int(self.view.frame.width), height: Int(self.view.frame.height))?.absoluteString ?? "")

                self.trackButton.setTitle(m.trackName ?? m.artistName, for: .normal)
                self.descriptionLabel.text = m.longDescription ?? m.description ?? m.shortDescription

//                if let prevUrl = m.previewUrl {
//                    let playerItem = AVPlayerItem(url: URL(string: prevUrl)!)
//                    let videoPlayer = AVPlayer(playerItem: playerItem)
//                    videoPlayer.actionAtItemEnd = .none
//                    self.playerController.player = videoPlayer
//                    self.playerController.player?.play()
//                }
            }
        }

        viewModel.collapsed.addObserver(fireNow: true) { [unowned self] (collapsed) in
            DispatchQueue.main.async {
                self.scrollView.isScrollEnabled = !collapsed
                self.scrollView.setContentOffset(collapsed ? .zero : CGPoint(x: 0, y: self.scrollView.contentOffset.y + 150), animated: true)
                self.toggleButton.setImage(UIImage(named: collapsed ? "down" : "up")?.withRenderingMode(.alwaysTemplate), for: .normal)
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

    @IBAction func trackTapped(_ sender: Any) {
    }

    @IBAction func toggleTapped(_ sender: Any) {
        viewModel.collapsed.value = !viewModel.collapsed.value
    }

}
