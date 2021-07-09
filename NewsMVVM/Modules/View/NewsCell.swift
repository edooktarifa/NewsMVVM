//
//  NewsCell.swift
//  NewsMVVM
//
//  Created by Phincon on 08/07/21.
//

import UIKit
import Kingfisher
import SkeletonView

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleNewsLbl: UILabel!
    @IBOutlet weak var descNewsLbl: UILabel!
    @IBOutlet weak var imgNewsImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        [titleNewsLbl, descNewsLbl, imgNewsImg].forEach {
            $0?.showGradientSkeleton()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(with content: Articles){
        
        titleNewsLbl.text = content.title
        descNewsLbl.text = content.description
        if let image = content.urlToImage {
            imgNewsImg.kf.setImage(with: URL(string: image), placeholder: UIImage(named: "default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        hideAnimation()
    }
    
    func hideAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            [self.titleNewsLbl, self.descNewsLbl, self.imgNewsImg].forEach{
                $0?.hideSkeleton()
            }
        }
    }
    
}
