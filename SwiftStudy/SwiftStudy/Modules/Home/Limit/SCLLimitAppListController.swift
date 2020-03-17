//
//  SCLLimitAppListController.swift
//  SwiftStudy
//
//  Created by 王贵彬 on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import SwiftyJSON

struct AppListItem {
    var applicationId: String!
    var slug: String!
    var name: String!
    var releaseDate: String!
    var version: String!
    var description: String!
    var categoryId: Int = 0
    var categoryName: String!
    var iconUrl: String!
    var itunesUrl: String!
    var starCurrent: String!
    var starOverall: String!
    var ratingOverall: String!
    var downloads: String!
    var currentPrice: String!
    var lastPrice: String!
    var priceTrend: String!
    var expireDatetime: String!
    var releaseNotes: String!
    var updateDate: String!
    var fileSize: String!
    var ipa: String!
    var shares: String!
    var favorites: String!
    
    mutating func updateWithData(json:JSON) -> AppListItem {
        self.applicationId = json["applicationId"].stringValue
        self.slug = json["slug"].stringValue
        self.name = json["name"].stringValue
        self.releaseDate = json["releaseDate"].stringValue
        self.version = json["version"].stringValue
        self.description = json["description"].stringValue
        self.categoryId = json["categoryId"].intValue
        self.categoryName = json["categoryName"].stringValue
        self.iconUrl = json["iconUrl"].stringValue
        self.itunesUrl = json["itunesUrl"].stringValue
        self.starCurrent = json["starCurrent"].stringValue
        self.starOverall = json["starOverall"].stringValue
        self.ratingOverall = json["ratingOverall"].stringValue
        self.downloads = json["downloads"].stringValue
        self.currentPrice = json["currentPrice"].stringValue
        self.lastPrice = json["lastPrice"].stringValue
        self.priceTrend = json["priceTrend"].stringValue
        self.expireDatetime = json["expireDatetime"].stringValue
        self.releaseNotes = json["releaseNotes"].stringValue
        self.updateDate = json["updateDate"].stringValue
        self.fileSize = json["fileSize"].stringValue
        self.ipa = json["ipa"].stringValue
        self.shares = json["shares"].stringValue
        self.favorites = json["favorites"].stringValue
        return self
    }
    
}

public enum AppListType {
    case limit
    case sales
    case free
    case detail
}

class SCLLimitAppListController : SCLBaseViewController {
    var page : Int = 1
    var type : AppListType = .limit
    var dataList : [AppListItem] = []
    
    lazy var tableView:UITableView  = {
        let tab:UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.rowHeight = UITableView.automaticDimension
        tab.estimatedRowHeight = 80
        tab.register(UINib(nibName:"SCLAppListItemCell", bundle: nil), forCellReuseIdentifier: "SCLAppListItemCell")
        self.view.addSubview(tab)
        
        return tab
    }()
    
    init(type:AppListType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        switch type {
        case .limit:
            self.navigationItem.title = "限免应用"
        case .sales:
            self.navigationItem.title = "降价应用"
        case .free:
            self.navigationItem.title = "免费应用"
        case .detail:
            self.navigationItem.title = "应用详情"
        }
        
        if #available(iOS 11.0, *){
            self.tableView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalToSuperview().offset(bottomHeight)
        }
        
        self.getDataRequest()
        self.setUpRefresh()
    }
    
    
    func setUpRefresh(){
        self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { [unowned self] in
            self.page += 1
            self.getDataRequest()
        })
    }
    
    //获取数据
    func getDataRequest() {
        var req : APPRequest
        switch type {
        case .limit:
            req = .limitList(page)
        case .sales:
            req = .salesList(page)
        case .free:
            req = .freeList(page)
        case .detail:
            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            self.tableView.reloadData()
            return;
        }
        
        provider.request(req) { (result) in
            if case  let .success(response) = result {
                let json = JSON(response.data)
                let dataArr = json["applications"].arrayValue
                for json in dataArr {
                    var item = AppListItem()
                    item = item.updateWithData(json: json)
                    self.dataList.append(item)
                }
                self.tableView.mj_footer?.endRefreshing()
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
}

extension SCLLimitAppListController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SCLAppListItemCell = tableView.dequeueReusableCell(withIdentifier: "SCLAppListItemCell") as! SCLAppListItemCell
        cell.isList = !(type==AppListType.detail)
        cell.refreshData(item: dataList[indexPath.row])
        return cell
    }    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .detail {
            return
        }
        
        let vc:SCLLimitAppListController = SCLLimitAppListController(type: .detail)
        vc.dataList = [dataList[indexPath.row]]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
