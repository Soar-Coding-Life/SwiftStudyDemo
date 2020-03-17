//
//  SCLHomeViewController.swift
//  SwiftStudy
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class SCLHomeViewController: SCLBaseViewController {
    lazy var tableView : UITableView = {
        let tab = UITableView(frame: view.bounds, style: .plain)
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tab.dataSource = nil;
        tab.delegate = nil
        view.addSubview(tab)
        return tab
    }()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "首页"
        let dataSource : [String] = [
            "UI与数据绑定",
            "限免应用",
            "降价应用",
            "免费应用"
        ]
        tableView
            .rx.contentOffset
            .map{$0.y}
            .subscribe(onNext: { [unowned self] in
                self.navigationItem.title = "contentOffset.y = \($0)"
                }, onError: { (error) in
                    sclLog(error)
            }, onCompleted: {
                
            }, onDisposed: nil).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            let vc = [
                SCLBindDataDemoViewController(),
                SCLLimitAppListController(type: .limit),
                SCLLimitAppListController(type: .sales),
                SCLLimitAppListController(type: .free),
                ][indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        Observable.just(dataSource).bind(to: tableView.rx.items(cellIdentifier: "cellID", cellType: UITableViewCell.self)){ (_, element, cell) in
            cell.textLabel?.text = "\(element)"
            }.disposed(by: disposeBag)
        
    }
    

}
