//
//  iOSWidget.swift
//  iOSWidget
//
//  Created by 王贵彬(lu.com) on 2022/1/12.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    //出错时的占位
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date:Date(), configuration: ConfigurationIntent(),imageData: UIImage(systemName: "timelapse")!,content: "Hello")
    }

    //选择添加小组件时的快照
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var imageData : UIImage? = nil
        if let data = try? Data(contentsOf: URL(string: "http://127.0.0.1:8080/1.png")!) {
            imageData = UIImage(data: data)
        }
        let entry = SimpleEntry(date: Date(), configuration: configuration, imageData: imageData!,content: configuration.myContent ?? "标题内容")
        completion(entry)
    }

    //数据预处理
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        var imageData : UIImage? = nil
        if let data = try? Data(contentsOf: URL(string: "http://127.0.0.1:8080/1.png")!) {
            imageData = UIImage(data: data)
        }

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, imageData: imageData!,content: configuration.myContent ?? "标题内容")
            entries.append(entry)
        }

        //.never（不刷新），
        //.atEnd（Entry 显示完毕之后自动刷新）
        //.after(date)（到达某个特定时间后自动刷新）
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
//        Widget 刷新的时间由系统统一决定（有时候设置了也不会自己刷新），如果需要强制刷新 Widget，可以在 App 中使用 WidgetCenter 来重新加载所有时间线：WidgetCenter.shared.reloadAllTimelines()。

    }
}

//数据model
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let imageData : UIImage
    let content : String
}

struct iOSWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family // 尺寸环境变量
    
    ///小尺寸
    func systemSmallWidget() -> some View {
        //small只能使用widgetURL 不能用Link定义局部点击
        VStack{
            Text(entry.date,style: .time)
                .widgetURL(URL(string: "https://www.baidu.com")!)
            Text(entry.content).foregroundColor(.red).font(.footnote)
        }
    }
    ///中尺寸
    func systemMediumWidget() -> some View {
        HStack{
            Spacer()
            //局部点击 会先跳转App 在App里监听onOpenURL即可处理链接进行业务逻辑处理
            Link(destination: URL(string: "https://www.baidu.com")!) {
                Text(entry.content).foregroundColor(.blue).underline(true, color: .blue)
                }
            Text(entry.date, style: .time).foregroundColor(.orange).font(.largeTitle)
            Spacer()
        }
    }
    /// 大尺寸
    func systemLargeWidget() -> some View {
        //包裹整个
        Link(destination: URL(string: "https://www.baidu.com")!){
            ZStack{
                if let image = entry.imageData {
                    Image(uiImage: image)
                        .resizable()
                        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity, alignment: .center)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                }else{
                    Image(systemName: "timelapse")
                        .resizable()
                        .foregroundColor(.orange)
                        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity, alignment: .center)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                    
                }
                
                VStack{
                    Spacer()
                    Button(action: {
                        print("小组件点击了按钮~~~~")
                    }) {
                        Text("按钮点击")
                            .foregroundColor(.white)
                            .background(Color.pink)
                            .font(.footnote)
                    }.fixedSize()
                    Text("Hello😁 小组件").font(.headline).foregroundColor(.red)
                    Spacer().frame(height:20)
                    Text(entry.date, style: .time).foregroundColor(.orange).font(.largeTitle)
                    Spacer()
                }
                Text(entry.content)
                    .font(.headline).bold()
                    .foregroundColor(.red)
                    .frame(width: 300, height: 50, alignment: .center)
                    .zIndex(666)
            }
        }
    }
    
    
    var body: some View {
        //样式为unknow
        if entry.configuration.type.rawValue == 0 {
            switch family {
            case .systemSmall:
                 systemSmallWidget()
            case .systemMedium:
                systemMediumWidget()
            case .systemLarge:
                systemLargeWidget()
            default:
                Text(entry.date, style: .time)
            }

        }else{
            //样式枚举 这里写了三种分别是只有时间, 链接+时间, 背景图+时间
            switch entry.configuration.type {
            case .unknown:
                Text("这不可能走到这~")
            case .onlyDate:
                systemSmallWidget()
            case .linkClick:
                 systemMediumWidget()
            case .backgroundImage:
                 systemLargeWidget()
            default:
                systemSmallWidget()
            }
        }
    }
}

@main
struct iOSWidget: Widget {
    let kind: String = "iOSWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            iOSWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("我的小组件")
        .description("这是一个小组件demo")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

//多组件样式入口
//@main
//struct MainWidgets: WidgetBundle {
//
//  @WidgetBundleBuilder
//  var body: some Widget {
    //这样小组件添加页码会出现三次 iOSWidget的小组件 所以可以定义不同样式的组件 每种样式 x 尺寸大小(.systemSmall/.systemMedium/.systemLarge)
//      iOSWidget()
//      iOSWidget()
//      iOSWidget()
//  }
//}

//struct iOSWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        iOSWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
