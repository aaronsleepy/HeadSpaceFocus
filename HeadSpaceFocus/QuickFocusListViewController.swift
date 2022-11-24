//
//  QuickFocusViewController.swift
//  HeadSpaceFocus
//
//  Created by Aaron on 2022/11/24.
//

import UIKit

class QuickFocusListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let breathingList = QuickFocus.breathing
    let walkingList = QuickFocus.walking
    
    enum Section: CaseIterable {
        case breathe
        case walking
        
        var title: String {
            switch self {
            case .breathe: return "Breathing exercises"
            case .walking: return "Mindful walks"
            }
        }
    }
    
    typealias Item = QuickFocus
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCell", for: indexPath) as? QuickFocusCell else {
                return nil
            }
            
            cell.configure(item)
            return cell
        })
        
        // Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breathe, .walking])
        snapshot.appendItems(breathingList, toSection: .breathe)
        snapshot.appendItems(walkingList, toSection: .walking)
        dataSource.apply(snapshot)
        
        // Layout
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}
