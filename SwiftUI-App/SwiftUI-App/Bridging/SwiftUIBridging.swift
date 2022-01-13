//
//  SwiftUIBridging.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI

struct SwiftUIBridging: UIViewControllerRepresentable {
    typealias UIViewControllerType = TestUiKitViewController
    //要显示的UIKit的控制器
    func makeUIViewController(context: Context) -> TestUiKitViewController {
        return TestUiKitViewController()
    }
    //更新UI时会回调这个方法
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

struct TestUiKitVC : View {
    var body: some View {
        SwiftUIBridging()
    }
}


struct UIKitView : UIViewRepresentable {
    @Binding var imageName : String
    @Binding var text : String

    func makeUIView(context: Context) -> MyView {
//        return MyView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        return MyView(frame: .zero)
        return MyView()
    }
    
    func updateUIView(_ uiView: MyView, context: Context) {
        uiView.textLabel.text = self.text ;
        uiView.imageView.image = UIImage(systemName: self.imageName)
    }
    
    typealias UIViewType = MyView
}

struct TestUIKitView : View {
    @State var imageName:String = ""
    @State var text : String = ""
    var body: some View {
        UIKitView(imageName: $imageName, text: $text)
    }
}
