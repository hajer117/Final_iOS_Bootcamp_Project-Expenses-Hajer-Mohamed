//
//  ViewController.swift
//  ExpensesprojectH
//
//  Created by hajer . on 16/05/1443 AH.
//

import UIKit

class ViewController: UIViewController{
  
  var ProductPhotos = [UIImage(named: "ImageColl3")!,
                          UIImage(named: "ImageColl2")!,
                          UIImage(named: "ImageColl1")!]
  
  var timer : Timer?
  var currentCellIndex = 0
  
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  // MARK: - View lifecycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpElements()
    startTimer()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    pageControl.numberOfPages = ProductPhotos.count
  }
  
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 3,
                                 target: self,
                                 selector: #selector (moveToNextIndex),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  @objc func moveToNextIndex() {
    if currentCellIndex < ProductPhotos.count - 1{
      currentCellIndex += 1
    } else {
      currentCellIndex = 0
    }
    
    collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
    pageControl.currentPage = currentCellIndex
  }
  
    func setUpElements() {
    
    Utilities.styleFilledButton(signUpButton)
    Utilities.styleFilledButton(loginButton)
  }
}
// MARK: - extension UICollection

extension ViewController: UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout{
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return ProductPhotos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homecell", for: indexPath) as! CollectionVC
    cell.imgProductPhoto.image = ProductPhotos[indexPath.row]
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}