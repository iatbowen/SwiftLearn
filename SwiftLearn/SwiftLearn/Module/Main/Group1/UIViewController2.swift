//
//  UIViewController2.swift
//  SwiftLearn
//
//  Created by 叶修 on 2024/12/9.
//

import Foundation
import UIKit

class UIViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        testTask1()
    }
        
    func testTask1() {
        Task {
            // 单一任务
            await performTask()
            // 任务组
            await withTaskGroup(of: String.self) { group in
                for _ in 1...3 {
                    group.addTask {
                        return await self.performTask()
                    }
                }
                // 任务完成后聚合结果
                var results: [String] = []
                for await result in group {
                    results.append(result)
                }
                // 所有任务完成后，打印结果
                print("All tasks completed. Results: \(results)")
            }
        }
    }
    @discardableResult
    func performTask() async -> String {
        print("Task started")
        let result = await fetchData()
        print("Task completed result: \(result)")
        return result
    }
    func fetchData() async -> String {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return "data"
    }
    
}

// MARK: - actor

// Actors 被定义为一个类或结构体，并使用 actor 关键字修饰。Actor 类或结构体中包含一些属性和方法，这些属性和方法只能由 actor 自身或者其他 actor 访问。
// 非 actor 对象无法直接访问 Actor 的属性和方法

final class User: Sendable {
  let name: String
  let age: Int

  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

actor BankAccount {
    let accountNumber: Int
    var balance: Double
    var balances: [Int: Double] = [1: 0.0]
    var name: String
    var age: Int
    
    func user() -> User {
      return User.init(name: name, age: age)
    }
    
    func updateUser(_ user: User) {
      name = user.name
      age = user.age
    }

    enum BankAccountError: Error {
        case insufficientBalance(Double)
        case authorizeFailed
    }
    
    init(accountNumber: Int, initialDeposit: Double) {
        self.accountNumber = accountNumber
        self.balance = initialDeposit
        name = "wenbo"
        age = 100
    }
    
    func deposit(amount: Double) {
        assert(amount >= 0)
        balance = balance + amount
    }
    
    func append(amount: Double) {
        assert(amount >= 0)
        // Actor-isolated property 'balances' can not be referenced from a Sendable closure; this is an error in Swift 6
        for i in 0...1000 {
            // 在 actor 方法内部手动开启子线程，存在 data races，会 crash
            DispatchQueue.global().async {
                let b = self.balances[1] ?? 0.0
                self.balances[1] = b + 1
                print("i = \(i), balance = \(self.balances[1])")
            }
        }
    }
}

extension BankAccount {
    // 在该方法内部只引用了 let accountNumber，故不存在 Data races，也就可以用 nonisolated 修饰
    nonisolated func safeAccountNumberDisplayString() -> String {
        // 在nonisolated方法中是不能访问 isolated state 的
        //        balance = balance + 1
        let digits = String(accountNumber)
        return String(repeating: "X", count: digits.count - 4) + String(digits.suffix(4))
    }
}

extension BankAccount {
    private func authorize() async -> Bool {
        // Simulate the authentication process
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return true
    }
    
    /**
     check—reference/change 二步操作不应跨 await suspension point ：
     - Check：就是检查某个条件或状态，例如验证某个数据是否符合预期。
     - Change：是在确认检查结果之后，对数据进行修改或更新操作。
     二步操作不应跨 await suspension point ：
     - 在异步编程中，await 是一个可能导致程序暂停并等待某个异步操作完成的点（suspension point）。
     - 在您进行状态检查（Check）和随后的状态修改（Change）这两个步骤时，不应在这中间有 await。原因是在 await 期间，程序可能暂停，其他异步操作可能会改变您已经检查的状态，导致您做出的假设失效。
     */
    func withdraw(amount: Double) async throws -> Double {
        guard balance >= amount else {
            throw BankAccountError.insufficientBalance(balance)
        }
        
        // suspension point
        guard await authorize() else {
            throw BankAccountError.authorizeFailed
        }
        
        // re-check
        guard balance >= amount else {
          throw BankAccountError.insufficientBalance(balance)
        }
        
        balance -= amount
        return balance
    }
}

class AccountManager {
    let bankAccount = BankAccount.init(accountNumber: 123456789, initialDeposit: 1_000)
    
    func user() async -> User {
      return await bankAccount.user()
    }
    
    func depoist() async {
        // 对 let accountNumber 可以像普通属性那样访问
        print(bankAccount.accountNumber)
        // 而对于方法，无论是否是异步方法都需通过 await 调用
        await bankAccount.deposit(amount: 1)
        // error: Actor-isolated property 'balance' can not be mutated from a non-isolated context
        //        bankAccount.balance += 1
        // // 可以像普通方法一样调用，无需 await 入队
        _ = bankAccount.safeAccountNumberDisplayString()
    }
    
    func withdraw() async {
        for _ in 0..<2 {
            Task {
                let amount = 600.0
                do {
                    let balance = try await bankAccount.withdraw(amount: amount)
                    print("Withdrawal succeeded, balance = \(balance)")
                } catch let error as BankAccount.BankAccountError {
                    switch error {
                    case .insufficientBalance(let balance):
                        print("Insufficient balance, balance = \(balance), withdrawal amount = \(amount)!")
                    case .authorizeFailed:
                        print("Authorize failed!")
                    }
                }
            }
        }
    }
}

// MARK: - globalActor

@globalActor
public struct MyGlobalActor {
  public actor MyActor { }
  public static let shared = MyActor()
}

@MyGlobalActor var globalVar: Int = 1
actor ClassA {
    @MyGlobalActor static var currentTimeStampe: Int64 = 0
}

@MyGlobalActor class ClassB {
    var b = 0;
    func testB() {}
}

// MARK: - MainActor
class ActorView: UIView {
    func updateSubViews() {
        
    }
}

// MARK: - 描述

/**
 Swift 新并发框架
 在 Swift 新并发模型中进一步弱化了『 线程 』，理想情况下整个 App 的线程数应与内核数一致，线程的创建、管理完全交由并发框架负责。
 
 一、async/await
 1、定义
 - async — 用于修饰方法，被修饰的方法则被称为异步方法(asynchronous method)
 - await — 对异步方法的调用需加上 await，同时，await只能出现在异步上下文中 (asynchronous context)
 2、asynchronous context 存在于 2 种环境下：
 - asynchronous method body — 异步方法体属于异步上下文的范畴
 - Task closure — Task 任务闭包
 
 二、actor
 1、为解决并发中最让人头疼的 Data races 问题，Swift 引入了 Actor model ：
 - Actor 代表一组在并发环境下可以安全访问的(可变)状态；
 - Actor 通过所谓数据隔离 (Actor isolation) 的方式确保数据安全，其实现原理是 Actor 内部维护了一个串行队列 (mailbox)，所有涉及数据安全的外部调用都要入队，即它们都是串行执行的。
 
 2、actor 与class
 1） 相似性：
 - 引用类型；
 - 可以遵守指定的协议；
 - 支持 extension 等。
 2） 区别
 - actor 不支持继承
 - actor 内部实现了数据访问的同步机制
 
 3、Actor isolation
 所谓 Actor isolation 就是以 actor 实例为单元 (边界)，将其内部与外界隔离开，严格限制跨界访问。
 1）跨越 Actor isolation 的访问称之为 cross-actor reference
 - 引用 actor 中的 『 不可变状态 (immutable state) 』
 - 引用 actor 中的 『 可变状态 (mutable state)、调用其方法、访问计算属性 』 等都被认为有潜在的 Data races，故不能像普通访问那样。
 
 4、nonisolated
 Actor 内部通过 mailbox 机制实现同步访问，必然会有一定的性能损耗。
 actor 内部的方法、计算属性
 并不一定都会引起 Data races。为了解决这一矛盾，Swift 引入了关键字 nonisolated 用于修饰那些不会引起 Data races 的方法、属性
 
 5、Actor reentrancy
 为了避免死锁、提升性能，Actor-isolated 方法是可重入的：
 - Actor-isolated 方法在显式声明为异步方法时，其内部可能存在暂停点；
 - 当 Actor-isolated 方法因暂停点而被挂起时，该方法是可以重入的，也就是在前一个挂起被恢复前可以再次进入该方法；
 
 6、globalActor
 如上globalActor例子，可以通过 @MyGlobalActor 对它们进行数据保护，并在它们间形成一个以MyGlobalActor 为界的 actor-isolated：
 - 在 MyGlobalActor 内部可以对它们进行正常访问，如 ClassB.testB方法所做；
 - 在 MyGlobalActor 以外，需通过同步方式访问，如：await globalVar
 
 7、MainActor
 关键点：
 - @MainActor 这个属性确保标记的属性和方法在主线程上访问或修改
 - 可以使用 @MainActor 声明整个类、结构体、方法或特定属性应限制在主线程上
 - Swift 能通过 @MainActor 自动处理主线程切换，以防止因线程问题导致的数据竞争，但是开发者仍然需要在性能敏感的部分谨慎使用
 - 如果从后台线程调用一个被 @MainActor 隔离的方法或访问一个变量，Swift 将自动切换到主线程执行
 
 8、内忧外患
 1）内忧，在 actor 方法内部存在 Data races，它是无能为力的
 2）外患，
 - User 是引用类型(class)；
 - 通过 actor-isolated 方法将 User 实例传递到了 actor 外面；
 - 此后，被传递出来的 user 实例自然得不到 actor 的保护，在并发环境下显然就不安全了。
 
 三、Sendable
 用于向外界声明实现了该协议的类型在并发环境下可以安全使用，更准确的说是可以自由地跨 actor 传递。
 Sendable 和 @Sendable 是 Swift 5.5 中的并发修改的一部分，解决了结构化的并发结构体和执行者消息之间传递的类型检查的挑战性问题。
 特征：
 Sendable 是一个空协议：
 - 具有特定的语义属性 (semantic property)，且它们是编译期属性而非运行时属性
 - 协议体必须为空
 - 不能作为类型名用于 is、as?等操作
 - 不能用作泛型类型的约束
 
 1、 class 需要主动声明遵守 Sendable 协议
 限制：
 - class 必须是 final
 - class 的存储属性必须是 immutable
 - class 的存储属性必须都遵守 Sendable 协议
 - class 的祖先类 (如有) 必须遵守 Sendable 协议或者是 NSObject
 
 2、Sendable 作为协议只能用于常规类型，对于函数、闭包等则无能为力。
 
 3、@unchecked Sendable
 通过 @unchecked attribute 告诉编译器不进行 Sendable 语义检查
 相当于说并发安全由开发人员自行保证，不用编译器检查
 
 4、`@Sendable`
 被 @Sendable 修饰的函数、闭包可以跨 actor 传递。



 
 
 
 */
