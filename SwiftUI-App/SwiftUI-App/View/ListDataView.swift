//
//  ListDataView.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI

struct ListDataView: View {
    @State private var showingAlert = false
    @State private var clickIndex = 0
// 子页面 避免添加 `NavigationView` 不然容易出现多个导航栏嵌套问题 
    var body: some View {
            Group {
                List {
                    Section(header: Text("第一组")) {
                        ForEach(1...20,id: \.self) { index in
                            HStack {
                                Button(action:{
                                    self.showingAlert = true
                                    self.clickIndex = index
                                }){
                                    Text("item -- \(index)")
                                }.alert(isPresented: $showingAlert) {
                                    Alert(title: Text("友好提示"),
                                          message: Text("第一组 item -- \(self.clickIndex)"),
                                          dismissButton: .default(Text("好的👌")))
                                }
                                Spacer()
                                Image(systemName: "chevron.right").imageScale(.small).foregroundColor(Color.gray)
                            }.padding([.top,.bottom],10)
                        }
                    }
                    
                    Section(header: Text("第二组")) {
                        ForEach(21...40,id: \.self) { index in
                            HStack {
                                Button(action:{
                                    self.showingAlert = true
                                    self.clickIndex = index
                                }){
                                    Text("item -- \(index)")
                                }.alert(isPresented: $showingAlert) {
                                    Alert(title: Text("友好提示"),
                                          message: Text("第二组 item -- \(self.clickIndex)"),
                                          dismissButton: .default(Text("好的👌")))
                                }
                                Spacer()
                                Image(systemName: "chevron.right").imageScale(.small).foregroundColor(Color.gray)
                            }.padding([.top,.bottom],10)
                        }
                    }
                    
                }
            } //大标题此处略坑 写到外层`NavigationView`的括号后面无效 只能写在Group这后面才行
             .navigationBarTitle("分类")
             .navigationBarTitleDisplayMode(.automatic)
        }
}

