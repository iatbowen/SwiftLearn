//
//  UIGroup1ViewController1.swift
//  SwiftLearn
//
//  Created by 叶修 on 2024/12/6.
//

import UIKit

@objcMembers
class UIViewController1 : UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
}

/*
 1、5种修饰符访问权限排序 open > public > interal > fileprivate > private
 open: 类似于 public，但允许在其他模块中继承或重写。
 public: 公开访问，可以在任何模块中访问。
 internal: 默认访问级别，只能在同一模块中访问。
 fileprivate: 文件私有访问，限制在定义类型的文件中。
 private: 私有访问，只能在同一文件中访问。
 
 2、mutating
 Swift 的 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量
 在使用 class 来实现带有 mutating 的方法的协议时，具体实现的前面是不需要加 mutating修饰的，因为 class 可以随意更改自己的成员变量
 
 3、自动闭包(@autoclosure)
 只支持 () -> T 的格式参数
 是一种把函数参数为普通表达式自动转换为一个闭包的能力，意味着该表达式的计算会被延迟到闭包被调用的时候进行
 性能优化：在某些场合，可以避免对不必要的表达式进行计算。如果传入的表达式比较复杂或计算代价高，那么只有在确需时才会进行计算。像 ??, &&, ||
 func getFirstPositive(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int {
     return v1 > 0 ? v1 : v2()
 }
 getFirstPositive(1, 2)

 4、逃逸闭包(@escaping)、非逃逸闭包(@noescaping)
 @escaping 是用在闭包类型前的关键字，表示闭包可能会在函数返回之后被调用，可以被存储和异步执行
 @noescaping 只用在函数体内被执行，在函数返回时闭包生命周期结束。
 工作原理
 当闭包被标记为 @escaping 时，编译器会将闭包在堆（heap）上分配内存，从而确保闭包在函数返回后仍然存在。
 而非逃逸闭包则被分配在栈（stack）上，随着函数返回自动销毁。
 
 5、操作符
 precedencegroup：定义操作符的优先级
 associativity：操作符的结合律
 higherThan、lowerThan：运算符的优先级
 prefix、infix、postfix：前缀、中缀、后缀运算符
 
 /// 例子
 precedencegroup Precedence {
     higherThan: AdditionPrecedence
     associativity: none
     assignment: false
 }
 infix operator +++: Precedence
 func +++(left: Int, right: Int) -> Int {
     return left + right * 2
 }
 print(2+++3)
 
 6、inout:输入输出参数
 允许你在函数内部修改函数参数的值，并将修改后的值反映回调用者
 
 当你给函数参数加上 inout 关键字时，Swift 会在调用函数时进行以下操作：
 - 复制传入值的地址：当你将一个变量传递给 inout 参数时，Swift 会让函数参数指向变量存储的内存地址，而不是传递变量的副本。
 - 在函数内部允许直接修改：函数内部对这个 inout 参数的修改将作用于原始变量，因为函数操作的是内存地址而不是副本。
 - 将修改后的值写回：当函数执行完毕时，Swift 会把修改后的值写回给原始变量。这就意味着，传入的变量在函数调用后会有可能被修改。
 注意事项
 - 使用 & 符号：在调用接受 inout 参数的函数时，你需要在参数名称前加上 & 符号。这表明你理解并接受这个变量可能会在函数内被修改。
 - 不能传递常量或字面值：因为 inout 参数期望可以被修改的存储地址，你不能传递常量或字面量（如 42 或 "string"）给 inout 参数。
 - 并发考虑：由于 inout 参数在函数中直接操作内存地址，并且会对传入的变量进行原地修改，应该在并发或多线程的上下文中谨慎使用。
 
 7、typealias 别名
 - 简化复杂类型
 typealias CompletionHandler = (Bool, String) -> Void
 - 增强代码的可读性和语义
 typealias Kilometers = Double
 - 简化泛型类型
 typealias StringDictionary = Dictionary<String, String>
 
 8、associatedtype 关联类型
 
 协议不允许使用泛型参数,想要协议使用泛型,请使用关联类型代替
 protocol Container {
     associatedtype Item
     var items: [Item] { get set }
     mutating func append(_ item: Item)
 }

 泛型类型被基础类型替换
 struct IntContainer: Container {
     typealias Item = Int
     var items = [Int]()
     mutating func append(_ item: Int) {
         items.append(item)
     }
 }
 
 在带泛型的class中,泛型类型填充关联类型
 class Stack <E>: Container {
     var items: [E] = []
     func append(_ element: E){
         items.append(element)
     }
 }
 
 注意事项
 不能作为函数形参
 func get(list: Container) {} //编译错误,协议Runnable里面有关联类型,类型不确定,所以不能当做定义函数的形参
 可以改为
 func get(list: any Container) {}
 或者
 func get<T: Container>(_ type:Int)->T{ //让泛型类型T遵守协议,然后返回T
     if 0 == type {
         let result = IntContainer() as! T
         return result
     }
     return Stack() as! T
 }
 
 9、初始化
 类有两种初始化器:
 - 指定初始化器(designated initializer)
 - 便捷初始化器(convenience initializer)
 
 初始化器的相互调用规则
 - 指定初始化器必须从他的直系父类调用指定初始化器
 - 便捷初始化器必须从相同的类里调用另一个初始化器
 - 便捷初始化器最终必须调用一个指定初始化器
 
 10、static和class
 作用：这两个关键字都是用来说明被修饰的属性或者方法是类型(class/struct/enum)的，而不是类型实例的。
 
 static 适用的场景(class/struct/enum)
 - 修饰存储属性
 - 修饰计算属性
 - 修饰类型方法
 
 class 适用的场景
 - 修饰类方法
 - 修饰计算属性
 
 注意事项
 - class不能修饰类的存储属性，static可以修饰类的存储属性
 - protocol 使用 static 来修饰类型级别的方法或者计算属性是为了声明这些方法和属性在实现协议的类型中是属于类型级别的，swift 4.0之前可以使用class修饰
 - static修饰的类方法不能继承；class修饰的类方法可以继承
 
 原理
 static编译期绑定： 绑定的方法和属性在编译期间即被确定。这意味着方法调用或属性访问在编译时会被直接解析为对具体类型的访问，这提高了访问速度。
 class运行时绑定：修饰的方法是通过动态派发实现的。这意味着具体的实现版本会在运行时决定。Swift 使用虚方法表（vtable）来管理这种动态调用。
 
 11、匹配模式
 - 通配符模式(Wildcard Pattern)（_ 匹配任何值，_? 匹配非nil值）
 - 标识符模式(Identifier Pattern)
 - 值绑定模式(Value-Binding Pattern)
 - 元祖模式(Tuple Pattern)
 - 枚举Case模式(Enumeration Case Pattern)
 - 可选模式(Optional Pattern)
 - 类型转换模式(Type-Casting Pattern)
 - 表达式模式(Expression Pattern)
 
 12、AnyClass，元类型(.Type)，.self，Any，AnyObject
 - AnyClass 和元类型：用于描述和操作类型本身。
 - .self：是获取类型元类型。
 - Any：是用于存在类型的显式标识。
 - AnyObject：用于表示任何引用类型对象，特别是在与 Objective-C 交互时。
 
 13、属性
 - 存储属性：存储属性将会在内存中实际分配地址进行属性的存储
 - 计算属性：计算属性则不包括存储，只是提供set和get方法
 
 存储属性观察方法
 class Person {
     var age:Int = 0{
         willSet{
             print("即将将年龄从\(age)设置为\(newValue)")
         }
         didSet{
             print("已经将年龄从\(oldValue)设置为\(age)")
         }
     }
 }
 
 计算属性
 class A {
     var number:Int {
         get{
             print("get")
             return 1
         }
         set{
             print("set")
         }
     }
 }
 
 在同一个类型中，属性观察和计算属性是不能同时共存的
 
 14、lazy 懒加载
 class SomeClass {
     lazy var heavyProperty: String = {
         return "Computed String"
     }()
 }
 注意事项
 - 只能用于变量属性（var）：lazy 属性必须是变量属性，因为初始值可能不是在实例初始化时赋值的。
 - 不可用于 let 常量：let 常量在声明时就必须要设定初值，但 lazy 属性会延迟初始化，所以二者互不兼容。
 - 线程安全：lazy 属性的延迟计算在多线程环境中调用时需要注意线程安全，因为多个线程可能会同时触发初始化。
 - 使用实例方法或属性：lazy 属性的初始化闭包体可以访问 self 以及实例的其他成员，因为它是在实例化完全初始化后执行的。
 
 15、Optional（?）
 var optionalString: String? = "Hello"
 print(optionalString) // 输出: Optional("Hello")
 optionalString = nil  // 设置为 nil
 解包可选值
 - 强制解包:
 if optionalString != nil {
     print(optionalString!) // 强制解包，在确保非 nil 时使用
 }
 - 可选绑定
 if let unwrappedString = optionalString {
     print(unwrappedString) // 安全解包，不会引发崩溃
 } else {
     print("optionalString is nil")
 }
 - 使用 guard 语句:
 func greetGuest(name: String?) {
     guard let guestName = name else {
         print("No guest")
         return
     }
     print("Hello, \(guestName)!")
 }
 
 链式调用
 class Residence {
     var numberOfRooms = 1
 }
 class Person {
     var residence: Residence?
 }

 let john = Person()

 if let roomCount = john.residence?.numberOfRooms {
     print("John's residence has \(roomCount) room(s).")
 } else {
     print("Unable to retrieve the number of rooms.")
 }
 
 使用 nil 合并运算符
 nil 合并运算符 (??) 提供了一种简洁的方式，当可选项为 nil 时提供一个默认值。
 let optionalName: String? = nil
 let fullName: String = optionalName ?? "Anonymous"
 print(fullName) // 输出: "Anonymous"

 16、final
 Swift 中，final 关键字可以在 class、func 和 var 前修饰。表示 不可重写 可以将类或者类中的部分实现保护起来,从而避免子类破坏
 
 17、extension
 它不仅可以扩展某种类型或结构体的方法，同时它还可以与 protocol 等结合使用为协议提供默认实现
 
 18、`@objc`，`@objc`(类名)，`@objcMembers`区别
 - @objc: 用于单个类、方法、属性、变量等，显式暴露给 Objective-C。
 - @objc(类名): 用于为 Swift 类在 Objective-C 中提供自定义名称。
 - @objcMembers: 用于整个类，使类中所有成员自动暴露给 Objective-C，减少重复标记。
 
 19、dynamic
 KVO（键值观察）：
 Swift 中对属性的观察依赖于 Objective-C 的 Key-Value Observing（KVO）机制实现。 若要在 Swift 中使用 KVO，需要将相关属性标记为 @objc dynamic。
 Objective-C 运行时特性：
 由于 Swift 的方法派发默认是静态的（静态派发提高了运行时性能），在某些需要依赖 Objective-C 运行时特性（例如消息转发、方法交换）中，使用 dynamic 是必需的。
 
 标准用法:
 class MyClass: NSObject {
     @objc dynamic var name: String = "Default"  // 使用 @objc dynamic 来支持 KVO
     @objc dynamic func doSomething() {
         print("Doing something")
     }
 }
 属性: 任何需要参与 KVO 的 Swift 属性必须标记为 dynamic，且通常也需要 @objc。
 方法: 如果方法需要在运行时动态地决定调用哪个版本，使用 dynamic。
 
 20、 is, as, as?, as!
 - is：检查类型，返回布尔值。
 - as：用于安全的向上或横向转换。
 - as?：尝试安全地进行类型转换，并返回可选类型（如果不能转换，返回 nil）。
 - as!：强制类型转换，假设转换一定能成功（失败会导致崩溃）。
 
 21、defer
 延迟执行，修饰一段函数内任一段代码，使其必须在函数中其他代码执行完毕，函数即将结束前调用；如果有多个defer会自下而上的顺序执行
 func test(){
     print("函数开始")
     defer{
         print("执行defer1")
     }
     print("函数将结束")
     defer{
         
         print("执行defer2")
     }
     defer{
         print("执行defer3")
     }
 }
 
 22、`@discardableResult`
 在 Swift 中，@discardableResult 是一个属性， 可以用来标记函数或者方法的返回值，使得编译器不会发出未使用结果的警告。
 这个属性非常有用，尤其是在函数的执行副作用比返回值更重要，或者当返回值在某些情况下可能被忽略的时候。
 



 */
