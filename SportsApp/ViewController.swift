//
//  ViewController.swift
//  SportsApp
//
//  Created by Nareman on 22/04/2024.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var sports : [SportItem]?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sports = getSportsData()
        registerCustomCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports!.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func getSportsData() -> [SportItem]{
        let sports =  [SportItem(sportImage: "sports",sportTitle: "Football"),
                       SportItem(sportImage: "sports",sportTitle: "BasketBall"),
                       SportItem(sportImage: "sports",sportTitle: "Cricket"),
                       SportItem(sportImage: "sports",sportTitle: "Tennis")]
        return sports
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCollectionViewCell
        cell.sport_name_lb.text = sports?[indexPath.row].sportTitle
               cell.sport_img.image = UIImage(named: (sports?[indexPath.row].sportImage)!)
        

        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height:180)
    }
    
    
   
    func registerCustomCell(){
        let cellNib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.frame = view.bounds
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
    }
    
}

