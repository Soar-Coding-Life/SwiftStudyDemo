//
//  SwiftUI_AppApp.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI


@main
struct SwiftUI_AppApp: App {
    
    init() {
        setupApperance()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .accentColor(.orange)
                .onOpenURL(perform: { url in
                    print(url)
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                })
        }
    }
    
    private func setupApperance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.orange,
        ], for: .normal)
        
        UIWindow.appearance().tintColor = UIColor.orange
    }

}
