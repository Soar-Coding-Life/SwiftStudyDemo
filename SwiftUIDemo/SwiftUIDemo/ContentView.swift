//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 王贵彬 on 2020/9/29.
//

import SwiftUI
import Combine

struct ListPage : View {
    var body: some View {
        
        List{
            ForEach((1..<10)) { index in
                Text("Item \(index)")
            }.onMove(perform: { indices, newOffset in
                
            }).onDelete(perform: { indexSet in
            
            })
            
        }.navigationBarTitle("Edit Row", displayMode: .large)
        .navigationBarItems(trailing: EditButton())
    }
}

struct TextDemo : View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("占位文字 >").font(.largeTitle).bold().labelStyle(DefaultLabelStyle())
            Text("占位内容 占位内容占位内容占位内容占位内容占位内容占位内容占位内容占位内容")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .bold()
                .italic()
                .font(.title3)
                .fontWeight(.semibold)
                .shadow(color: .green, radius: 10, x: 0, y: 2.0)
            Text("github")
                .foregroundColor(.black)
                .bold()
                .italic()
                .font(.largeTitle)
            Text("https://www.github.com/WangGuibin/WangGuibin")
                .foregroundColor(.blue)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                print("log log")
            })
            
            HStack(alignment: .center, spacing: 10, content: {
                Spacer()
                Text("CoderWGB")
                    .italic()
                    .bold()
                    .shadow(color: .black, radius: 10, x: 1, y: 2)
                Text("热血青年")
                    .foregroundColor(.red)
                    .bold();
                Text("iOS码农")
                    .fontWeight(.bold)
                    .italic()
                    .shadow(color: .red, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 1, y: 2)
                Text("</>")
                    .font(.largeTitle)
                    .bold()
                    .italic()
                Spacer()
            })
            
            Text("哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉哈哈混合砂浆可可粉").lineLimit(3)
                .foregroundColor(.primary)
            Spacer()
        })
        
    }

}

struct TextfieldDemo : View {
    @State var name : String = ""
    @State var pwd : String = ""
        
    var body: some View {
        VStack(alignment: .center, spacing: 15, content: {
            
            HStack(alignment: .center, spacing: 15, content: {
                Spacer()
                Text("昵称: ")
                TextField("请输入昵称", text: self.$name)
                    .frame(height: 44, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
            })
            
            HStack(alignment: .center, spacing: 15, content: {
                Spacer()
                Text("密码: ")
                SecureField("请输入密码", text: self.$pwd)
                    .frame(height: 44, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
            })
            
            Button("提交") {
                print("\(self.$name.wrappedValue) \n \(self.$pwd.wrappedValue)")
            }
                        
        })
    }
    
}

struct ImageDemo : View {
  @State private var imageData : UIImage? = nil
    
    let placeholderImage = UIImage(named: "icon")!
    
    var body: some View {
        Image(uiImage: self.imageData ?? placeholderImage)
            .resizable()
            .onAppear(perform: downloadImage)
            .frame(width: 300, height: 300, alignment: .center).cornerRadius(150.0).onTapGesture(count: 1, perform: {
                print("66666666")
            })
    }
    
    func downloadImage() {
        guard let imgURL = URL(string: "https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/avatar.png") else {
            return
        }
        URLSession.shared.dataTask(with: imgURL){(data,res,error) in
            if let data = data, let image = UIImage(data: data){
                print("图片下载完成")
                self.imageData = image
            }else{
                print("\(String(describing: error))")
            }
        }.resume()
    }
}

struct PickerDemo : View {
    @State var isOn = false
    @State var rating  = 0.66
    @State var stepValue = 0
    
    var body: some View {
        VStack(content: {
            Picker(selection: .constant(1), label: Text("Picker"), content: /*@START_MENU_TOKEN@*/{
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
                Text("4").tag(4)
            }/*@END_MENU_TOKEN@*/)
            
            HStack(content: {
                Spacer()
                Toggle(isOn: $isOn, label: {
                    Text("开关")
                }).onChange(of: self.isOn, perform: { value in
                    self.isOn = !value
                })
                Spacer()
            })
            
            Slider(value: $rating)
            
            Stepper(value: $stepValue, step: 2) { (c) in
                
            } label: {
                Text("\(self.stepValue)")
            }

            
        }).padding(EdgeInsets(.init(top: 20, leading: 20, bottom: 20, trailing: 20)))
    }
    
}

struct NavgationViewDemo : View {
    var body: some View {
        NavigationView(content: {
            NavigationLink(destination: ListPage()) {
                VStack(content: {
                    Text("跳转到下一个页面")
                    Text("")
                    Text("毛玻璃效果文字").bold().italic().blur(radius: 5.0)
                }).padding(20)
                
            }
        })
    }
    
}


struct ContentView : View {
    let items = [
        "List",
        "Text",
        "TextField",
        "Image",
        "Picker",
        "NavigationView"
    ]
    
    var body: some View {
//        ListPage()
//        TextDemo()
//        TextfieldDemo()
//        ImageDemo()
//        PickerDemo()
//        NavgationViewDemo()
        NavigationView{
            List((0..<items.count)) { index in
                NavigationLink(
                    destination: ListPage(),
                    label: {
                        Text(items[index])
                    })
            }.navigationBarTitle("SwiftUI Demo列表", displayMode: .large)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
