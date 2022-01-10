##  *Codable* 相关协议的使用

```swift
/// Codable json和model互转
/// CustomStringConvertible 定义description属性 打印结构体或类对象
struct App : Codable,CustomStringConvertible {
    var appName : String=""
    var x_sex : String=""
    var age : Int = 18
    
    enum CodingKeys : String,CodingKey {
        case appName
        case x_sex = "sex"
        case age
    }
    
    var description: String {
        return "\(self.appName) - \(self.x_sex) - \(self.age)"
     }
}

struct SimpleCodingKey : CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

//自定义编码策略 首字母大小
extension JSONEncoder.KeyEncodingStrategy {
    static var convertToPascalCase: JSONEncoder.KeyEncodingStrategy {
        return .custom { codingKeys in
            var str = codingKeys.last!.stringValue
            guard let firstChar = str.first else {
                return SimpleCodingKey(stringValue: str)
            }
            let startIdx = str.startIndex
            str.replaceSubrange(startIdx...startIdx,
                                with: String(firstChar).uppercased())
            return SimpleCodingKey(stringValue: str)
        }
    }
}
// 自定义解码策略 首字母小写
extension JSONDecoder.KeyDecodingStrategy {
    static var convertToPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { codingKeys in
            var str = codingKeys.last!.stringValue
            guard let firstChar = str.first else {
                return SimpleCodingKey(stringValue: str)
            }
            let startIdx = str.startIndex
            str.replaceSubrange(startIdx...startIdx,
                                with: String(firstChar).lowercased())
            return SimpleCodingKey(stringValue: str)
        }
    }
}



class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let json : String = """
            {
                "appName" : "App",
                "sex" : "XXOO",
                "age" : 16
            }
        """
        // 编码
        let app = App(appName:"App", x_sex:"XX", age:18)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToPascalCase
        let resultData = try? encoder.encode(app)
        let dataStr = String(data: resultData!, encoding: .utf8)
        guard let dataStr = dataStr else {
            return
        }
        print(dataStr)

        // 解码
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertToPascalCase
        let person = (try? decoder.decode(App.self, from: data))
        print(person! as App)
        
    }
}

// print log
{"AppName":"App","Sex":"XX","Age":18}
App - XXOO - 16

```

