//
//  CustomTableViewCell.swift
//  Project7
//
//  Created by Badr BOUAZZI on 1/15/17.
//  Copyright © 2017 Badr BOUAZZI. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articlePublishedAt: UILabel!
    @IBOutlet weak var backgrounView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.backgrounView.frame
        rectShape.position = self.backgrounView.center
        rectShape.path = UIBezierPath(roundedRect: self.backgrounView.bounds, byRoundingCorners: [.bottomLeft  , .topLeft], cornerRadii: CGSize(width: articleImage.frame.size.width/2, height: articleImage.frame.size.width/2)).cgPath
        
        self.backgrounView.layer.backgroundColor = UIColor.green.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        self.backgrounView.layer.mask = rectShape
        
        articleImage.layer.cornerRadius = self.articleImage.frame.size.width/2
        articleImage.clipsToBounds = true
        articleImage.layer.borderWidth = 3.0
        articleImage.layer.borderColor = UIColor.white.cgColor
        
        backgrounView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        backgrounView.layer.cornerRadius = 5.0
      //  backgrounView.layer.masksToBounds = false
        backgrounView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgrounView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgrounView.layer.shadowOpacity = 0.8
    
    }

}
