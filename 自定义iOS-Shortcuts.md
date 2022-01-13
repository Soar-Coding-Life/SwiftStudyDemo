> iOS 快捷指令



1. 在App主工程新建target  ->  iOS -> Intents Extension -> Next

   选择swift,  Staring Point选择none, 不用勾选☑️ include UI Extension

2. 新建一个SiriKit Intent Definition File ,即默认命名为 `Intents.intentdefinition`文件

   > 注意⚠️ 
   >
   > 需要勾选☑️关联主工程和当前shortcuts两个target !!!
   >
   > 需要勾选☑️关联主工程和当前shortcuts两个target !!!
   >
   > 需要勾选☑️关联主工程和当前shortcuts两个target !!!
   >
   > 不然会出现快捷指令列表找不到该App

3. 操作`Intents.intentdefinition`文件新建`Intent`指令配置,配置相关字段,`Xcode`自动生成对应的模板类,可通过 Xcode快捷键 `⌥ + ⌘ + 4` 在`Inspectors`栏的`Custom Class`处的箭头点击进去查看

4. 添加`info.plist`字段 , `IntentsSupported`是个数组,添加`Info.plist`需要关联新建的`Intent`指令即可

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSExtension</key>
	<dict>
		<key>NSExtensionAttributes</key>
		<dict>
			<key>IntentsRestrictedWhileLocked</key>
			<array/>
			<key>IntentsSupported</key>
			<array>
        <!--- 此处加Intent名称 即在Intents.intentdefinition创建的 (有点坑就是自定义命名会自动追加后缀Intent 比如定义为001和002它就生成001Intent和002Intent) -->
				<string>001Intent</string> 
				<string>002Intent</string>
			</array>
		</dict>
		<key>NSExtensionPointIdentifier</key>
		<string>com.apple.intents-service</string>
		<key>NSExtensionPrincipalClass</key>
    <!-- 默认生成的入口文件 -->
		<string>$(PRODUCT_MODULE_NAME).IntentHandler</string>
	</dict>
</dict>
</plist>
```

5. 以下为生成UUID字符串的例子

   ```swift
   //新建 GetUUIDStringIntent之后 创建 GetUUIDHandler 实现对应的代理方法
   // 通过闭包 返回 GetUUIDStringIntentResponse 结果
   class GetUUIDHandler : NSObject, GetUUIDStringIntentHandling {
       func handle(intent: GetUUIDStringIntent, completion: @escaping (GetUUIDStringIntentResponse) -> Void) {
           let res = GetUUIDStringIntentResponse(code: .success, userActivity: nil)
           res.uuid = self.getUUIDString()
           completion(res)
       }
       
       func getUUIDString() -> String {
           let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
           let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
   //        let uuidString = (strRef! as String).replacingOccurrences(of: "-", with: "")
           return (strRef! as String)
       }
   }
   
   
   import Intents
   
   class IntentHandler: INExtension {
     //Switch模式匹配 返回对应的对象
       override func handler(for intent: INIntent) -> Any {
           switch intent {
           case is GetUUIDStringIntent:
               return GetUUIDHandler()
           default:
               fatalError("No handler for this intent")
           }
       }
   
   }
   
   ```

   



