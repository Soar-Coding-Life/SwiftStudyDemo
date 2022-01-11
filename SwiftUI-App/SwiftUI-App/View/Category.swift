//
//  Category.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI

struct Category: View {
    var body: some View {
        NavigationView {
            ListDataView()
             //大标题此处略坑 写到外层`NavigationView`的括号后面无效 只能写在Group这后面才行
             .navigationBarTitle("分类")
             .navigationBarTitleDisplayMode(.automatic)
        }
        
    }
}

struct Category_Previews: PreviewProvider {
    static var previews: some View {
        Category()
    }
}
