//
//  ViewController.swift
//  TestMovie
//
//  Created by Tauã on 28/10/2018.
//  Copyright © 2018 Tauã. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import ObjectMapper
import AlamofireObjectMapper

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var activityIndicatorView: UIActivityIndicatorView!
    let screenWidth = UIScreen.main.bounds.size.width - 50
    let screenHeight = UIScreen.main.bounds.size.height + 150
    var listMovies = [MovieResponse.ItemMovie]()
    var pagination: Int = 1
    
    @IBOutlet weak var collectionMovie: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        initCollection()
        
        getMovies(page: 1, loading: true)
    }
    
    func initCollection(){
       collectionMovie.dataSource = self
       collectionMovie.delegate = self
        
        self.collectionMovie!.register(UINib(nibName: "MovieCVC", bundle: nil), forCellWithReuseIdentifier: "idMovieCVC")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 30, right: 8)
        layout.itemSize = CGSize(width: screenWidth/2, height: 600)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        // collection?.invalidateLayout()
        collectionMovie!.collectionViewLayout = layout
        
        collectionMovie.backgroundColor = Helper.hexStringToUIColor(hex: "808080")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovies.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idMovieCVC", for: indexPath as IndexPath) as! MovieCVC
        
        let adOBJ = listMovies[indexPath.row]
        cell.labeName.text = adOBJ.original_title
        cell.labelDate.text = adOBJ.release_date
        cell.labelGender.text = adOBJ.popularity?.description
        
        var urlImage : String = Api.urlImage + adOBJ.poster_path!
        
        let url = URL(string: urlImage)
        cell.imgMovie.kf.indicatorType = .activity
        cell.imgMovie.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let obj = listMovies[indexPath.item]
         gotoDetail(movie: obj)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  24
        let collectionViewSize = collectionView.frame.size.width - padding
        let value = UIScreen.main.bounds.size.height / 2 - 50
        return CGSize(width: collectionViewSize/2, height: value + 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == listMovies.count - 1 {  //numberofitem count
            self.pagination += 1
            self.getMovies(page: pagination, loading: false)
        }
    }

    func gotoDetail(movie: MovieResponse.ItemMovie){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "idDetailVC") as! DetailVC
        nextViewController.movie = movie
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    func getMovies(page: Int, loading: Bool){
        if(loading){
            self.activityIndicatorView = UIActivityIndicatorView(style: .gray)
            self.collectionMovie.backgroundView = self.activityIndicatorView
            self.activityIndicatorView.startAnimating()
        }
        
        var page: String = "&page=" + page.description
        
        Alamofire.request(Api.urlMovie + page, method: .get, parameters: nil).responseObject { (response: DataResponse<MovieResponse>) in
       
            self.activityIndicatorView.stopAnimating()
            let model: MovieResponse = response.result.value!
            
            for data in model.results! {
                self.listMovies.append(data)
            }
            self.collectionMovie.reloadData()
        }
      }
}

