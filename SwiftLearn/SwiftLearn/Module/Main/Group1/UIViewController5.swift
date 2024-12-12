//
//  UIViewController5.swift
//  SwiftLearn
//
//  Created by 叶修 on 2024/12/11.
//

import UIKit

class UIViewController5: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        forEach()
        sorted()
        map()
        filer()
        reduce()
        prefixFunc()
        drop()
        other()
    }
    
    /**
     高阶函数（Higher-order function）是一种可以接受一个或多个函数作为参数，并且/或者返回一个函数的函数
     */
    
    /// 遍历函数
    func forEach() {
        let numberWords = ["one", "two", "three"]
        numberWords.forEach { word in
            print(word)
        }
    }
    
    /// 排序函数
    func sorted() {
        var numbers = [7, 6, 10, 9, 8, 1, 2, 3, 4, 5]
        // 对原可变集合进行给定条件排序
        numbers.sort { a, b in
            return a > b
        }
        print("sort >: \(numbers)") // [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        // 对集合进行升序排序
        numbers.sort()
        print("sort: \(numbers)") // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        // 将集合进行给定条件排序，返回一个新的集合，不修改原集合。
        
        // 完整写法
        var sortedArr = numbers.sorted { (a: Int, b: Int) -> Bool in
            return a > b
        }
        print("sorted1 >: \(sortedArr)") // [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        
        // 省略写法0
        sortedArr = sortedArr.sorted { (a, b) -> Bool in
            return a < b
        }
        print("sorted2 <: \(sortedArr)") // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        // 省略写法1
        sortedArr = sortedArr.sorted { a, b in
            return a < b
        }
        print("sorted3 <: \(sortedArr)") // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        // 省略写法2
        sortedArr = sortedArr.sorted { return $0 > $1 }
        print("sorted4 >: \(sortedArr)") // [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        
        // 省略写法3
        sortedArr = sortedArr.sorted { $0 < $1 }
        print("sorted5 <: \(sortedArr)") // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        // 省略写法4
        sortedArr = sortedArr.sorted(by: >)
        print("sorted6 >: \(sortedArr)") // [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        
        sortedArr = sortedArr.sorted()
        print("sorted7: \(sortedArr)") // // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }
    
    // 映射函数
    func map() {
        var numbers = [7, 6, 10, 9, 8, 1, 2, 3, 4, 5]
        // 对数组中的每一个元素做一次映射操作，返回新数组，并且数组的类型不要求和原数组类型一致。
        var map = numbers.map { String($0) }
        print("map1: \(map)")
        
        // 返回值中允许nil的存在
        let opArr = ["1","2",nil,"3"]
        let opMapArr = opArr.map {
            $0
        }
        print("map2: \(opMapArr)")
        
        let flatMapNumbers1 = [[1, 2, 3], [3, 5]]
        // 解析首层元素，若没有nil，则会降维
        let flatMapArr1 = flatMapNumbers1.flatMap { $0 }
        print("flatMap1: \(flatMapArr1)")
        
        // 解析首层元素，若有nil则过滤，就不会降维
        let flatMapNumbers2 = [[1, Optional(2), 3], [3, nil, 5], nil]
        let flatMapArr2 = flatMapNumbers2.flatMap { $0 }
        print("flatMap2: \(flatMapArr2)")
        
        // 解析首层元素，若有nil则过滤，若有可选则解包
        let compactMaNumbers1 = [1, Optional(2), 3, nil]
        let compactMapArr1 = compactMaNumbers1.compactMap { $0 }
        print("compactMap1: \(compactMaNumbers1)")
        
        // 类型转换
        let compactMaNumbers2 = [1, 5, 4]
        let compactMapArr2 = compactMaNumbers2.compactMap { String($0) }
        print("compactMap2: \(compactMapArr2)")
        
        // 筛选数据
        let compactMaNumbers3 = [1, 2, 3, 4, 5, 6, 7, 8]
        let compactMapArr3 = compactMaNumbers3.compactMap { $0 % 4 == 0 ? $0 : nil }
        print("compactMap3: \(compactMapArr3)")
        
        /**
         flatMap和compactMap的关系
         但从表面上看，flatMap函数违背了单一功能原则，将过滤nil和降维两个功能于隐藏条件中进行判定。这也就是那个历史问题。
         因此，为了将过滤nil和降维两个功能于区分开，swift4.1开始，就只保留了降维的flatMap函数，并弃用了过滤nil的flatMap函数，又用开放的新函数compactMap来替代弃用的函数。
         所以，当需要过滤nil的时候，请使用compactMap函数；当需要进行降维时，请使用flatMap函数。
         */
    }
    
    // 过滤函数
    func filer() {
        let arr = [1, 2, 3, 4, 5]
        let result = arr.filter {
            $0 > 3
        }
        print("filter: \(result)")
    }
    
    // 遍历集合类型对象来进行求值，或构造一个新集合类型对象
    func reduce() {
        // 利用 reduce 求元素累加
        let sizes = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
        let totalSize1 = sizes.reduce(0, { $0 + $1 })
        print("reduce1: \(totalSize1)")
        
        let totalSize2 = sizes.reduce(1, *)
        print("reduce1: \(totalSize2)")
        
        // 求最值
        let nums = [1, 4, 54, -4, 5]
        let minNum = nums.reduce(Int.max) { result, num in
            return min(result, num)
        }
        print("reduce2: \(minNum)")
        
        // 倒叙数组
        let arr = [1, 4, 3, 2]
        let result = arr.reduce([Int]()) {
            [$1] + $0
        }
        print("reduce3: \(result)")
    }
    
    func prefixFunc() {
        var numbers = [7, 6, 10, 9, 8, 1, 2, 3, 4, 5]
        // prefix函数 正向取满足条件的元素，进行新集合创建。一旦出现不满足条件的元素，则跳出循环，不再执行。
        let prefixArr = numbers.prefix { $0 < 10 }
        print("prefix: \(prefixArr)")
        
        // upTo: 正向取元素创建数组, 包含小于指定index的元素
        let prefixUpToArr = numbers.prefix(upTo: 5)
        print("prefix upto: \(prefixUpToArr)")
        
        // through: 正向取元素创建数组, 包含小于等于指定index的元素
        let prefixThroughArr = numbers.prefix(through: 5)
        print("prefix through: \(prefixThroughArr)")
        
        // maxLength: 正向取元素创建数组, 包含指定的元素个数
        let prefixMaxLengthArr = numbers.prefix(2)
        print("prefix length: \(prefixMaxLengthArr)")
    }
    
    func drop() {
        var numbers = [7, 6, 9, 8, 1, 2, 3, 4, 5, 10]
        // 正向跳过满足条件的元素，进行新集合创建。一旦出现不满足条件的元素，则跳出循环，不再执行
        let dropArr = numbers.drop { $0 < 5 }
        print("drop: \(dropArr)")
        // 正向跳过元素创建数组, 跳过指定元素个数, 缺省值为1
        let dropFirstArr = numbers.dropFirst(3)
        print("dropFirst: \(dropFirstArr)")
        // 返向跳过元素创建数组, 跳过指定元素个数, 缺省值为1
        let dropLastArr = numbers.dropLast(6)
        print("dropLast: \(dropLastArr)")
    }
    
    func other() {
        var numbers = [7, 6, 10, 9, 8, 1, 2, 3, 4, 5]
        // 正向找出第一个满足条件的元素
        let first = numbers.first { $0 < 7 }
        print("first: \(String(describing: first))")
        
        // 反向找出第一个满足条件的元素
        let last = numbers.last { $0 > 5 }
        print("last: \(String(describing: first))")
        
        // 正向找出第一个满足条件的元素下标。
        let firstIndex = numbers.firstIndex { $0 < 7 }
        print("firstIndex: \(String(describing: firstIndex))")
        
        // 反向找出第一个满足条件的元素下标。
        let lastIndex = numbers.lastIndex { $0 > 5 }
        print("lastIndex: \(String(describing: lastIndex))")
        
        // 按条件排序后取最小元素。
        let min = numbers.min { $0 % 5 < $1 % 5 }
        print("min: \(String(describing: min))")
        
        // min()函数，自然升序取最小。
        let minDefault = numbers.min()
        print("minDefault: \(String(describing: minDefault))")

        let maxDictionary = ["aKey": 33, "bKey": 66, "cKey": 99]
        
        // 按条件排序后取最大元素。
        let max = maxDictionary.max { $0.value < $1.value }
        print("max: \(String(describing: max))")
        
        // max()函数，自然升序取最大。
        let maxDefault = numbers.max()
        print("maxDefault: \(String(describing: maxDefault))")
        
        // 按条件分割字符串，为子字符串创建集合
        let line = "123Hi!123I'm123a123coder.123"
        let splitArr = line.split { $0.isNumber }
        print("splitArr: \(splitArr)")

        // 也可指定字符
        let splitArr2 = line.split(separator: "1")
        print("split separator: \(splitArr2)")

        // 数组元素连接指定字符拼接成一个字符串
        let joined = splitArr.joined(separator: "_")
        print("joined: \(joined)")

        let titles = ["aaa", "bbb", "ccc"]
        let numbers1 = [111, 222, 333]
        // 将两个数组合并为一个元组组成的数组。
        let zipA = zip(titles, numbers1)
        print("zip: \(zipA)")
    }
}


