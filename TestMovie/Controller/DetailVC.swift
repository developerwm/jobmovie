//
//  DetailVC.swift
//  TestMovie
//
//  Created by Tiago on 28/10/2018.
//  Copyright © 2018 Tauã. All rights reserved.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labeVote: UILabel!
    @IBOutlet weak var labeDescription: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgMovie: UIImageView!
    
    var movie: MovieResponse.ItemMovie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        setInformations()
    }

    func setInformations(){
        viewDetail.layer.cornerRadius = 10
        
        labelName.text = movie?.original_title
        labeDescription.text = movie?.overview
        labelScore.text = movie?.popularity?.description
        labeVote.text = movie?.vote_count?.description
        
        imgMovie.layer.cornerRadius = 10
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (movie?.poster_path)!)
        imgMovie.kf.indicatorType = .activity
        imgMovie.kf.setImage(with: url)
        
        let urlBack = URL(string: "https://image.tmdb.org/t/p/w500" + (movie?.backdrop_path)!)
        imgBackground.kf.indicatorType = .activity
        imgBackground.kf.setImage(with: urlBack)
        
        imgBack.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        imgBack.addGestureRecognizer(tapGestureRecognizer)
    }
    
     @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: false)
        dismiss(animated: true, completion: nil)
    }
}
