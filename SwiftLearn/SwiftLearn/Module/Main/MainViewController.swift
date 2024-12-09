//
//  MainViewController.swift
//  SwiftLearn
//
//  Created by 叶修 on 2024/7/18.
//

import UIKit

class MainViewControllerCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .separator
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(lineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 20, y: 5, width: contentView.frame.width - 20, height: 20)
        descLabel.frame = CGRect(x: 20, y: 25, width: contentView.frame.width - 20, height: 20)
        lineView.frame = CGRect(x: 20, y: 49, width: contentView.frame.width - 20, height: 0.3)
    }
}

class MainViewController: UIViewController {
    
    var datasource: [String] = ["关键字", "线程", "死锁问题", "泛型，关联类型，类型约束，协议类型"]
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(MainViewControllerCell.self, forCellWithReuseIdentifier: "MainViewControllerCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewControllerCell",
                                                             for: indexPath) as? MainViewControllerCell {
            cell.titleLabel.text = datasource[indexPath.row]
            cell.descLabel.text = "UIViewController\(indexPath.row+1)"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let module = Bundle.main.infoDictionary?["CFBundleName"] as? String
        if let name = module, let clz = NSClassFromString("\(name).UIViewController\(indexPath.row+1)") as? UIViewController.Type {
            let vc = clz.init()
            vc.title = datasource[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
