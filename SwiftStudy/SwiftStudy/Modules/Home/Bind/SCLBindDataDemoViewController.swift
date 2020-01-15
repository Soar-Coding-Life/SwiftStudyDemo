//
//  SCLBindDataDemoViewController.swift
//  SwiftStudy
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

private let minimalUsernameLength = 8
private let minimalPasswordLength = 6


class SCLBindDataDemoViewController: SCLBaseViewController {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var accountTipsLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordTipsLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "绑定数据-登录表单"
        self.accountTipsLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        self.passwordTipsLabel.text = "Password has to be at least \(minimalPasswordLength) characters"

        let userNameValid = self.accountTextField.rx.text.orEmpty
            .map{$0.count >= minimalUsernameLength}.share(replay: 1)
        
        let passwordValid = self.passwordTextfield.rx.text.orEmpty
            .map{$0.count >= minimalPasswordLength}.share(replay: 1)
        
        let zipValid = Observable.combineLatest(userNameValid,passwordValid) { $0 && $1}.share(replay: 1)

        userNameValid.bind(to: passwordTextfield.rx.isEnabled).disposed(by: disposeBag)
        userNameValid.bind(to: accountTipsLabel.rx.isHidden).disposed(by: disposeBag)
        passwordValid.bind(to: passwordTipsLabel.rx.isHidden).disposed(by: disposeBag)
        zipValid.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        loginBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            let alertVC = UIAlertController(title: "恭喜！", message: "登录成功！！！", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default) { action in
                sclLog(action.title!)
            }
            alertVC.addAction(confirmAction)
            self?.present(alertVC, animated: true, completion: nil)

            }).disposed(by: disposeBag)
        
    }

}
