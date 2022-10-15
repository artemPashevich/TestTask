//
//  MainViewController.swift
//  TestTask
//
//  Created by Артем Пашевич on 13.10.22.
//

import Alamofire
import SwiftyJSON
import UIKit

final class MainViewController: UIViewController {
    @IBOutlet var menuTable: menuTableView!
    @IBOutlet var newsCollection: NewsCollectionView!
    @IBOutlet var menuBarCollection: menuBarCollectionView!

    private var products: [JSON] = []
    private var constantsTop: NSLayoutConstraint?
    private var newsImage = ["sale", "sale2", "sale3"]
    private var catigory = ["3", "5", "6", "7", "8", "9"]

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        request()
    }
    
    private func layout() {
        constantsTop = newsCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([constantsTop!])
    }
    
    private func request() {
        NetworkService.getProduct { result, _ in
            if let result = result {
                self.products = JSON(result).arrayValue
                print(self.products)
                self.menuTable.reloadData()
            }
        }
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! menuTableViewCell
        let textBtn = products[indexPath.row]["ibu"].description
        cell.btnStyle()
        cell.priceBtn.setTitle("от \(textBtn) р", for: .normal)
        cell.nameProduct.text = products[indexPath.row]["name"].description
        cell.descriptionProduct.text = products[indexPath.row]["tagline"].description
        if let url = URL(string: products[indexPath.row]["image_url"].description) {
            DispatchQueue.global().async { 
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imageProduct.image = image
                        }
                    }
                    else {
                        print("Invalid image")
                    }
                }
            }
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        let swipingDown = y <= 0
        let shouldSnap = y > 30
        let collectionHeight = newsCollection.frame.height + 14

        UIView.animate(withDuration: 0.3) {
            self.newsCollection.alpha = swipingDown ? 1.0 : 0.0
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
            self.constantsTop?.constant = shouldSnap ? -collectionHeight : 0
            self.view.layoutIfNeeded()
        }
    }
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == newsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
            cell.newsImageView.image = UIImage(named: newsImage[indexPath.row])
            cell.layer.cornerRadius = 10
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! menuBarCollectionViewCell
            cell.nameCatigories.text = catigory[indexPath.row]
            cell.layer.cornerRadius = 17
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuBarCollection {
            let cell = menuBarCollection.cellForItem(at: indexPath) as! menuBarCollectionViewCell
            cell.chooseStyle()
            let indexPathCell = NSIndexPath(row: Int(catigory[indexPath.row]) ?? 2, section: 0)
            menuTable.scrollToRow(at: indexPathCell as IndexPath, at: .top, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newsCollection {
            return newsImage.count
        } else {
            return catigory.count
        }
    }
}


