//
//  PhotosCollectionViewController.swift
//  Cloud_Interactive
//
//  Created by Marines Chin on 2019/9/20.
//  Copyright © 2019 chin. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var photoCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    let communicator = Communicator.shared
    
    var photosData = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 取得螢幕寬
        let width = self.view.frame.width / 4
        // 設定collectionView Cell
        photoCollectionViewFlowLayout.itemSize = CGSize(width: width, height: width)
        photoCollectionViewFlowLayout.minimumLineSpacing = 0
        photoCollectionViewFlowLayout.minimumInteritemSpacing = 0
        
        // 取資料
        getPhotosData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getPhotosData() {
        communicator.getPhotosData { (data, error, errorString) in
            if let errorString = errorString {
                print("errorString: \(errorString)")
                return
            }
            
            if let error = error {
                print("error: \(error)")
                return
            }
//            print(data)
            guard let data = data as? [[String:Any]] else {
                print("data is nil.")
                return
            }
            
            guard let photosData = Json.decodeWith(responseJSON: data, model: Photos.self) else {
                print("photosData is nil")
                return
            }
            
            self.photosData = photosData
            print(self.photosData.count)
//            print("photosData: \(self.photosData)")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCollectionViewCell
        // Configure the cell

        let photo = self.photosData[indexPath.row]

        cell.idLabel.text = "\(photo.id ?? 0)"
        cell.titleLabel.text = photo.title

        let url = photo.thumbnailUrl

        if let imageUrl = URL(string: url){
            DispatchQueue.global().async {
                do{
                    //利用Data來產生下載內容
                    let imageData = try Data(contentsOf: imageUrl)
                    let downLoadImage = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.photoImage.image = downLoadImage
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }

        return cell
    }

}
