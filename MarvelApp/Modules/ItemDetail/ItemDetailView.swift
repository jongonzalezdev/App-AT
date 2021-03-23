//
//  ItemDetailView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SDWebImage
import SnapKit

class ItemDetailView: BaseViewController, ItemDetailViewContract {
    
    // MARK: - Outlets
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var comicsTableView: UITableView!
    
    // MARK: - Properties
    var datasource: ComicsTableViewDatasource!
    // swiftlint:disable:next weak_delegate
    var delegate: ComicsTableViewDelegate!
    
	var presenter: ItemDetailPresenterContract!

	// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }

    private func setupView() {
        datasource = ComicsTableViewDatasource()
        delegate = ComicsTableViewDelegate()
        
        comicsTableView.dataSource = datasource
        comicsTableView.delegate = delegate
    }
    
    // MARK: - Public Methods
    func loadDataInView(with character: ItemDetailContract) {
        itemImage.sd_setImage(with: character.itemImage, placeholderImage: UIImage(named: "NotImage"))
        nameLabel.text = character.itemName
        descriptionTextView.text = character.itemDescription
        datasource.comicList = character.itemComics
        comicsTableView.reloadData()
        
        let height = character.itemComics.count * 30
        
        comicsTableView.snp.makeConstraints { make -> Void in
            make.height.equalTo(height)
        }
        
    }
}

class ComicsTableViewDatasource: NSObject, UITableViewDataSource {
    
    var comicList = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = "ComicCell"
        let comic = comicList[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseId)
        
        cell.textLabel?.text = comic
        
        return cell
    }
    
}

class ComicsTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
