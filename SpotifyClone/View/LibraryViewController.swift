//
//  LibraryViewController.swift
//  SpotifyClone
//
//  Created by Linder Anderson Hassinger Solano    on 6/05/22.
//

import UIKit

class LibraryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageProfile: UIImageView!
    
    let playListViewModel = PlayListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTable()
        Task {
            await setUpData()
        }
    }

    func setUpView() {
        imageProfile.image = HelperImage.setImageFromUrl(url: HelperString.imageProfileLink)
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
    }
    
    func setUpData() async {
        await playListViewModel.getPlayList()
        tableView.reloadData()
    }
    
    func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return playListViewModel.playList?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "BgDark")
        return uiView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let playList = playListViewModel.playList?.items[indexPath.section]
        cell.textLabel?.text = playList?.name
        cell.detailTextLabel?.text = playList?.itemDescription
        
        cell.imageView?.image = playList?.images.count ?? 0 > 0
        ? HelperImage.setImageFromUrl(url: playList?.images[0].url ?? "")
        : UIImage(named: "music-note")
        return cell
    }
    
}
