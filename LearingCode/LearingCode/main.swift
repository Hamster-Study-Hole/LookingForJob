//
//  main.swift
//  LearingCode
//
//  Created by 吕小康 on 2021/2/18.
//

import Foundation

print("Hello, World!")

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    
    // MARK: 1.两数之和
    // 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 的那 两个 整数，并返回它们的数组下标。
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map: [Int: Int] = [:]
        for i in 0..<nums.count {
            if let index = map[nums[i]] {
                return [index, i]
            }
            map[nums[i]] = i
        }
        return []
    }
    
    // MARK: 2.两数相加
    // 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。请你将两个数相加，
    // 并以相同形式返回一个表示和的链表。
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var flag = 0, l1 = l1, l2 = l2, tempNode = ListNode(-1), resultNode = tempNode
        while l1 != nil || l2 != nil {
            let sum = (l1?.val ?? 0) + (l2?.val ?? 0) + flag
            if sum >= 10 {
                flag = 1
            } else {
                flag = 0
            }
            let l = ListNode(sum % 10)
            tempNode.next = l
            tempNode = l
            l1 = l1?.next
            l2 = l2?.next
        }
        if flag == 1 {
            let l = ListNode(1)
            tempNode.next = l
        }
        return resultNode.next
    }
    
    // MARK: 3.无重复字符的最长子串
    // 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count == 0 {
            return 0
        }
        var maxCount = 0, map: [Character: Int] = [:], count = 0
        let list = Array(s)
        for i in 0..<list.count {
            if maxCount > list.count - i {
                return maxCount
            }
            count = 0
            map = [:]
            for j in i..<list.count {
                if map[list[j]] == nil {
                    map[list[j]] = 1
                    count += 1
                } else {
                    break
                }
            }
            maxCount = max(count, maxCount)
        }
        return maxCount
    }
    func lengthOfLongestSubstring1(_ s: String) -> Int {
        if s.count <= 1 {
            return s.count
        }
        var maxCount = 0, map: [Character: Int] = [:], start = 0, count = 0
        let list = Array(s)
        for i in 0..<list.count {
            if map[list[i]] == nil {
                map[list[i]] = 1
                count += 1
            } else {
                maxCount = max(maxCount, count)
                for j in start..<i {
                    if list[j] == list[i] {
                        start = j + 1
                        break
                    } else {
                        count -= 1
                        map[list[j]] = nil
                    }
                }
            }
            
        }
        maxCount = max(maxCount, count)
        return maxCount
    }
    
    // MARK: 4.寻找两个正序数组的中位数
    // 给定两个大小为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的中位数。
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let m = nums1.count, n = nums2.count
        if m == 0, n == 0 { return 0 }
        let index = (m + n) / 2
        var isDivisibleByTwo = false
        if (m + n) % 2 == 0 {
            isDivisibleByTwo = true
        }
        var list: [Int] = [], i = 0, j = 0
        while i < m, j < n {
            if nums1[i] < nums2[j] {
                list.append(nums1[i])
                i += 1
            } else {
                list.append(nums2[j])
                j += 1
            }
        }
        if list.count > index {
            if isDivisibleByTwo {
                return Double(list[index] + list[index - 1]) / 2.0
            } else {
                return Double(list[index])
            }
        }
        while i < m {
            list.append(nums1[i])
            i += 1
        }
        while j < n {
            list.append(nums2[j])
            j += 1
        }
        if isDivisibleByTwo {
            return Double(list[index] + list[index - 1]) / 2.0
        } else {
            return Double(list[index])
        }
    }
    
    // MARK: 5. 最长回文子串
    // 给你一个字符串 s，找到 s 中最长的回文子串。
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 0 else {
            return ""
        }
        var list = Array(s), count = list.count, maxCount = 0, start = 0, end = 0, i = 0
        while i < count {
            if i == 0 {
                start = i
                while i < count, list[i] == list[0] {
                    i += 1
                }
                end = i - 1
                maxCount = end - start + 1
            } else {
                if 2 * (i + 1) <= maxCount {
                    i += 1
                    continue
                } else if 2 * (count - i + 1) <= maxCount {
                    i += 1
                    break
                } else {
                    var left = i, right = i
                    while left > 0, list[left - 1] == list[i] {
                        left -= 1
                    }
                    while right < count - 1, list[right + 1] == list[i] {
                        right += 1
                    }
                    while left >= 0, right < count, list[left] == list[right] {
                        left -= 1
                        right += 1
                    }
                    left += 1
                    right -= 1
                    let count = right - left + 1
                    if count > maxCount {
                        maxCount = count
                        start = left
                        end = right
                    }
                    i += 1
                }
            }
        }
        return String(Array(list[start...end]))
    }

    // MARK: 6.Z 字形变换
    // 将一个给定字符串 s 根据给定的行数 numRows ，以从上往下、从左到右进行 Z 字形排列。
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows == 1 {
            return s
        }
        let list = Array(s)
        var tempList: [[Character]] = Array(repeating: [], count: numRows), i = 0, isIncrease = true
        for c in list {
            tempList[i].append(c)
            if isIncrease {
                i += 1
            } else {
                i -= 1
            }
            if i == 0 {
                isIncrease = true
            } else if i == numRows - 1 {
                isIncrease = false
            }
        }
        let result = tempList.flatMap( { return $0 })
        return String(result)
    }
    
    // MARK: 7.整数反转
    // 给你一个 32 位的有符号整数 x ，返回 x 中每位上的数字反转后的结果。如果反转后整数超过 32 位的有符号整数的范围 [−231,  231 − 1] ，就返回 0。假设环境不允许存储 64 位整数（有符号或无符号）。
    func reverse(_ x: Int) -> Int {
        var x = x, sum = 0
        while x != 0 {
            sum = sum * 10 + x % 10
            x = x / 10
        }
        if sum > Int32.max || sum < Int32.min {
            return 0
        }
        return sum
    }
    
    // MARK: 8.字符串转换整数 (atoi)
    // 请你来实现一个 myAtoi(string s) 函数，使其能将字符串转换成一个 32 位有符号整数（类似 C/C++ 中的 atoi 函数）。
    func myAtoi(_ s: String) -> Int {
        if s.count == 0 {
            return 0
        }
        let numList: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let list = Array(s)
        var i = 0, checkBlank = true, checkNegative = true, isNegative = false, resultList: [Character] = []
        while checkBlank, i < list.count {
            if list[i] == " " {
                i += 1
            } else {
                checkBlank = false
            }
        }
        if i == list.count { return 0 }
        if checkNegative {
            if list[i] == "-" {
                isNegative = true
                i += 1
            } else if list[i] == "+" {
                i += 1
            }
            checkNegative = false
        }
        while i < list.count {
            if numList.contains(list[i]) {
                resultList.append(list[i])
                i += 1
            } else {
                break
            }
        }
        if resultList.count == 0 {
            return 0
        }
        if let resultSum = Int32(String(resultList)) {
            if isNegative {
                return Int(0 - resultSum)
            }
            return Int(resultSum)
        } else {
            return Int(isNegative ? Int32.min : Int32.max)
        }
    }
    
    // MARK: 9.回文数
    // 给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。回文数是指正序（从左向右）和
    // 倒序（从右向左）读都是一样的整数。例如，121 是回文，而 123 不是。
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        if x == 0 {
            return true
        }
        if x % 10 == 0 {
            return false
        }
        var x = x, list: [Int] = []
        while x > 0 {
            list.append(x % 10)
            x /= 10
        }
        var left = 0, right = list.count - 1
        while left < right {
            if list[left] == list[right] {
                left += 1
                right -= 1
            } else {
                return false
            }
        }
        return true
    }
    
    // MARK: 10.正则表达式匹配
    // 给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
    // '.' 匹配任意单个字符 '*' 匹配零个或多个前面的那一个元素
    // ps: 写的什么破玩意,困难难度对我来说还是太难了
    func isMatch(_ s: String, _ p: String) -> Bool {
        return isMatch(Array(s), Array(p))
    }
    func isMatch(_ list1: [Character], _ list2: [Character] ) -> Bool {
        if list2.count == 0 {
            if list1.count > 0  {
                return false
            }
            return true
        }
        if list1.count == 0 {
            var j = list2.count - 1
            while j >= 0 {
                if list2[j] == "*" {
                    j -= 2
                } else {
                    return false
                }
            }
            if j < 0 {
                return true
            }
        }
        var i = list1.count - 1, j = list2.count - 1
        while i >= 0, j >= 0, list1[i] == list2[j] || list2[j] == "." {
            i -= 1
            j -= 1
        }
        if j >= 0, list2[j] != "*"  {
            return false
        }
        if j >= 0, list2[j] == "*" {
            if i >= 0, list1[i] == list2[j-1] || list2[j-1] == "." {
                return isMatch(i < 0 ? [] : Array(list1[0...i]), Array(list2[0..<(j > 0 ? j - 1: 0)])) || isMatch(Array(list1[0..<(i >= 0 ? i : 0)]), j < 0 ? [] : Array(list2[0...j]))
            } else {
                return isMatch(i < 0 ? [] : Array(list1[0...i]), Array(list2[0..<(j > 0 ? j - 1: 0)]))
            }
        }
        if i >= 0 {
            return false
        }
        if j >= 0 {
            return false
        }
        return true
    }
    
    // MARK: 11.盛最多水的容器
    // 给你 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0) 。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。
    func maxArea(_ height: [Int]) -> Int {
        var maxResult = 0, left = 0, right = height.count - 1
        while left < right {
            let minHeight = min(height[left], height[right])
            let result = minHeight * (right - left)
            maxResult = max(result, maxResult)
            if minHeight == height[left] {
                left += 1
            } else {
                right -= 1
            }
        }
        return maxResult
    }
    
    // MARK: 12.整数转罗马数字
    // 罗马数字包含以下七种字符： I， V， X， L，C，D 和 M,分别对应阿拉伯数字的1, 5, 10, 50, 100, 500, 1000
    // 例如， 罗马数字 2 写做 II ，即为两个并列的 1。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
    // 通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
    // I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
    // X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。
    // C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
    // 给定一个整数，将其转为罗马数字。输入确保在 1 到 3999 的范围内。
    func intToRoman(_ num: Int) -> String {
        let romanList = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabList = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        var num = num, i = 0, result = ""
        while i < arabList.count {
            if num >= arabList[i] {
                num -= arabList[i]
                result += romanList[i]
            } else {
                i += 1
            }
        }
        return result
    }
    
    // MARK: 13.罗马数字转整数
    // 定一个罗马数字，将其转换成整数。输入确保在 1 到 3999 的范围内。
    func romanToInt(_ s: String) -> Int {
        //懒得写了,直接copy了上面的,生成map多耗费了时间
        let romanList = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabList = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        var map: [String: Int] = [:]
        for i in 0..<romanList.count {
            map[romanList[i]] = arabList[i]
        }
        
        let list = Array(s)
        var i = 0, num = 0
        while i < list.count {
            if i < list.count - 1, let arab = map[String([list[i], list[i+1]])] {
                num += arab
                i += 2
            } else {
                if let arab = map[String(list[i])] {
                    num += arab
                }
                i += 1
            }
        }
//        while i < list.count {
//            if i < list.count - 1, let arab1 = map[String(list[i])], let arab2 = map[String(list[i+1])] {
//                if arab1 < arab2 {
//                    num -= arab1
//                } else {
//                    num += arab1
//                }
//            } else {
//                if let arab = map[String(list[i])] {
//                    num += arab
//                }
//            }
//            i += 1
//        }
        return num
    }
    
    // MARK: 14.最长公共前缀
    // 编写一个函数来查找字符串数组中的最长公共前缀。如果不存在公共前缀，返回空字符串 ""。
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 {
            return ""
        }
        var list: [[Character]] = [], minCount = Int.max, minList: [Character] = [], result: [Character] = []
        for str in strs {
            minCount = min(minCount, str.count)
            if minCount == str.count {
                minList = Array(str)
                list.append(minList)
            } else {
                list.append(Array(str))
            }
        }
        if minCount == 0 {
            return ""
        }
        for i in 0..<minCount {
            let c = minList[i]
            for j in list {
                if j[i] != c {
                    return String(result)
                }
            }
            result.append(c)
        }
        return String(result)
    }
    
    
}
let SL = Solution()




