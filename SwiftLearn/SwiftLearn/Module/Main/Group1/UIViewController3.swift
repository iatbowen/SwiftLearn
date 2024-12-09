//
//  UIViewController3.swift
//  SwiftLearn
//
//  Created by 叶修 on 2024/12/9.
//

import UIKit

class UIViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // https://blog.csdn.net/weixin_42433480/article/details/96651379
    }
}

protocol Summable {
    associatedtype ValueType
    func sum() -> ValueType
}

extension Array: Summable where Element: AdditiveArithmetic {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}

func printSum<T: Summable>(of container: T) where T.ValueType: CustomStringConvertible {
    print("Sum is: \(container.sum())")
}



/**
 1、 泛型
 泛型可以将类型参数化，提高代码复用率，减少代码量

 函数
 func swapValues<T>(_ a: inout T, _ b: inout T) {
     let temp = a
     a = b
     b = temp
 }
 
 结构体或者类
 class Stack<Element> {
     private var elements: [Element] = []

     func push(_ element: Element) {
         elements.append(element)
     }
     
     func pop() -> Element? {
         return elements.popLast()
     }
     
     var top: Element? {
         return elements.last
     }
 }

 
 2、泛型约束
 泛型约束使你可以在泛型函数、类或其他实体中要求类型参数必须符合特定的条件或协议。
 
 函数
 func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
     for (index, value) in array.enumerated() {
         if value == valueToFind {
             return index
         }
     }
     return nil
 }
 
 结构体或者类
 class EquatableStack<Element: Equatable> {
     private var elements: [Element] = []

     func push(_ element: Element) {
         elements.append(element)
     }
     
     func pop() -> Element? {
         return elements.popLast()
     }
     
     func contains(_ element: Element) -> Bool {
         return elements.contains(element)
     }
 }
 
 多重约束
 func compareTwoValues<T: Equatable & Comparable>(_ a: T, _ b: T) -> Bool {
     return a == b
 }
 
 // 也可以用 `where` 子句编写同样的约束
 func compareTwoValuesUsingWhere<T>(_ a: T, _ b: T) -> Bool where T: Equatable, T: Comparable {
     return a == b
 }

 3、关联类型
 关联类型用于协议中，用来定义占位符类型，这些类型在协议被具体采用时才具体化。
 protocol Container {
     associatedtype ItemType
     func append(_ item: ItemType)
     var count: Int { get }
     subscript(i: Int) -> ItemType { get }
 }

 4、关联类型约束
 protocol ComparableContainer {
     associatedtype ItemType: Comparable
     func maximum() -> ItemType
 }

 5、some
 用于定义一个不透明的返回类型。它允许一个函数承诺返回特定协议类型的值，而不具体说明返回的具体类型。这在你希望隐藏内部实现细节时特别有用
 
 protocol Shape {
     func area() -> Double
 }

 struct Circle: Shape {
     var radius: Double
     func area() -> Double {
         return .pi * radius * radius
     }
 }

 struct Square: Shape {
     var side: Double
     func area() -> Double {
         return side * side
     }
 }

 func makeACircle() -> some Shape {
     return Circle(radius: 5.0)
 }

 let shape = makeACircle()
 print(shape.area())  // 输出圆的面积

 6、any
 用于定义一种存在类型，它指示该类型可以是任何符合协议的类型。使用 any 通常意味着失去了一些具体类型的信息，从而稍微降低了一些性能上的优化潜力，但为灵活性提供了空间。
 func printShapeArea(_ shape: any Shape) {
     print("The area is \(shape.area())")
 }

 let circle = Circle(radius: 5.0)
 let square = Square(side: 4.0)

 printShapeArea(circle)  // 可以接受任何类型的 Shape
 printShapeArea(square)

 
 */
