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
    @IBOutlet weak var priceLabel: UILabel!

    var viewModel: MediaDetailViewModel!

    override func setup() {
        super.setup()

        trackButton.setImage(trackButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        trackButton.titleLabel?.numberOfLines = 0

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
                self.priceLabel.text = "\(m.currency ?? "") \(m.trackPrice ?? 0)"
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
        let closeBtn = UIBarButtonItem.createButton(imageName: "cancel", target: self, action: #selector(close))

        navigationItem.leftBarButtonItem = closeBtn
        navigationItem.rightBarButtonItem = deleteBtn
    }

    func setupVideoPlayer() {
//        playerController = AVPlayerViewController()
//        playerController.view.backgroundColor = .clear
//
//        self.addChild(playerController)
//        previewView.addSubview(playerController.view)
//        playerController.view.frame = previewView.frame
//
//        // layout
//        previewView.translatesAutoresizingMaskIntoConstraints = false
//        playerController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            playerController.view.leadingAnchor.constraint(equalTo: previewView.leadingAnchor),
//            playerController.view.trailingAnchor.constraint(equalTo: previewView.trailingAnchor),
//            playerController.view.topAnchor.constraint(equalTo: previewView.topAnchor),
//            playerController.view.bottomAnchor.constraint(equalTo: previewView.bottomAnchor)
//            ])
    }

    @objc func deleteTapped() {
        ConfirmationPopup.create(title: "POPUP_ARE_YOU_SURE_WANT_TO_DELETE".localized,
                                 completion: { [weak self] state in
                                    if state == .yes {
                                        self?.navigationController?.dismiss(animated: true, completion: nil)
                                        self?.viewModel.delete?()
                                    }
        }).show()
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func trackTapped(_ sender: Any) {
        // test purposes for playing track

        if let prevUrl = viewModel.element.value?.previewUrl, let videoUrl = URL(string: prevUrl) {
            let vc = MediaPlayerViewController.initFromNib()
            vc.videoUrl = videoUrl
            self.present(vc, animated: true, completion: nil)
//            let playerItem = AVPlayerItem(url: URL(string: prevUrl)!)
//            let videoPlayer = AVPlayer(playerItem: playerItem)
//            videoPlayer.actionAtItemEnd = .none
//
//            let playerController = AVPlayerViewController()
//            playerController.view.frame = view.frame
//
//            let vc = UIViewController()
//            vc.view.frame = view.frame
//            vc.view.backgroundColor = .black
//
//            vc.addChild(playerController)
//            vc.view.addSubview(playerController.view)
//
//            playerController.player = videoPlayer
//            playerController.player?.play()
        }
    }

    @IBAction func toggleTapped(_ sender: Any) {
        viewModel.collapsed.value = !viewModel.collapsed.value
    }

}
