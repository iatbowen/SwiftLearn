//
//  UIViewController6.swift
//  SwiftLearn
//
//  Created by 叶修 on 2024/12/11.
//

import UIKit

class UIViewController6: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

/*
 Swift的方法调度有3种不同方式：
 直接派发（Direct Dispatch）
 函数表派发（Table Dispatch）
 消息派发（Message Dispatch）
 1. 派发方式：
                          直接派发           函数表         消息转发
 值类型                    所有方法            N/A            N/A
 协议                     extension         主体初始化        N/A
 类                extension(final，static) 主体初始化     @objc+dynamic
 NSObject(子类)    extension(final，static) 主体初始化     @objc+dynamic
 
 2. 总结：
 extension中声明的函数是静态派发，编译的时候就已经确定了调用地址，子类无法继承重写，但是可以访问
 函数表(VTable)用来存储类中的方法，存储方式类似于数组，方法连续存放在函数表中。
 PWT (Protocol witness table) 仅在调用对象类型为 Protocol 类型时，才会被引用
 @objc + dynamic 组合修饰的函数调度，是执行的是objc_msgSend流程，即 动态消息转发

 3. 派发效率：
 从高到低为： 直接派发 > Table 派发 > Message 派发


 Swift底层探索（四）Swift函数调用过程的探索
 https://juejin.cn/post/7146163291096612872
 Swift 底层是怎么调度方法的
 https://gpake.github.io/2019/02/11/swiftMethodDispatchBrief/
 swift底层探索 05 -深入探讨swift的方法调用机制swift底层探索 05 -深入探讨swift的方法调用机制
 https://cloud.tencent.com/developer/article/1858028
 Swift函数派发机制
 https://harryyan.github.io/2021/08/27/Swift%E5%87%BD%E6%95%B0%E6%B4%BE%E5%8F%91%E6%9C%BA%E5%88%B6/
 
 */
