//
//  UIViewController4.swift
//  SwiftLearn
//
//  Created by 叶修 on 2024/12/9.
//

import UIKit

class UIViewController4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

/**
 1、Swift 优点 （相对 OC）
 - 现代语法和特性：
 Swift 拥有现代、简洁且更接近自然语言的语法，减少了不必要的符号，使代码易读且语义清晰。支持闭包、元组、泛型和高级函数类型等，使代码功能更强大。
 
 - 类型安全和类型推断：
 Swift 是类型安全的语言，能够在编译时捕捉类型错误，减少运行时崩溃。类型推断降低了开发者的负担，使代码更简洁。
 
 - 安全性：
 引入了可选（Optional）类型，帮助开发者处理nil值，降低了空指针异常的风险。Swift 强制使用let和var定义常量和变量，避免未经处理的数据突变。
 
 - 性能：
 Swift 通过优化编译器和使用高效的内存管理，通常运行速度更快。支持原生数值类型的代数运算优化，更贴近硬件性能。
 
 - 内存管理：
 自动引用计数（ARC）在函数和方法调用间统一工作，避免影响性能的复杂操作。
 
 - 函数式编程支持：
 Swift 支持函数作为一等公民，可用于传递、返回和操作，支持函数式编程模式。
 
 - 模块化和命名空间：
 Swift 使用模块化系统，避免了Objective-C中常见的命名空间冲突问题。
 
 - 写法简洁：
 减少了代码冗长，特别是在声明属性和接收实现协议的方法时，因为这些操作无需头文件。舍去了OC中常见的`@`符号和分号，使代码更紧凑。
 
 - 错误处理：
 提供强大的错误处理机制，使用do-catch使得代码的健壮性更强。
 
 - 互操作性：
 尽管Swift是新语言，但它可以与Objective-C无缝互操作，允许开发者逐步迁移项目。
 
 2、Class和Struct
 1）class
 核心特性：
 - 引用类型：类是引用类型。当你赋值或传递类实例时，你操作的是对该实例的引用，而不是实例本身的拷贝。
 - 继承： 类支持继承(前提是没有被 final 关键字修饰)，意味着你可以基于已有类创建一个新类，并扩展或重写父类的功能。
 - 多态性：类支持运行时类型检查和类型转换，这可以实现多态性。
 - 去初始化器（deinit）：类可以实现析构函数（deinit），用于在类实例被释放前执行清理操作。
 - 自动引用计数（ARC）：内存管理通过 ARC 实现，自动处理对象的生命周期。
 
 使用场景：
 - 需要继承和多态性的场合。
 - 大量对象需要共享状态或需要在多个地方访问和修改对象。
 - 使用 NSObject 或与 Objective-C 的其他 Interop API集成。
 
 2）Struct
 核心特性：
 - 值类型：结构体是值类型。当你赋值或传递结构体实例时，会复制一份该实例的所有数据。
 - 不可变性： 默认情况下，结构体的实例是不可变的。当使用let声明实例时，它的属性也不可变。
 - 没有继承：结构体不能继承，这意味着它们只能由自身或通过协议扩展。
 - 成本较低：结构体的复制操作相对简单，不需要管理引用计数，因此在将频繁复制的小型简单数据存储为结构体时可能更有效。
 - 线程安全：因为是值类型，每个实例操作的是自身的拷贝，避免了竞争条件和线程安全问题。
 
 使用场景：
 - 描述几何数据如点、大小和矩形。
 - 描述较轻量级数据结构，在复制开销低并且不需要共享状态时使用。
 - 构建简单且独立的封装数据逻辑。
 
 3）总结
 - 类适用于需要共享状态、行为的多态性和复杂对象关系的场合。
 - 结构体更适用于不需要共享和更轻量的数据建模，在大多数情况下，这种不可变性和更简单的堆栈内存管理非常有效。
 
 相同点：
 - 都能定义 property、method、initializers，都支持 protocol、extension

 不同点
 - class是引用类型；struct是值类型
 - class支持继承；struct不支持继承
 - class声明的方法修改属性不需要mutating关键字；struct需要
 - class没有提供默认的memberwise initializer；struct提供默认的memberwise initializer
 - class支持引用计数(Reference counting)；struct不支持
 - class支持Type casting(类型转换)；struct不支持
 - class支持Deinitializers(析构器)；struct不支持
 
 3、swift调用方法底层原理和OC有什么区别
 Objective-C 方法调用
 - 消息传递机制：在 Objective-C 中，方法调用的底层是基于消息传递的（message passing）。当你调用一个方法时，实际上是在向对象发送消息。
 - 运行时解析：Objective-C 的方法调用是在运行时通过 objc_msgSend 函数进行的。这个函数通过接收者对象的类来查找并调用相应的方法实现。
 - 动态特性：Objective-C 的动态性很强，允许各种运行时特性，比如方法交换、动态方法添加、消息转发等。这使得它更为灵活，但也可能带来一些性能开销。
 
 Swift 方法调用
 - 静态派发：Swift 的默认方法调用是通过静态派发实现的。方法的调用在编译时就被确定，通过函数指针直接调用，而不需要在运行时进行方法查找。
 - 协议与动态派发：虽然 Swift 主要使用静态派发，但在处理一些动态特性时（比如协议中的 dynamic 方法或使用关键字如 @objc 时），Swift 也会使用 Objective-C 式的动态派发方式。
 - 内联与优化：Swift 编译器会进行很多优化，包括方法内联，这在某些情况下可以进一步提高运行效率。
 
 注意：
 @objc 并不意味着 Swift 本身会使用动态派发。Swift 默认优先使用静态派发（static dispatch），这是因为 Swift 在编译时可以更容易地确定需要调用的方法，从而提高性能。
 当方法需要被 Objective-C 使用时（如通过 @objc 暴露的方法），它们就需要符合 Objective-C 的调用机制。
 同时使用 @objc 和 dynamic，则明确告诉 Swift 使用 Objective-C 的动态派发机制。
 
 4、Swift中strong 、weak和unowned是什么意思？二者有什么不同？何时使用unowned？
 - strong 代表着强引用，是默认属性。当一个对象被声明为 strong 时，就表示父层级对该对象有一个强引用的指向。此时该对象的引用计数会增加1。
 - weak 代表着弱引用。当对象被声明为 weak 时，父层级对此对象没有指向，该对象的引用计数不会增加1。它在对象释放后弱引用也随即消失。继续访问该对象，程序会得到 nil，不亏崩溃
 - unowned  代表着无主引用 实例销毁后仍然存储着实例的内存地址(类似于OC中的unsafe_unretained), 试图在实例销毁后访问无主引用，会产生运行时错误(野指针)
 
 5、怎么理解 copy - on - write? 或者 理解Swift中的写时复制
 值类型在复制时,复制对象 与 原对象 实际上在内存中指向同一个对象, 当且仅当修改复制的对象时,才会在内存中创建一个新的对象,
 为了提升性能，Struct, String、Array、Dictionary、Set采取了Copy On Write的技术，比如仅当有“写”操作时，才会真正执行拷贝操作

 原理：在结构体内部用一个引用类型来存储实际的数据，
 - 在不进行写入操作的普通传递过程中，都是将内部的reference的应用计数+1，
 - 当进行写入操作时，对内部的 reference 做一次 copy 操作用来存储新的数据；防止和之前的reference产生意外的数据共享。

 swift中提供[isKnownUniquelyReferenced]函数，他能检查一个类的实例是不是唯一的引用，
 如果是，我们就不需要对结构体实例进行复制，如果不是，说明对象被不同的结构体共享，这时对它进行更改就需要进行复制。

 6、Swift 为什么将 Array，String，Dictionary，Set，设计为值类型？
 1）值类型 相比 引用类型的优点
 - 值类型和引用类型相比,最大优势可以高效的使用内存;
 - 值类型在栈上操作,引用类型在堆上操作;
 - 栈上操作仅仅是单个指针的移动,
 - 堆上操作牵涉到合并,位移,重链接

 Swift 这样设计减少了堆上内存分配和回收次数,使用 copy-on-write将值传递与复制开销降到最低
 String，Array，Dictionary设计成值类型，也是为了线程安全考虑。通过Swift的let设置，使得这些数据达到了真正意义上的“不变”，它也从根本上解决了多线程中内存访问和操作顺序的问题

 7、Swift和OC中的 protocol 有什么不同?
 
 1）主要区别：
 多类型支持：
 Swift：protocol 可以被类（class）、结构体（struct）、枚举（enum）遵循。这使得协议在 Swift 中非常灵活，不仅限于类。
 Objective-C：protocol 主要用于类。虽然在一定条件下可以让其他类型（如 id）遵循，但不是直接支持的。
 
 可选协议方法：
 Objective-C：可以使用 @optional 关键字来定义可选协议方法，必须将协议声明为 @objc，这样遵循者可以选择实现或不实现。
 Swift：默认情况下，协议中的方法都是必需实现的。如果需要可选方法，通常通过定义协议扩展（extension）来提供默认实现。对于 Objective-C 协议，仍可以使用 @objc optional 来实现类似 Objective-C 的可选方法。
 
 协议扩展：
 Swift：支持协议扩展（protocol extensions），可以为协议提供默认实现。这允许在不改变类型的情况下拓展功能，非常强大且灵活。
 Objective-C：没有直接等价的协议扩展功能，通常需要通过类别（categories）实现一些相似的功能。
 
 关联类型：
 Swift：允许协议使用 associatedtype 定义一个或多个关联类型，使得协议更具通用性和适应性。这是 Swift 协议的一大优势，特别是在泛型编程中。
 Objective-C：协议中不支持关联类型。
 
 类型约束：
 Swift：可以在协议上添加更复杂的类型约束，如使用泛型和关联类型的约束。
 Objective-C：协议本身不能直接表达复杂的类型约束。
 
 协议合成：
 Swift：可以将多个协议合成为一个临时的组合协议，例如 SomeType: ProtocolA & ProtocolB。
 Objective-C：可以用尖括号指定多个协议，如 id<ProtocolA, ProtocolB>，但没有 & 这种语法糖。
 
 面向协议编程：
 Swift：苹果提倡使用面向协议编程（Protocol-Oriented Programming），鼓励使用协议扩展和协议组合来实现多态和代码复用。
 Objective-C：传统上以面向对象编程为主，不具备 Swift 那样广泛使用 protocol 的能力。
 
 8、比较Swift 和OC中的初始化方法 (init) 有什么不同?
 swift 增加了两段式初始化和安全检查
 1）Swift 两段式初始化
 - 第一阶段：属性初始化
   * 内存分配：为对象实例分配合适的内存空间，其中包括存储所有属性的空间。
   * 类层次结构初始化：从最底层的基类开始逐步向上调用类的指定初始化器（Designated Initializer）。每个类负责初始化自己的重复定义的属性。
   * 禁止访问 self：在第一阶段使用 self 只能用来初始化属性，但是不能依赖其他未初始化的属性。
 
 - 第二阶段：自定义初始化
   * 配置和个性化：一旦所有继承的和自身的存储属性都初始化完毕，self 变得可用。此时，你可以访问属性、调用方法，对对象进行进一步配置和个性化。
   * 调用方法：在这个阶段，各种实例方法都可以被安全调用，self 变得完整可用。

 2）Swift 安全检查
 - 属性初始化检查：所有非可选类型的存储属性都必须被初始化
 - 禁止对未初始化 self 的访问：在第一阶段中，任何对 self 的访问都会被编译器阻止。这包括试图调用实例方法或访问属性。
 - 父类初始化必须先完成：在初始化子类属性之前，子类必须调用父类的初始化方法。这一要求确保父类的初始化链是完整和正确的。
 - 防止意外使用：初始化器执行时，如果未获得编译器对self的完全初始化确认，那么无法通过self方式进行属性或方法的访问。这样确保了整个实例处于正确的状态。
 - 可选类型的安全性：在某些情况下，使用可选类型来处理属性，可以保证属性可以为空，但无法保证初始化的最终值。这种情况下，开发者需要通过其他的条件逻辑来确保安全性。
 例子：
 class Computer {
     var processor: String
     var ram: Int
     // 指定初始化器
     init(processor: String, ram: Int) {
         // 初始化自身的属性
         self.processor = processor
         self.ram = ram
         // 第一阶段完成：Computer类的属性已初始化
     }
 }

 class Laptop: Computer {
     var batteryLife: Int
     // 指定初始化器
     init(processor: String, ram: Int, batteryLife: Int) {
         // 初始化子类特定的属性之前，不调用方法或访问self的未初始化属性
         self.batteryLife = batteryLife
         // 必须调用父类的指定初始化器
         super.init(processor: processor, ram: ram)
         // 第二阶段：可使用self
         print("Laptop with \(processor) processor and \(ram)GB RAM with \(batteryLife) hours battery life.")
     }
 }
 let myLaptop = Laptop(processor: "Intel i7", ram: 16, batteryLife: 10)
 // 输出: Laptop with Intel i7 processor and 16GB RAM with 10 hours battery life.


 两段式初始化总结
 第一阶段初始化本类的所有属性，然后调用父类初始化器；
 第二阶段允许进一步配置实例（如调用方法和访问属性）。
 这种顺序确保子类属性在进行任何父类的初始化逻辑之前都得到安全设置。
 
 9、swift 初始化为啥是先赋值自身属性在调用super
 1）确保初始化的顺序安全性
 - 确保子类属性的完整性：
 在调用父类初始化之前，Swift 迫使子类的所有属性都被初始化。这样，子类在调用父类初始化器时就是一个完整的对象，防止使用未初始化的状态。
 
 - 类型安全与编译时检查：
 Swift 是一个类型安全的语言，强调在编译期发现问题。通过确保初始化程序中的所有属性在父类初始化之前设置，Swift 能在编译时验证，没有属性被遗漏。

 2）内存安全与管理
 - 内存布局：
 在 Swift 中，内存布局是固定和安全的。通过在调用父类初始化器之前先初始化自身的属性，Swift 确保对象实例在内存中的状态一致。这样有助于自动引用计数（ARC）系统有效地管理内存。
 - 避免未定义行为：
 在初始化一个类对象时，如果对象的某些属性没有被初始化就被访问，可能会导致未定义行为。通过强制初始化顺序，Swift 避免了这种潜在的问题。
 
 3）继承链的完整初始化
 - 防止从未完全初始化的子类访问父类方法：
 在一些设计中，调用父类方法可能会导致触发子类中依赖未初始化属性的方法或逻辑。先初始化子类的属性确保子类的状态已经完全设置，然后进入父类链条的初始化。
-  确保一致性：
 父类的初始化可能依赖于完整的子类初始化。例如，某些计算可能要结合子类的属性值。因此，确保子类初始化的完整性可以保持继承关系的稳定性。
 
 10、Swift 与 OC 如何相互调用
 1）Swift 调用 Objective-C
 - 桥接头文件：在 Swift 项目中如果需要调用 Objective-C 的代码，需要创建一个桥接头文件（通常命名为 ProjectName-Bridging-Header.h）。
 - Swift 自动生成接口：在引入桥接头文件之后，Swift 可以自动推断 Objective-C 接口，并在 Swift 中使用。
 - 使用 Objective-C 代码：可以直接在 Swift 文件中使用 Objective-C 的类、方法和属性。
 2）Objective-C 调用 Swift
 - 生成 Swift 接口头文件：Swift 自动为编译后的 Swift 模块生成一个 Objective-C 兼容的头文件，这个文件的名字是 ModuleName-Swift.h。
 - 公开 Swift 类给 Objective-C：确保你想要公开给 Objective-C 使用的 Swift 类、方法、和属性是用 @objc 修饰的。
 - 注意 Swift 特有特性：Swift 的某些特性，如泛型、结构体、枚举和命名空间，并不能直接导出到 Objective-C。例如，Swift 的枚举和结构体不能被暴露给 Objective-C
 3）注意点
 Swift 暴露给 OC 的类 不继承继承 NSObject， 但是使用了`@objc`有什么限制？
 - 仅限 @objc 标记的部分：只有那些被 @objc 标记的函数、属性和协议方法能够被 Objective-C 识别和调用。
 - 不能暴露整个类：整个类不能直接被用于 Objective-C。也就是说，Objective-C 代码无法实例化这个 Swift 类，因为这个类本身未被暴露，只有特定成员可用。
 - 没有动态特性：因为 OC 中的方法调用 是通过 Runtime 机制，需要通过 isa 指针 去完成消息的发送等， 只有继承自 NSObject 的类 才具有 isa 指针，才具备 Runtime 消息 发送的能力

 11、Swift 中的函数重载
 构成函数重载的规则
 - 函数名相同
 - 参数个数不同 || 参数类型不同 || 参数标签不同
 注意: 返回值类型 与函数重载无关
 
 12、Swift 中的枚举,关联值 和 原始值的区分?
 1）原始值：指枚举类型的每个用例所对应的一个基础数据类型（如字符串、整数、浮点数等）的值
 enum Direction: String {
     case north = "North"
     case south = "South"
     case east = "East"
     case west = "West"
 }
 // 使用原始值初始化
 if let direction = Direction(rawValue: "North") {
     print("Direction:", direction) // Output: Direction: north
 }
 
 2）关联值：关联值允许每个枚举 case 存储来自不同类型的附加信息，每个 case 的关联值类型可以不同
 enum NetworkResult {
     case success(data: Data)
     case failure(error: Error)
 }
 // 使用关联值创建枚举实例
 let result = NetworkResult.success(data: Data())
 switch result {
 case .success(let data):
     print("Data received:", data)
 case .failure(let error):
     print("Error occurred:", error)
 }
 
 12、什么是可选链？
 可选链是一个调用和查询可选属性、方法和下标的过程，它可能为 nil ：
 - 如果可选项包含值，属性、方法或者下标的调用成功；
 - 如果可选项是 nil ，属性、方法或者下标的调用会返回 nil 。
 - 多个查询可以链接在一起，如果链中任何一个节点是 nil ，那么整个链就会得体地失败。

 13、协议继不继承 NSObjectprotocol 区别
 1）不继承 NSObjectProtocol 的协议
 - 纯 Swift 协议：纯 Swift 协议是完全独立于 Objective-C 的。这意味着它们只能被 Swift 的类型（类、结构体、枚举）遵循。
 - 不受限于 Objective-C 特性：没有对于 Objective-C 运行时系统的任何约束，例如动态派发。更多地利用 Swift 的特性，比如泛型的使用、associated types（关联类型）等。
 - 更灵活与功能性：允许在结构体和枚举中使用，所以可以在值类型中广泛应用。提供更丰富的类型安全和编译期检查。
 - 使用场景：当不需要与 Objective-C 代码进行交互的时候，尤其是在完全的 Swift 项目中或核心逻辑中适合使用。
 
 2）继承 NSObjectProtocol 的协议
 - 与 Objective-C 互操作：继承自 NSObjectProtocol 的协议，即具备与 Objective-C 互操作的能力。这些协议可以用于定义需要暴露给 Objective-C 的接口。
 - 限定于类类型：继承自 NSObjectProtocol 的协议通常只能被类类型遵循，自动获得 NSObject 的特性，比如对 respondsToSelector:、isEqual:, description 等方法的支持。
 - 运行时功能：提供对 Objective-C 运行时特性（例如 KVO、KVC）以及动态特性的支持。可以在 Objective-C 中实现的类中使用这些协议，维护跨语言兼容性。
 - 使用场景：适用于与 Objective-C 代码集成的场景，特别是在混合项目中或需要动态派发功能。
 
 14、Swift 是面向对象还是函数式的编程语言?
 Swift 既是面向对象的，又是函数式的编程语言。
 Swift 是面向对象的语言，是因为 Swift 支持类的封装、继承、和多态
 Swift 是函数式编程语言，是因为 Swift 支持 map, reduce, filter, flatmap 这类去除中间状态、数学函数式的方法，更加强调运算结果而不是中间过程
 
 15、为什么数组越界会崩溃,而字典用下标取值时key没有对应值的话返回的是nil而不会崩溃?
 数组崩溃的策略: 确保程序在试图进行无效操作时立即失败，从而帮助开发者在调试阶段尽早地发现并修复错误。
 字典返回 nil 的策略: 提供一种更安全、常见的方式来检查是否存在某个键值对，这避免了额外的崩溃，并符合大多数用例期望，例如通过 nil 合并运算符 (??) 提供默认值。
 


 */
