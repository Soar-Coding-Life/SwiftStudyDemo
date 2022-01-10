继承和协议



```swift
//类的定义和使用
class Person {
    var name :String?
    var age : Int?
    
    //初始化构造函数
    init(name:String, age: Int) {
        self.name = name
        self.age = age
    }
    
    //析构函数类似OC的delloc
    deinit {
        self.name = nil
        self.age = 0
    }

}



protocol Charging {
    func charging ();
}

class Car {
    var name : String?
    var type : String?

  	/// @discardableResult 该关键字声明的意思是函数返回值可用可不用,编译器不会报警
    @discardableResult
    func showInfo() -> Self {
        print("\(self.name!) -- \(self.type!)")
        return self
    }
}

class NewEnergy : Car,Charging{
    func charging() {
        print("是新能源汽车🚗 可充电~")
    }
}

class Tang : NewEnergy {
    override var name: String? {
        set {
            super.name = newValue
        }
        get {
            return "比亚迪·唐"
        }
        
    }
    override var type: String? {
        set {
            super.type = newValue
        }
        get {
            return "SUV"
        }
    }
}

class Song : NewEnergy {
    override var name: String? {
        set {
            super.name = newValue
        }
        get {
            return "比亚迪·宋"
        }
        
    }
    override var type: String? {
        set {
            super.type = newValue
        }
        get {
            return "SDV"
        }
    }

}

class DaZhong : Car {
    override var name: String? {
        set {
            super.name = newValue
        }
        get {
            return "大众"
        }
        
    }
    override var type: String? {
        set {
            super.type = newValue
        }
        get {
            return "SUV"
        }
    }

}

//调用
        let tang = Tang()
        tang.showInfo().charging()
        puts("\n")
        
        let song = Song()
        song.showInfo().charging()
        puts("\n")

        let dz = DaZhong()
        dz.showInfo()

// console: 
比亚迪·唐 -- SUV
是新能源汽车🚗 可充电~

比亚迪·宋 -- SDV
是新能源汽车🚗 可充电~

大众 -- SUV

```

static修饰的静态方法不可重写,自带final class的性质,class修饰可以重写



**associatedtype**

- **swift**中**protocol**不能使用<**T**>这种泛型，但是提供了**associatedtype**关键字来支持泛型。   

```swift
import UIKit

///定义协议
protocol TableViewCell {
    associatedtype T  ///定义时我们并不知道，他的具体类型.
    func updateCell(_ data:T)
}

struct Model {
    let age:Int
}

///遵循TableViewCell协议
class MyTableViewCell:UITableViewCell,TableViewCell {
    typealias T = Model  ///此时确定协议中定义的未知类型T为 Model
    func updateCell(_ data: Model) {
        
    }
}
```



别名

```swift
protocol ChangeName {
    func changeName(name:String);
}

protocol ChangePhoto {
    func changePhoto(img:UIImage);
}
//起个别名 合并协议
typealias ChangeProfileInfo = ChangeName & ChangePhoto

class Person : ChangeProfileInfo {
    func changeName(name: String) {
        
    }
    func changePhoto(img: UIImage) {
        
    }
}

//闭包别名
typealias DownSuccess = (_ json:String?,_ filePath:String?) -> () ///给比较长的闭包，起一个比较短的别名
func Post(url:String?, paramater:NSDictionary, success:DownSuccess) {
    
}

//基本操作
public typealias AnyClass = AnyObject.Type
public typealias NSInteger = Int


//在实际项目过程中,如果有OC和swift混编的情况,不免以后会对OC进行swift化,而OC和swift的命名系统相差很大,所以在重构之后不免要对整个项目进行 搜索-查找-替换 这是项非常耗时耗力的工作,而利用
//typealias 可以巧妙的规避这个问题

// OC中项目里有个类
#import "OCClass.h"

// swift重构之后
impot SwfitClass

typealias OCClass = SwfitClass
```



# swift @frozen、@inlinable

@frozen 和 @inlinable 是保证这个enum, struct, function的结构不变
@frozen 是对 enum, struct 使用
@inlinable 是对 function 使用

可以保证在项目中引用的某 framework 替换后仍然不需要重新编译,
因为 enum, struct, function 的链接没有发生改变

