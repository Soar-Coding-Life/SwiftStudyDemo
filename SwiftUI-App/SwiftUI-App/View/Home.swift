//
//  Home.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI

struct Home: View {    
    var body: some View {
        NavigationView {
            Group {
                List {
                    Section(header: Text("section header")) {
                        NavigationLink(destination: TestUiKitView()) {
                            Text("SwiftUI与UIKit交互调用").frame(height: 50)
                        }
                        NavigationLink(destination: Search()) {
                            Text("搜索🔍").frame(height: 50)
                        }
                        NavigationLink(destination: ListDataView()) {
                            Text("列表展示").frame(height: 50)
                        }
                        NavigationLink(destination: Profile()) {
                            Text("个人中心").frame(height: 50)
                        }
                    }
                }
            } //大标题此处略坑 写到外层`NavigationView`的括号后面无效 只能写在Group这后面才行
            .navigationBarTitle("首页")
            .navigationBarTitleDisplayMode(.automatic)
            
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
