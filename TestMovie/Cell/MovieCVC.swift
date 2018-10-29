//
//  MovieCVC.swift
//  TestMovie
//
//  Created by Tiago on 28/10/2018.
//  Copyright © 2018 Tauã. All rights reserved.
//

import UIKit

class MovieCVC: UICollectionViewCell {

    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labeName: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         viewBackground.layer.cornerRadius = 10
    }

}
