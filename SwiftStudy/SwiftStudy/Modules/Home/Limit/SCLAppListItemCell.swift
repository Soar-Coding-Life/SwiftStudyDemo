//
//  SCLAppListItemCell.swift
//  SwiftStudy
//
//  Created by 王贵彬 on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class SCLAppListItemCell: UITableViewCell {
    public var isList : Bool = true
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var starOrDownloadsLabel: UILabel!
    @IBOutlet weak var otherInfoLabel: UILabel!
    
    @IBOutlet weak var downloadBtn: UIButton!
    var model : AppListItem?
    
    func refreshData(item : AppListItem){
        self.model = item
        self.iconImageView.kf.setImage(with: URL(string: item.iconUrl))
        self.nameLabel.text = item.name
        self.descLabel.text = item.slug
        self.starOrDownloadsLabel.text = "\(item.starCurrent!)颗⭐️ 已被下载\(item.downloads!)次"

        self.otherInfoLabel.text = isList ? "" :
        """
        当前价格: ¥\(item.currentPrice!)
        原价格: ¥\(item.lastPrice!)
        分享次数: \(item.shares!)次
        收藏次数: \(item.favorites!)次
        应用ID: \(item.applicationId!)
        分类ID: \(item.categoryId)
        分类: \(item.categoryName!)
        类型: \(item.priceTrend!)
        
        描述: \(item.description!)
        
        版本号: \(item.version!)
        包大小: \(item.fileSize!)MB
        
        上线时间: \(item.releaseDate!)
        更新时间: \(item.updateDate!)
        过期时间: \(item.expireDatetime!)

        更新日志: \(item.releaseNotes!)

        """
        
    }
    
    
    @IBAction func downloadAction(_ sender: Any) {
        openURL(scheme: self.model!.itunesUrl)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.iconImageView.layer.cornerRadius = 10
        self.iconImageView.layer.masksToBounds = true
        self.downloadBtn.layer.cornerRadius = 15
        self.downloadBtn.layer.masksToBounds = true
        self.downloadBtn.layer.borderWidth = 1.0
        self.downloadBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
