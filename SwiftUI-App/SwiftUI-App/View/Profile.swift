//
//  Profile.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer();
                Text("这是个人中心的页面").font(.headline).foregroundColor(.black).background(Color.white)
                Image(systemName: "heart.circle").resizable().frame(width: 200, height: 200, alignment: .center).imageScale(.medium).foregroundColor(.pink)
                Spacer();
            }
        }.navigationTitle("我的")
         .navigationBarTitleDisplayMode(.automatic)

    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
