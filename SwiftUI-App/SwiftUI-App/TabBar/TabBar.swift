//
//  TabBar.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab = Tab.Home
    enum Tab:Int {
        case Home,Search,Category,Profile
    }

    func tabItem(imageName: String, text: String) -> some View {
        VStack {
            Image(systemName: imageName)
                .imageScale(.large)
            Text(text)
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Home().tabItem {
                tabItem(imageName: "arrow.up.arrow.down.square", text: "首页")
            }.tag(Tab.Home)
            Search().tabItem {
                tabItem(imageName: "magnifyingglass.circle.fill", text: "搜索")
            }.tag(Tab.Search)
            Category().tabItem {
                tabItem(imageName: "checkmark.seal.fill", text: "分类")
            }.tag(Tab.Category)
            Profile().tabItem {
                tabItem(imageName: "heart.circle", text: "我的")
            }.tag(Tab.Profile)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
