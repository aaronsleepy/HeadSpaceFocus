//
//  ViewController.swift
//  HeadSpaceFocus
//
//  Created by Aaron on 2022/11/20.
//

import UIKit

class FocusViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    var curated: Bool = false
    var items: [Focus] = Focus.list
    
    // Datasource
    typealias Item = Focus
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton.layer.cornerRadius = 10
        
        // datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // data: snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        
        toggleRefreshButtonTitle()
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func toggleRefreshButtonTitle() {
        let title = curated ? "Seel All" : "See Recommendation"
        refreshButton.setTitle(title, for: .normal)
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        print("button")
        
        curated.toggle()

        self.items = curated ? Focus.recommendations : Focus.list

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
        
        toggleRefreshButtonTitle()
    }
}

