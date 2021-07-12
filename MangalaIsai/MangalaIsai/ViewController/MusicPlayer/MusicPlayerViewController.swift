//
//  MusicPlayerViewController.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 14/03/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroudImage(self.view.bounds.size)
        collectionView.register(UINib(nibName: "MusicPlayerCell", bundle: nil), forCellWithReuseIdentifier: "MusicPlayerCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
         NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        let orientation = UIDevice.current.orientation
        print(orientation)
        self.setBackgroudImage(self.view!.frame.size)
    }
}


extension MusicPlayerViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicPlayerCell", for: indexPath) as! MusicPlayerCell
        return cell
    }
}
