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
    
    // MARK: 15.三数之和
    // 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？
    // 请你找出所有和为 0 且不重复的三元组。
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        let nums = nums.sorted()
        if nums[0] > 0 {
            return []
        }
        var i = 0, result: [[Int]] = []
        while i < nums.count - 2 {
            var left = i + 1, right = nums.count - 1
            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                if sum > 0 {
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    result.append([nums[i], nums[left], nums[right]])
                    left += 1
                    right -= 1
                    while left < right, nums[left] == nums[left-1] {
                        left += 1
                    }
                    while left < right, nums[right] == nums[right+1] {
                        right -= 1
                    }
                }
            }
            i += 1
            while i < nums.count - 2, nums[i] == nums[i-1] {
                i += 1
            }
        }
        return result
    }
    
    // MARK: 16.最接近的三数之和
    // 给定一个包括 n 个整数的数组 nums 和 一个目标值 target。找出 nums 中的三个整数，使得它们的和与 target 最接近。
    // 返回这三个数的和。假定每组输入只存在唯一答案。
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        // 借着上面的算法修改了一下
        var result = 0, minDifference = Int.max, i = 0
        let nums = nums.sorted()
        while i < nums.count - 2 {
            var left = i + 1, right = nums.count - 1
            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                let difference = sum - target
                if difference != 0 {
                    let absDifference = abs(difference)
                    if absDifference < minDifference {
                        minDifference = absDifference
                        result = sum
                    }
                    if difference == absDifference {
                        right -= 1
                    } else {
                        left += 1
                    }
                } else {
                    return target
                }
            }
            i += 1
            while i < nums.count - 2, nums[i] == nums[i-1] {
                i += 1
            }
        }
        return result
    }
    
    // MARK: 17.电话号码的字母组合
    // 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。
    func letterCombinations(_ digits: String) -> [String] {
        //写法有点丑陋,感觉有优化空间
        if digits.count == 0 {
            return []
        }
        let numMap: [Character: [Character]] = ["2": ["a", "b", "c"],
                                                "3": ["d", "e", "f"],
                                                "4": ["g", "h", "i"],
                                                "5": ["j", "k", "l"],
                                                "6": ["m", "n", "o"],
                                                "7": ["p", "q", "r", "s"],
                                                "8": ["t", "u", "v"],
                                                "9": ["w", "x", "y", "z"]]
        let list = Array(digits)
        var result: [[Character]] = [[]]
        for i in 0..<list.count {
            let count = numMap[list[i]]?.count ?? 0
            let temp = result
            if count > 0 {
                for _ in 1..<count {
                    result += temp
                }
            }
            for k in 0..<count {
                for l in 0..<temp.count {
                    result[l+k*temp.count].append(numMap[list[i]]![k])
                }
            }
        }
        return result.map({ return String($0) })
    }
    
    // MARK: 18.四数之和
    // 给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a，b，c 和 d ，
    // 使得 a + b + c + d 的值与 target 相等？找出所有满足条件且不重复的四元组。
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        // 三数之和之上又套了一层,应该有简单方法吧,不然算一百数之和是不是会爆炸
        if nums.count < 4 {
            return []
        }
        let nums = nums.sorted()
        var result: [[Int]] = [], i = 0
        while i < nums.count - 3 {
            var j = i + 1
            while j < nums.count - 2 {
                var left = j + 1, right = nums.count - 1
                while left < right {
                    let sum = nums[i] + nums[j] + nums[left] + nums[right]
                    if sum == target {
                        result.append([nums[i], nums[j], nums[left], nums[right]])
                        left += 1
                        right -= 1
                        while left < right, nums[left] == nums[left-1] {
                            left += 1
                        }
                        while left < right, nums[right] == nums[right+1] {
                            right -= 1
                        }
                    } else if sum > target {
                        right -= 1
                    } else {
                        left += 1
                    }
                }
                j += 1
                while j < nums.count - 2, nums[j] == nums[j-1] {
                    j += 1
                }
            }
            i += 1
            while i < nums.count - 3, nums[i] == nums[i-1] {
                i += 1
            }
        }
        return result
    }
    
    // MARK: 19.删除链表的倒数第 N 个结点
    // 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        //用数组取巧了一下,面试的时候应该不让
        let temp = ListNode(0, head)
        var head = head
        var list: [ListNode] = []
        list.append(temp)
        while head != nil {
            list.append(head!)
            head = head?.next
        }
        let nextNode = list[list.count-n].next
        list[list.count-n-1].next = nextNode
        return temp.next
    }
    func removeNthFromEnd1(_ head: ListNode?, _ n: Int) -> ListNode? {
        //这可能是面试要的双指针吧,但是效率并不高啊
        let temp: ListNode? = ListNode(0, head)
        var p1 = head, p2 = temp
        for _ in 0..<n {
            p1 = p1?.next
        }
        while p1 != nil {
            p1 = p1?.next
            p2 = p2?.next
        }
        p2?.next = p2?.next?.next
        return temp?.next
    }
    
    // MARK: 20. 有效的括号
    // 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
    // 有效字符串需满足：左括号必须用相同类型的右括号闭合。左括号必须以正确的顺序闭合。
    func isValid(_ s: String) -> Bool {
        if s.count == 0 {
            return true
        }
        if s.count % 2 != 0 {
            return false
        }
        let map: [Character: Character] = [")": "(", "}": "{", "]": "["]
        var cList: [Character] = []
        for c in s {
            if map.values.contains(c) {
                cList.append(c)
            } else if map.keys.contains(c) {
                if cList.last == map[c] {
                    cList.removeLast()
                } else {
                    return false
                }
            }
        }
        if cList.count > 0 {
            return false
        }
        return true
    }
    
    // MARK: 21. 合并两个有序链表
    // 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var temp: ListNode? = ListNode(-1)
        let result = temp
        var l1 = l1, l2 = l2
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                temp?.next = l1
                temp = l1
                l1 = l1?.next
            } else {
                temp?.next = l2
                temp = l2
                l2 = l2?.next
            }
        }
        if l1 != nil {
            temp?.next = l1
        }
        if l2 != nil {
            temp?.next = l2
        }
        
        return result?.next
    }
    
    // MARK: 22. 括号生成
    // 数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
    func generateParenthesis(_ n: Int) -> [String] {
        if n == 0 {
            return []
        }
        var list: [String] = []
        func generateStr(_ str: String, _ m: Int) {
            if m == 0 {
                //这里验证取巧了,用的上面的第20题
                if isValid(str) {
                    list.append(str)
                }
                return
            }
            var i = 0, j = 0
            for c in str {
                if c == "(" {
                    i += 1
                }
                if c == ")" {
                    j += 1
                }
            }
            if i > n || j > n {
                return
            }
            generateStr(str + "(", m - 1)
            generateStr(str + ")", m - 1)
        }
        generateStr("", n * 2)
        return list
    }
    
    // MARK: 23. 合并K个升序链表
    // 给你一个链表数组，每个链表都已经按升序排列。请你将所有链表合并到一个升序链表中，返回合并后的链表。
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if lists.count == 0 {
            return nil
        }
        if lists.count == 1 {
            return lists[0]
        }
        var result = lists
        while result.count != 1 {
            //这里需要做下二分,不然会超时,下面用了上面的21题
            var left = 0, right = result.count-1
            var temp: [ListNode?] = []
            while left < right {
                temp.append(mergeTwoLists(result[left], result[right]))
                left += 1
                right -= 1
                if left == right {
                    temp.append(result[left])
                }
            }
            result = temp
        }
        return result[0]
    }
    
    // MARK: 24.两两交换链表中的节点
    // 给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。
    // 你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let result: ListNode? = ListNode(-1)
        var p1 = head, p2 = head?.next, pre = result
        if p2 == nil {
            return p1
        }
        while p1 != nil, p2 != nil {
            pre?.next = p2
            let next = p2?.next
            p2?.next = p1
            p1?.next = next
            pre = p1
            p1 = next
            p2 = next?.next
        }
        return result?.next
    }
    
    // MARK: 25.K 个一组翻转链表
    // 给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。
    // k 是一个正整数，它的值小于或等于链表的长度。
    // 如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        if k <= 1 {
            return head
        }
        func reverseNode(_ head: ListNode?) -> ListNode? {
            var head = head, result: ListNode? = nil
            while head != nil {
                let next = head?.next
                head?.next = result
                result = head
                head = next
            }
            return result
        }
        var head = head, result: ListNode? = ListNode(-1, head), pre = result, start = head, i = 0
        while head != nil {
            i += 1
            if i == k {
                let next = head?.next
                head?.next = nil
                pre?.next = reverseNode(start)
                start?.next = next
                pre = start
                head = next
                start = head
                i = 0
            } else {
                head = head?.next
            }
        }
        
        return result?.next
    }
    
    // MARK: 26.删除排序数组中的重复项
    // 给定一个排序数组，你需要在 原地 删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。
    //不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        let count = nums.count
        if count <= 1 {
            return count
        }
        var i = 0
        for j in 0..<count {
            if nums[j] != nums[i] {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i + 1
    }
    
    // MARK: 27. 移除元素
    // 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
    // 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
    //元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0, j = 0
        while i < nums.count {
            if nums[i] != val {
                nums[j] = nums[i]
                j += 1
            }
            i += 1
        }
        return j
    }
    
    // MARK: 28. 实现 strStr()
    // 实现 strStr() 函数。
    // 给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.count == 0 {
            return 0
        }
        let count1 = haystack.count, count2 = needle.count
        if count2 > count1 {
            return -1
        }
        let list1 = Array(haystack), list2 = Array(needle)
        var temp: [Character] = []
        for i in 0...count1 - count2 {
            if i == 0 {
                temp = Array(list1[0..<count2])
            } else {
                temp.removeFirst()
                temp.append(list1[i + count2-1])
            }
            if temp == list2 {
                return i
            }
        }
        return -1
        
    }
    
    // MARK: 29. 两数相除
    // 给定两个整数，被除数 dividend 和除数 divisor。将两数相除，要求不使用乘法、除法和 mod 运算符。
    // 返回被除数 dividend 除以除数 divisor 得到的商。
    // 整数除法的结果应当截去（truncate）其小数部分，例如：truncate(8.345) = 8 以及 truncate(-2.7335) = -2
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        var isNegative = false, absDividend = abs(dividend), absDivisor = abs(divisor)
        if !((dividend > 0 && divisor > 0) || (dividend < 0 && divisor < 0)) {
            isNegative = true
        }
        var sum = 0, temp = 1
        while absDividend >= absDivisor {
            absDividend -= absDivisor
            sum += temp
            temp += temp
            if absDividend < absDivisor + absDivisor {
                absDivisor = abs(divisor)
                temp = 1
            } else {
                absDivisor += absDivisor
            }
        }
        if isNegative {
            if 0 - sum < Int32.min {
                return Int(Int32.min)
            }
            return 0 - sum
            
        } else {
            if sum > Int32.max {
                return Int(Int32.max)
            }
            return sum
        }
    }
    
    // MARK: 30.串联所有单词的子串
    // 给定一个字符串 s 和一些长度相同的单词 words。找出 s 中恰好可以由 words 中所有单词串联形成的子串的起始位置。
    // 注意子串要与 words 中的单词完全匹配，中间不能有其他字符，但不需要考虑 words 中单词串联的顺序。
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        var sumCount = 0, wordCount = words[0].count, result: [Int] = [], map: [String: Int] = [:]
        for word in words {
            if map[word] != nil {
                map[word]! += 1
            } else {
                map[word] = 1
            }
            sumCount += word.count
        }
        if sumCount > s.count {
            return []
        }
        let list = Array(s)
        var currentList: [Character] = [], i = 0
        var tempMap: [String: Int] = [:]
        while i <= list.count - sumCount {
            if i == 0 {
                currentList = Array(list[i..<i+sumCount])
            } else {
                currentList.removeFirst()
                currentList.append(list[i + sumCount - 1])
            }
            let tempStr = String(list[i..<i+wordCount])
            if map[tempStr] == nil {
                i += 1
                continue
            }
           
            tempMap.removeAll()
            for j in 0..<words.count {
                let str = String(currentList[j * wordCount..<(j + 1) * wordCount])
                if tempMap[str] == map[str] {
                    break
                }
                if tempMap[str] != nil {
                    tempMap[str]! += 1
                } else {
                    tempMap[str] = 1
                }
            }
            if tempMap == map {
                result.append(i)
            }
            i += 1
        }
        
        return result
    }
    
    // MARK: 31.实现获取 下一个排列 的函数，算法需要将给定数字序列重新排列成字典序中下一个更大的排列。
    // 如果不存在下一个更大的排列，则将数字重新排列成最小的排列（即升序排列）。
    // 必须 原地 修改，只允许使用额外常数空间。
    func nextPermutation(_ nums: inout [Int]) {
        var i = nums.count - 2
        while i >= 0 && nums[i] >= nums[i+1] {
            i -= 1
        }
        var left = 0, right = nums.count - 1
        //如果不是纯倒序排列的,i>=0,倒序找到第一个小数跟后面比他大的第一个数进行交换,这样高位的数就变大了,后面的段保留着降序排列,然后反转一下
        if i >= 0 {
            var j = nums.count - 1
            while j >= 0 {
                if nums[j] > nums[i] {
                    nums.swapAt(j, i)
                    left = i + 1
                    break
                }
                j -= 1
            }
        }
        while left < right {
            nums.swapAt(left, right)
            left += 1
            right -= 1
        }
    }
    
    // MARK: 32.最长有效括号
    // 给你一个只包含 '(' 和 ')' 的字符串，找出最长有效（格式正确且连续）括号子串的长度。
    func longestValidParentheses(_ s: String) -> Int {
        if s.count < 2 {
            return 0
        }
        let list = Array(s)
        var maxCount = 0, count = 0, effectiveList = Array(repeating: 0, count: list.count), i = 0, leftLocationList: [Int] = []
        //记录不成对的")"位置
        while i < list.count {
            if list[i] == "(" {
                leftLocationList.append(i)
            } else {
                if leftLocationList.count == 0 {
                    effectiveList[i] = 1
                } else {
                    leftLocationList.removeLast()
                }
            }
            i += 1
        }
        //记录不成对的"("位置
        for i in leftLocationList {
            effectiveList[i] = 1
        }
        i = 0
        //遍历最长成对段
        while i < effectiveList.count {
            if effectiveList[i] == 1 {
                maxCount = max(maxCount, count)
                count = 0
            } else {
                count += 1
            }
            i += 1
        }
        maxCount = max(maxCount, count)
        
        return maxCount
        
    }
    
    // MARK: 33.搜索旋转排序数组
    // 整数数组 nums 按升序排列，数组中的值 互不相同 。
    // 在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 旋转，使数组变为
    // [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。
    // 例如， [0,1,2,4,5,6,7] 在下标 3 处经旋转后可能变为 [4,5,6,7,0,1,2] 。
    // 给你 旋转后 的数组 nums 和一个整数 target ，如果 nums 中存在这个目标值 target ，则返回它的索引，否则返回 -1 。
    func search(_ nums: [Int], _ target: Int) -> Int {
        if nums[0] > target {
            for i in (0..<nums.count).reversed() {
                if nums[i] < target {
                    return -1
                } else if nums[i] == target {
                    return i
                }
            }
        } else {
            for i in 0..<nums.count {
                if nums[i] > target {
                    return -1
                } else if nums[i] == target {
                    return i
                }
            }
        }
        return -1
    }
    
    // MARK: 34. 在排序数组中查找元素的第一个和最后一个位置
    // 给定一个按照升序排列的整数数组 nums，和一个目标值 target。找出给定目标值在数组中的开始位置和结束位置。
    // 如果数组中不存在目标值 target，返回 [-1, -1]。
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return [-1, -1]
        }
        if nums[0] > target || nums[nums.count-1] < target {
            return [-1, -1]
        }
        var left = 0, right = nums.count - 1
        while left <= right {
            if nums[left] == target && nums[right] == target {
                return [left, right]
            }
            if nums[left] < target {
                left += 1
            }
            if nums[right] > target {
                right -= 1
            }
        }
        return [-1, -1]
    }
    
    func searchRange1(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return [-1, -1]
        }
        if nums[0] > target || nums[nums.count-1] < target {
            return [-1, -1]
        }
        var left = 0, right = nums.count - 1
        while left < right {
            let middle = (left + right) / 2
            if nums[middle] > target {
                right = middle - 1
            } else if nums[middle] < target {
                left = middle + 1
            } else {
                left = middle
                right = middle
                while left > 0, nums[left] == nums[left - 1] {
                    left -= 1
                }
                while right < nums.count - 1, nums[right] == nums[right + 1] {
                    right += 1
                }
                return [left, right]
            }
        }
        return [-1, -1]
    }
    
    // MARK: 35.搜索插入位置
    // 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        for i in 0..<nums.count {
            if nums[i] >= target {
                return i
            }
        }
        return nums.count
    }
    
    // MARK: 36.有效的数独
    // 判断一个 9x9 的数独是否有效。只需要根据以下规则，验证已经填入的数字是否有效即可。
    // 数字 1-9 在每一行只能出现一次。
    // 数字 1-9 在每一列只能出现一次。
    // 数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        for i in 0..<9 {
            var map: [Character: Int] = [:]
            for j in 0..<9 {
                if board[i][j] != "." {
                    if map[board[i][j]] == nil {
                        map[board[i][j]] = 1
                    } else {
                        return false
                    }
                }
            }
            map = [:]
            for k in 0..<9 {
                if board[k][i] != "." {
                    if map[board[k][i]] == nil {
                        map[board[k][i]] = 1
                    } else {
                        return false
                    }
                }
            }
            map = [:]
            for l in i/3*3..<i/3*3+3 {
                for m in i%3*3..<i%3*3+3 {
                    if board[l][m] != "." {
                        if map[board[l][m]] == nil {
                            map[board[l][m]] = 1
                        } else {
                            return false
                        }
                    }
                }
            }
            
        }
        return true
    }
    
    // MARK: 37.解数独
    // 编写一个程序，通过填充空格来解决数独问题。
    func solveSudoku(_ board: inout [[Character]]) {
        var rowList: [Set<Character>] = []
        var colList: [Set<Character>] = Array(repeating: [], count: 9)
        for i in 0..<board.count {
            var set: Set<Character> = []
            for j in 0..<board[0].count {
                if board[i][j] != "." {
                    set.insert(board[i][j])
                    colList[j].insert(board[i][j])
                }
            }
            rowList.append(set)
        }
        dfs(&board, rowList: &rowList, colList: &colList, start: 0)
    }
    func dfs(_ board: inout [[Character]], rowList: inout [Set<Character>], colList: inout [Set<Character>], start: Int) -> Bool {
        for i in start..<board.count {
            for j in 0..<board[0].count {
                if board[i][j] != "." {
                    continue
                }
                for k in 1...9 {
                    let c = Character("\(k)")
                    if rowList[i].contains(c) || colList[j].contains(c) {
                        continue
                    }
                    board[i][j] = c
                    rowList[i].insert(c)
                    colList[j].insert(c)
                    //这个数独的验证走的上面的方法,但是有点复杂了,会超时,把验证方法里面的前两个横竖验证注释之后可以通过,横竖校验已经走了
                    //rowList, colList的校验了
                    if isValidSudoku(board), dfs(&board, rowList: &rowList, colList: &colList, start: i) {
                        return true
                    } else {
                        board[i][j] = "."
                        rowList[i].remove(c)
                        colList[j].remove(c)
                    }
                }
                return false
            }
        }
        return true
    }
    
    // MARK: 38. 外观数列
    // 给定一个正整数 n ，输出外观数列的第 n 项。「外观数列」是一个整数序列，从数字 1 开始，序列中的每一项都是对前一项的描述。
    // 你可以将其视作是由递归公式定义的数字字符串序列：
    func countAndSay(_ n: Int) -> String {
        if n == 1 {
            return "1"
        }
        var result: String = ""
        let s = countAndSay(n - 1)
        let list = Array(s)
        var count = 0, c: Character = "0"
        for l in list {
            if c != l {
                if count > 0 {
                    result.append("\(count)\(c)")
                }
                count = 1
                c = l
            } else {
                count += 1
            }
        }
        if count > 0 {
            result.append("\(count)\(c)")
        }
        return result
    }
    
    // MARK: 39. 组合总和
    // 给定一个无重复元素的数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。
    // candidates 中的数字可以无限制重复被选取。
    // 所有数字（包括 target）都是正整数。解集不能包含重复的组合。
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        //这里是拿set做了个去重操作,不优雅
        var result: Set<[Int]> = []
        combination(&result, candidates: candidates, target: target, currentList: [], k: 0)
        return Array(result)
    }
    func combination(_ result: inout Set<[Int]>, candidates: [Int], target: Int, currentList: [Int], k: Int) {
        var sum = 0
        for i in currentList {
            sum += i
        }
        var list = currentList
        if k > 0 {
            sum += k
            list.append(k)
        }
        if sum == target {
            list.sort()
            result.insert(list)
        } else if sum > target {
            return
        } else {
            for c in candidates {
                combination(&result, candidates: candidates, target: target, currentList: list, k: c)
            }
        }
    }
    
    // MARK: 40. 组合总和II
    // 给定一个无重复元素的数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。
    // candidates 中的每个数字在每个组合中只能使用一次。
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result: Set<[Int]> = []
        var sum = 0
        for i in candidates {
            sum += i
        }
        if sum < target {
            return []
        }
        let candidates = candidates.sorted().filter( { return $0 <= target })
        
        combination2(&result, candidates: candidates, target: target, currentList: [], k: 0, sum: 0)
        return Array(result)
    }
    func combination2(_ result: inout Set<[Int]>, candidates: [Int], target: Int, currentList: [Int], k: Int, sum: Int) {
        var list = currentList
        var sum = sum
        if k > 0 {
            sum += k
            list.append(k)
        }
        
        if sum == target {
            result.insert(list)
        } else if sum > target {
            return
        } else {
            for i in 0..<candidates.count {
                if candidates[i] + sum > target {
                    return
                }
                let tempList = Array(candidates[i+1..<candidates.count])
                combination2(&result, candidates: tempList, target: target, currentList: list, k: candidates[i], sum: sum)
            }
        }
    }
    
    // MARK: 41. 缺失的第一个正数
    // 给你一个未排序的整数数组 nums ，请你找出其中没有出现的最小的正整数。
    // 进阶：你可以实现时间复杂度为 O(n) 并且只使用常数级别额外空间的解决方案吗(进阶的方案是数组原地做map标记,让各个整数回到该在的
    // 索引位,可惜我不配)
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var map: [Int: Int] = [:]
        for num in nums {
            map[num] = 1
        }
        var i = 1
        while i > 0 {
            if map[i] == nil {
                return i
            } else {
                i += 1
            }
        }
        return Int.max
    }
    
    // MARK: 42. 接雨水
    // 给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。
    // 找到最高的柱子的index,然后左右开始找不高于左右柱子为坑位进行雨水的累加,然后高于左右柱子更新左右柱子高度,然后找到最高index位置停止
    func trap(_ height: [Int]) -> Int {
        var sum = 0
        if height.count <= 1 {
            return sum
        }
        var left = 0, right = height.count - 1, maxHeightIndex = 0, maxHeight = 0, leftMaxHeight = 0, rightMaxHeight = 0
        for i in 0..<height.count {
            if height[i] > maxHeight {
                maxHeight = height[i]
                maxHeightIndex = i
            }
        }
        while left < right {
            if height[left] > leftMaxHeight {
                leftMaxHeight = height[left]
            } else {
                sum += leftMaxHeight - height[left]
            }
            if left < maxHeightIndex {
                left += 1
            }
            if height[right] > rightMaxHeight {
                rightMaxHeight = height[right]
            } else {
                sum += rightMaxHeight - height[right]
            }
            if right > maxHeightIndex {
                right -= 1
            }
        }
        return sum
    }
    
    // MARK: 43. 字符串相乘
    // 给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。
    // 写起来就一直转啊转的,本来没什么东西,转的蛋疼
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num1 == "0" {
            return "0"
        }
        func addNumStr(_ str1: String, _ str2: String) -> String {
            let list1 = Array(Array(str1).reversed()), list2 = Array(Array(str2).reversed())
            var i = 0, temp = 0, result = ""
            while i < list1.count, i < list2.count {
                let sum = (Int(String(list1[i])) ?? 0) + (Int(String(list2[i])) ?? 0) + temp
                temp = sum / 10
                result = "\(sum % 10)" + result
                i += 1
            }
            while i < list1.count {
                let sum = (Int(String(list1[i])) ?? 0) + temp
                temp = sum / 10
                result = "\(sum % 10)" + result
                i += 1
            }
            while i < list2.count {
                let sum = (Int(String(list2[i])) ?? 0) + temp
                temp = sum / 10
                result = "\(sum % 10)" + result
                i += 1
            }
            if temp > 0 {
                result = "\(temp)" + result
            }
            return result
        }
        var result = "0"
        let list1 = Array(num1), list2 = Array(num2)
        if num1.count < num2.count {
            for i in (0..<list1.count).reversed() {
                if list1[i] == "0" {
                    continue
                } else {
                    var temp: Int = 0, str = ""
                    for j in (0..<list2.count).reversed() {
                        let num: Int = (Int(String(list1[i])) ?? 0) * (Int(String(list2[j])) ?? 0) + temp
                        temp = num / 10
                        str = "\(num % 10)" + str
                    }
                    if temp > 0 {
                        str = "\(temp)" + str
                    }
                    for _ in i+1..<list1.count {
                        str += "0"
                    }
                    result = addNumStr(result, str)
                }
            }
        } else {
            for i in (0..<list2.count).reversed() {
                if list2[i] == "0" {
                    continue
                } else {
                    var temp: Int = 0, str = ""
                    for j in (0..<list1.count).reversed() {
                        let num: Int = (Int(String(list2[i])) ?? 0) * (Int(String(list1[j])) ?? 0) + temp
                        temp = num / 10
                        str = "\(num % 10)" + str
                    }
                    if temp > 0 {
                        str = "\(temp)" + str
                    }
                    for _ in i+1..<list2.count {
                        str += "0"
                    }
                    result = addNumStr(result, str)
                }
            }
            
        }
        return result
    }
    
    // MARK: 44. 通配符匹配
    // 给定一个字符串 (s) 和一个字符模式 (p) ，实现一个支持 '?' 和 '*' 的通配符匹配。
    // '?' 可以匹配任何单个字符。'*' 可以匹配任意字符串（包括空字符串）。
    // 两个字符串完全匹配才算匹配成功。
    // s 可能为空，且只包含从 a-z 的小写字母。p 可能为空，且只包含从 a-z 的小写字母，以及字符 ? 和 *。(题解看的有点晕乎)
    func isMatch2(_ s: String, _ p: String) -> Bool {
        let list1 = Array(s), list2 = Array(p)
        if list1.count == 0 {
            if list2.filter( {return $0 != "*" }).count == 0 {
                return true
            }
            return false
        } else if list2.count == 0 {
            return false
        }
        var result: [[Bool]] = Array(repeating: Array(repeating: false, count: list2.count+1), count: list1.count+1)
        result[0][0] = true
        for j in 1...list2.count {
            result[0][j] = list2[j-1] == "*" && result[0][j-1]
        }
        for i in 1...list1.count {
            for j in 1...list2.count {
                if list1[i-1] == list2[j-1] || list2[j-1] == "?"  {
                    result[i][j] = result[i-1][j-1]
                } else if list2[j-1] == "*" && (result[i-1][j] || result[i][j-1]) {
                    result[i][j] = true
                }
            }
        }
        return result[list1.count][list2.count]
    }
    
    // MARK: 45. 跳跃游戏 II
    // 给定一个非负整数数组，你最初位于数组的第一个位置。数组中的每个元素代表你在该位置可以跳跃的最大长度。
    // 你的目标是使用最少的跳跃次数到达数组的最后一个位置。
    func jump(_ nums: [Int]) -> Int {
        var step = 0, end = 0, maxSum = 0
        for i in 0..<nums.count-1 {
            // 每次尽可能的往远跳
            maxSum = max(maxSum, i + nums[i])
            if i == end {
                end = maxSum
                step += 1
            }
        }
        return step
    }
    
    // MARK: 46.全排列
    // 给定一个 没有重复 数字的序列，返回其所有可能的全排列。
    func permute(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        func permute(nums: [Int], temp: [Int]) {
            if nums.count == 0 {
                result.append(temp)
            }
            for i in 0..<nums.count {
                var tempNums = nums, temp = temp
                temp.append(nums[i])
                tempNums.remove(at: i)
                permute(nums: tempNums, temp: temp)
            }
        }
        permute(nums: nums, temp: [])
        return result
    }
    
    // MARK: 47.全排列II
    // 给定一个可包含重复数字的序列 nums ，按任意顺序 返回所有不重复的全排列。
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        let nums = nums.sorted()
        var result: [[Int]] = []
        func permute(nums: [Int], temp: [Int]) {
            if nums.count == 0 {
                result.append(temp)
            }
            var a: Int?
            for i in 0..<nums.count {
                //提前排序,跳过重复数字,减少无效操作
                if a == nums[i] {
                    continue
                }
                a = nums[i]
                var tempNums = nums, temp = temp
                temp.append(nums[i])
                tempNums.remove(at: i)
                permute(nums: tempNums, temp: temp)
            }
        }
        permute(nums: nums, temp: [])
        return result
    }
    // MARK: 48.旋转图像
    // 给定一个 n × n 的二维矩阵 matrix 表示一个图像。请你将图像顺时针旋转 90 度。原地旋转
    func rotate(_ matrix: inout [[Int]]) {
        //顺时针旋转90可以拆成一次对角线交换,和一次上下翻转
        let n = matrix.count
        for i in 0..<n {
            for j in 0..<n-1-i {
                let temp = matrix[i][j]
                matrix[i][j] = matrix[n-1-j][n-1-i]
                matrix[n-1-j][n-1-i] = temp
            }
        }
        for j in 0..<n {
            for i in 0..<n/2 {
                let temp = matrix[i][j]
                matrix[i][j] = matrix[n-1-i][j]
                matrix[n-1-i][j] = temp
            }
        }
    }
    
    // MARK: 49. 字母异位词分组
    // 给定一个字符串数组，将字母异位词组合在一起。字母异位词指字母相同，但排列不同的字符串。
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var result: [[Character] : [String]] = [:]
        for str in strs {
            let set: [Character] = Array(str).sorted()
            if result[set] == nil {
                result[set] = [str]
            } else {
                result[set]?.append(str)
            }
        }
        return Array(result.values)
    }
    
    // MARK: 50. Pow(x, n)
    // 实现 pow(x, n) ，即计算 x 的 n 次幂函数（即，xn）。
    func myPow(_ x: Double, _ n: Int) -> Double {
        if x == 0 {
            return 0
        }
        if n == 0 {
            return 1
        }
        var absn = abs(n), sum: Double = 1, tempx = x
        //需要二分,不然太多了就超时了,都是套路,ciao
        while absn > 0 {
            if absn % 2 == 1 {
                sum *= tempx
            }
            tempx *= tempx
            absn /= 2
        }
        if n > 0 {
            return sum
        } else {
            return 1 / sum
        }
    }
    
    // MARK: 51. N 皇后
    // n 皇后问题 研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。
    // 给你一个整数 n ，返回所有不同的 n 皇后问题 的解决方案。
    // 每一种解法包含一个不同的 n 皇后问题 的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。
   
    func solveNQueens(_ n: Int) -> [[String]] {
        var list: [[String]] = Array(repeating: Array(repeating: ".", count: n), count: n)
        var result: [[String]] = []
        if n == 1 {
            return [["Q"]]
        }
        func solveNQueensDfs(list: inout [[String]], rowList: [Int], cloumnList: [Int], n: Int) {
            for i in 0..<list[n].count {
                if rowList.contains(n) {
                    continue
                }
                if cloumnList.contains(i) {
                    continue
                }
                var hasQ = false
                for j in 0...n {
                    if i - j >= 0, list[n-j][i-j] == "Q" {
                        hasQ = true
                    }
                }
                for j in 0...n {
                    if j + i < list[n].count, list[n-j][i+j] == "Q" {
                        hasQ = true
                    }
                }
                if hasQ {
                    continue
                }
                list[n][i] = "Q"
                if n == list.count - 1 {
                    var temp: [String] = []
                    for l in list {
                        var str = ""
                        for k in l {
                            str += k
                        }
                        temp.append(str)
                    }
                    result.append(temp)
                } else {
                    var rowList = rowList
                    rowList.append(n)
                    var cloumnList = cloumnList
                    cloumnList.append(i)
                    solveNQueensDfs(list: &list, rowList: rowList, cloumnList: cloumnList, n: n + 1)
                }
                list[n][i] = "."
            }
        }
        solveNQueensDfs(list: &list, rowList: [], cloumnList: [], n: 0)
        return result
    }
    
    // MARK: 53. 最大子序和
    // 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
    func maxSubArray(_ nums: [Int]) -> Int {
        var sum = 0, maxNum = Int.min
        for num in nums {
            //这里如果之前的sum是大于0的,不会使和小于当前值,进行累加,反之舍弃sum,从新计数,因为加上会变小
            if sum <= 0 {
                sum = num
            } else {
                sum += num
            }
            maxNum = max(maxNum, sum)
        }
        return maxNum
    }
    
    // MARK: 54. 螺旋矩阵
    // 给你一个 m 行 n 列的矩阵 matrix ，请按照 顺时针螺旋顺序 ，返回矩阵中的所有元素。
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.count <= 1 {
            return matrix.first ?? []
        }
        if matrix.first?.count ?? 0 <= 1 {
            return matrix.flatMap { (list) -> [Int] in
                return list
            }
        }
        var result: [Int] = []
        let m = matrix.count
        let n = matrix.first?.count ?? 0
        for i in 0..<n {
            result.append(matrix[0][i])
        }
        for j in 1..<m {
            result.append(matrix[j][n-1])
        }
        for k in (0..<n-1).reversed() {
            result.append(matrix[m-1][k])
        }
        for l in (1..<m-1).reversed() {
            result.append(matrix[l][0])
        }
        if matrix.count > 2 && matrix.first?.count ?? 0 > 2 {
            //数组降级
            var list = Array(matrix[1..<matrix.count-1])
            for i in 0..<list.count {
                list[i] = Array(list[i][1..<(matrix.first?.count ?? 0)-1])
            }
            return result + spiralOrder(list)
        }
        return result
    }
    
    // MARK: 55. 跳跃游戏
    // 给定一个非负整数数组 nums ，你最初位于数组的 第一个下标 。数组中的每个元素代表你在该位置可以跳跃的最大长度。
    // 判断你是否能够到达最后一个下标。
    func canJump(_ nums: [Int]) -> Bool {
        var num = nums.count - 1
        for i in (0..<nums.count).reversed() {
            if i + nums[i] >= num {
                num = i
            }
        }
        return num == 0
    }
    func canJump1(_ nums: [Int]) -> Bool {
        if nums.count == 1 {
            return true
        }
        var maxCount = nums[0]
        for i in 1..<nums.count {
            if i > maxCount {
                return false
            } else if maxCount >= nums.count - 1 {
                return true
            }
            if i + nums[i] > maxCount {
                maxCount = i + nums[i]
            }
        }
        return true
    }
    
    // MARK: 56.合并区间
    // 以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间。
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        if intervals.count == 0 {
            return intervals
        }
        let intervals = intervals.sorted(by: {return $0[0] < $1[0]})
        var result: [[Int]] = [], start = intervals[0][0], end = intervals[0][1]
        for i in 1..<intervals.count {
            if intervals[i][0] > end {
                result.append([start, end])
                start = intervals[i][0]
                end = intervals[i][1]
            } else if intervals[i][1] > end {
                end = intervals[i][1]
            }
        }
        result.append([start, end])
        return result
    }
    
    // MARK: 57.插入区间
    // 给你一个 无重叠的 ，按照区间起始端点排序的区间列表。
    // 在列表中插入一个新的区间，你需要确保列表中的区间仍然有序且不重叠（如果有必要的话，可以合并区间）。
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var intervals = intervals
        intervals.append(newInterval)
        return merge(intervals)
    }
    
    // MARK: 58.最后一个单词的长度
    // 给你一个字符串 s，由若干单词组成，单词之间用空格隔开。返回字符串中最后一个单词的长度。如果不存在最后一个单词，请返回 0 。
    // 单词 是指仅由字母组成、不包含任何空格字符的最大子字符串。
    func lengthOfLastWord(_ s: String) -> Int {
        let list = Array(s)
        var count = 0
        //这里比较坑的就是末尾有可能是空格,
        for i in (0..<list.count).reversed() {
            if list[i] == " " {
                if count > 0 {
                    break
                } else {
                    continue
                }
            }
            count += 1
        }
        return count
    }
    
    // MARK: 59. 螺旋矩阵 II
    // 给你一个正整数 n ，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的 n x n 正方形矩阵 matrix 。
    func generateMatrix(_ n: Int) -> [[Int]] {
        func generateMatrix(result: inout [[Int]], x1: Int, y1: Int, x2: Int, y2: Int, start: Int) {
            if x2 < x1 || y2 < y1 {
                return
            }
            if x1 == x2 {
                result[x1][y1] = start
                return
            }
            var val = start
            for i in y1..<y2 {
                result[x1][i] = val
                val += 1
            }
            for i in x1..<x2 {
                result[i][y2] = val
                val += 1
            }
            for i in (y1+1...y2).reversed() {
                result[x2][i] = val
                val += 1
            }
            for i in (x1+1...x2).reversed() {
                result[i][y1] = val
                val += 1
            }
            generateMatrix(result: &result, x1: x1 + 1, y1: y1 + 1, x2: x2 - 1, y2: y2 - 1, start: val)
        }
        var result = Array(repeating: Array(repeating: 0, count: n), count: n)
        generateMatrix(result: &result, x1: 0, y1: 0, x2: n - 1, y2: n - 1, start: 1)
        return result
    }
    
    #warning("看懂逻辑...")
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var list: [Int] = [], fact = 1, k = k - 1
        var result: String = ""
        for i in 1...n {
            list.append(i)
            fact *= i
        }
        for i in 0..<n {
            let partSize = fact / (n-i), idx = k / partSize
            result.append(String(list[idx]))
            list.remove(at: idx)
            k %= partSize
            fact /= (n-i)
        }
        return result
    }
    
    // MARK: 61.旋转链表
    // 定一个链表，旋转链表，将链表每个节点向右移动 k 个位置，其中 k 是非负数。
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        
        if head == nil || k == 0 {
            return head
        }
        var temp = head, count = 0
        while temp != nil {
            count += 1
            temp = temp?.next
        }
        let k = k % count
        if k == 0 {
            return head
        }
        var head = head, result: ListNode?, next: ListNode? = head
        for i in 0..<count {
            if i == count - k - 1 {
                let temp = head?.next
                head?.next = nil
                head = temp
                result = temp
            } else {
                head = head?.next
            }
            if head?.next == nil {
                head?.next = next
                break
            }
        }
        return result
    }
    
    // MARK: 73.矩阵置零
    // 给定一个 m x n 的矩阵，如果一个元素为 0 ，则将其所在行和列的所有元素都设为 0 。请使用 原地 算法。
    func setZeroes(_ matrix: inout [[Int]]) {
        var rowList: Set<Int> = [], columnList: Set<Int> = []
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if matrix[i][j] == 0 {
                    rowList.insert(i)
                    columnList.insert(j)
                }
            }
        }
        for row in rowList {
            matrix[row] = Array(repeating: 0, count: matrix[row].count)
        }
        for column in columnList {
            for i in 0..<matrix.count {
                matrix[i][column] = 0
            }
        }
    }
    
    // MARK: 74.搜索二维矩阵
    // 编写一个高效的算法来判断 m x n 矩阵中，是否存在一个目标值。该矩阵具有如下特性：
    // 每行中的整数从左到右按升序排列。每行的第一个整数大于前一行的最后一个整数。
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        for m in matrix where m.last ?? Int.min >= target {
            for j in m {
                if j == target { return true }
            }
            return false
        }
        return false
    }
    
    // MARK: 75.颜色分类
    // 给定一个包含红色、白色和蓝色，一共 n 个元素的数组，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。
    func sortColors(_ nums: inout [Int]) {
        var l = 0, r = nums.count - 1, i = 0
        while i <= r  {
            while i <= r, nums[i] == 2 {
                nums.swapAt(i, r)
                r -= 1
            }
            if nums[i] == 0 {
                nums.swapAt(i, l)
                l += 1
            }
            i += 1
        }
    }
    
    func findMin(_ nums: [Int]) -> Int {
        var l = 0, r = nums.count - 1
        while l < r {
            let mid = (l+r) / 2
            if nums[mid] < nums[r] {
                r = mid
            } else if nums[mid] > nums[r] {
                l = mid + 1
            } else {
                r -= 1
            }
        }
        return nums[l]
    }
    
    // MARK: 80.删除排序数组中的重复项 II
    // 给你一个有序数组 nums ，请你 原地 删除重复出现的元素，使每个元素 最多出现两次 ，返回删除后数组的新长度。
    // 不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。
    func removeDuplicates1(_ nums: inout [Int]) -> Int {
        var map:[Int: Int] = [:], i = 0
        while i < nums.count {
            if map[nums[i]] == 2 {
                nums.remove(at: i)
                continue
            } else if map[nums[i]] == nil {
                map[nums[i]] = 1
            } else {
                map[nums[i]]! += 1
            }
            i += 1
        }
        return i
    }
    
    func search1(_ nums: [Int], _ target: Int) -> Bool {
        var left = 0, right = nums.count - 1
        while left < right {
            let mid = (left + right) / 2
            if nums[mid] > target {
                right = mid
            } else if nums[mid] < target {
                left = mid + 1
            } else {
                return true
            }
        }
        if left == right {
            return nums[left] == target
        }
        return false
    }
    
    
    // MARK: 83.删除排序链表中的重复元素
    // 存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除所有重复的元素，使每个元素 只出现一次 。
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        
        var head = head
        let result = head
        while head != nil {
            while head?.val == head?.next?.val {
                head?.next = head?.next?.next
            }
            head = head?.next
        }
        return result
    }
    
    // 删除重复结点,忘记是第几题了
    func deleteDuplicates1(_ head: ListNode?) -> ListNode? {
        let result = ListNode(Int.max, head)
        var temp: ListNode? = result
        while temp?.next != nil, temp?.next?.next != nil {
            if temp?.next?.val == temp?.next?.next?.val {
                let val = temp?.next?.val
                while temp?.next != nil, temp?.next?.val == val {
                    temp?.next = temp?.next?.next
                }
            } else {
                temp = temp?.next
            }
        }
        return result.next
    }
    
    // MARK: 88.合并两个有序数组
    // 给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。
    // 初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。你可以假设 nums1 的空间大小等于 m + n，这样它就有足够的空间保存来自 nums2 的元素。
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        //同样的有序合并,只不过不让开辟空间,然后从末尾开始进行操作,最后判断省去第二个i>=0的判断
        var i = m - 1, j = n - 1
        while i >= 0, j >= 0 {
            if nums1[i] > nums2[j] {
                nums1[i+j+1] = nums1[i]
                i -= 1
            } else {
                nums1[i+j+1] = nums2[j]
                j -= 1
            }
        }
        while j >= 0 {
            nums1[j] = nums2[j]
        }
        
    }
    
    // MARK: 90.子集II
    // 给你一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）。
    // 解集 不能 包含重复的子集。返回的解集中，子集可以按 任意顺序 排列。
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        var temp: [Int] = [], nums = nums.sorted(), visit = Array(repeating: 0, count: nums.count)
        func subsetsWithDupDfs(result: inout [[Int]], temp: inout [Int], nums: inout [Int], visit: inout [Int], n: Int, length: Int) {
            if n == length {
                result.append(temp)
                return
            }
            //根据后面的条件来进行剪枝操作
            if n == 0 || !(nums[n] == nums[n-1] && visit[n-1] == 0) {
                visit[n] = 1
                temp.append(nums[n])
                subsetsWithDupDfs(result: &result, temp: &temp, nums: &nums, visit: &visit, n: n + 1, length: length)
                temp.removeLast()
                visit[n] = 0
            }
            //本次不选数字进行加一,多次的话就是一个空的子集
            subsetsWithDupDfs(result: &result, temp: &temp, nums: &nums, visit: &visit, n: n + 1, length: length)
        }
        subsetsWithDupDfs(result: &result, temp: &temp, nums: &nums, visit: &visit, n: 0, length: nums.count)
        return result
    }
    
    func clumsy(_ N: Int) -> Int {
        let tempList = ["*", "/", "+", "-"]
        var list: [Int] = [], i = 0
        if N == 1 {
            return 1
        }
        var sum = 0, a = "*"
        list.append(N)
        for x in (1...N-1).reversed() {
            switch a {
            case "*":
                list[list.count-1] *= x
            case "/":
                list[list.count-1] /= x
            case "+":
                list.append(0 - x)
            case "-":
                list.append(x)
            default:
                break
            }
            i += 1
            a = tempList[i % 4]
        }
        
        for i in 0..<list.count {
            if i == 0 {
                sum = list[i]
            } else {
                sum -= list[i]
            }
        }
        return sum
    }
    
    
    
    // MARK: 92.反转链表 II
    // 给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        if left == right {
            return head
        }
        var result = ListNode(-1, head), temp: ListNode? = result, temp1: ListNode?, start: ListNode?, end: ListNode?, num = 0
        while num <= right, temp != nil {
            if num < left {
                start = temp
            } else if num == left {
                end = temp
            }
            if num >= left {
                let a = temp?.next
                temp?.next = temp1
                temp1 = temp
                temp = a
                num += 1
            } else {
                temp = temp?.next
                num += 1
            }
            if num == right + 1 {
                end?.next = temp
                start?.next = temp1
            }
        }
        return result.next
    }
    
    // MARK: 131.分割回文串
    // 给定一个字符串 s，将 s 分割成一些子串，使每个子串都是回文串。返回 s 所有可能的分割方案。
    // 回溯加动态规划,目前效率有点低,可以考虑怎么优化下
    func partition(_ s: String) -> [[String]] {
        // 判断是不是回文字符串
        func isPalindromeStr(str: String) -> Bool {
            let list = Array(str)
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
        if s.count == 0 {
            return []
        }
        var result: [[String]] = []
        
        func dfsPartion(result: inout [[String]], s: String, strList: [String]) {
            if s.count == 0 {
                result.append(strList)
            }
            let list = Array(s)
            for i in 0..<list.count {
                let str = String(list[0..<(list.count - i)])
                if isPalindromeStr(str: str) {
                    let strList = strList + [str]
                    dfsPartion(result: &result, s: String(list[list.count-i..<list.count]), strList: strList)
                } else {
                    continue
                }
            }
        }
        dfsPartion(result: &result, s: s, strList: [])
        return result
    }
    
    // MARK: 132.分割回文串 II
    // 给你一个字符串 s，请你将 s 分割成一些子串，使每个子串都是回文。返回符合要求的 最少分割次数 。
    // 复杂度过不了,倒数第二个用例老是超时,先这样吧,数据量着实有点太大了
    func minCut(_ s: String) -> Int {
        func isPalindromeList(list: [Character]) -> Bool {
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
        let list = Array(s)
        if isPalindromeList(list: list) {
            return 0
        }
        var map: [Int: [Int: Bool]] = [:]
        for i in 0..<s.count {
            var tempMap: [Int: Bool] = [:]
            for j in (i..<s.count) {
                tempMap[j] = isPalindromeList(list: Array(list[i...j]))
            }
            map[i] = tempMap
        }
        
        var tempList: [Int] = Array(repeating: Int.max, count: s.count)
        for i in 0..<s.count {
            if map[0]![i]! {
                tempList[i] = 0
            } else {
                for j in 0..<i where map[j+1]![i]! {
                    tempList[i] = min(tempList[i], tempList[j] + 1)
                }
            }
        }
        return tempList[s.count-1]
    }
    
    // MARK: 179.最大数
    // 给定一组非负整数 nums，重新排列每个数的顺序（每个数不可拆分）使之组成一个最大的整数。
    // 注意：输出结果可能非常大，所以你需要返回一个字符串而不是整数。
    func largestNumber(_ nums: [Int]) -> String {
        if nums.filter({return $0 != 0}).count == 0 {
            return "0"
        }
        let list = nums.sorted { (i, j) -> Bool in
            let l1 = String(i), l2 = String(j)
            return Int(l1 + l2)! > Int(l2 + l1)!
        }
        var result = ""
        for l in list {
            result += String(l)
        }
        return result
    }
    
    // MARK: 190.颠倒二进制位
    // 颠倒给定的 32 位无符号整数的二进制位。
    func reverseBits(_ n: Int) -> Int {
        var n = n, sum = 0, count = 0
        while n != 0 {
            sum *= 2
            sum += n % 2
            n /= 2
            count += 1
        }
        while count < 32 {
            sum *= 2
            count += 1
        }
        return sum
    }
    
    // MARK: 191.位1的个数
    // 编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数（也被称为汉明重量）。
    func hammingWeight(_ n: Int) -> Int {
        var result = 0, n = n
        while n > 0 {
            result += n % 2
            n /= 2
        }
        return result
    }
    
    // MARK: 224.基本计算器
    // 实现一个基本的计算器来计算一个简单的字符串表达式 s 的值。
    // s由数字、'+'、'-'、'('、')'、和 ' ' 组成
    func calculate(_ s: String) -> Int {
        var sum = 0, sign = 1, stackList: [Int] = [], num = 0
        let strList = Array(s)
        stackList.append(sign)
        for c in strList where c != " " {
            if Int(String(c)) != nil {
                num = num * 10 + Int(String(c))!
            } else {
                sum += sign * num
                num = 0
                switch c {
                case "(":
                    stackList.append(sign)
                case ")":
                    stackList.removeLast()
                case "+":
                    sign = stackList.last!
                case "-":
                    sign = -stackList.last!
                default:
                    break
                }
            }
        }
        if num != 0 {
            sum += sign * num
        }
        return sum
    }
    
    // MARK: 227.基本计算器 II
    // 给你一个字符串表达式 s ，请你实现一个基本计算器来计算并返回它的值。整数除法仅保留整数部分。
    // s 由整数和算符 ('+', '-', '*', '/') 组成，中间由一些空格隔开
    func calculate1(_ s: String) -> Int {
        //这里给字符串加了以为,确保可以在计算完之后走一次运算符,把多余的temp加进去
        //大致思路就是记录上一次的运算符,然后跟本次的数值进行运算,是+-可以直接加在resultList里,是*/的话跟resultList的最后一位进行运算
        let list = Array(s) + "/"
        var resultList: [Int] = []
        var symbol: Character = "+", i = 0, temp = 0
        while i < list.count {
            if list[i] == " " {
            } else {
                if Int(String(list[i])) != nil {
                    temp = temp * 10 + Int(String(list[i]))!
                } else {
                    switch symbol {
                    case "+":
                        resultList.append(temp)
                    case "-":
                        resultList.append(-temp)
                    case "*":
                        resultList[resultList.count - 1] *= temp
                    case "/":
                        resultList[resultList.count - 1] /= temp
                    default:
                        break
                    }
                    temp = 0
                    symbol = list[i]
                }
            }
            i += 1
        }
        var sum = 0
        
        for r in resultList {
            sum += r
        }
        
        return sum
    }
    
    // MARK: 263.丑数
    // 给你一个整数 n ，请你判断 n 是否为 丑数 。如果是，返回 true ；否则，返回 false 。
    // 丑数 就是只包含质因数 2、3 和/或 5 的正整数。默认1是丑数
    func isUgly(_ n: Int) -> Bool {
        var n = n
        //因为是235的乘积,所以不会乘出来负数
        while n > 0 {
            let temp = n
            for i in [2, 3, 5] {
                if n % i == 0 {
                    n /= i
                }
            }
            if n == 1 {
                return true
            }
            if n == temp {
                return false
            }
        }
        return false
    }
    
    
    
    // MARK: 264.丑数 II
    // 给你一个整数 n ，请你找出并返回第 n 个 丑数 。
    // 丑数 就是只包含质因数 2、3 和/或 5 的正整数。默认1是丑数
    func nthUglyNumber(_ n: Int) -> Int {
        var l2 = 0, l3 = 0, l5 = 0, nums = Array(repeating: 1, count: n)
        for i in 1..<n {
            let n2 = nums[l2] * 2, n3 = nums[l3] * 3, n5 = nums[l5] * 5, minNum = min(n2, n3, n5)
            nums[i] = minNum
            if minNum == n2 {
                l2 += 1
            }
            if minNum == n3 {
                l3 += 1
            }
            if minNum == n5 {
                l5 += 1
            }
            
        }
        return nums[n-1]
    }
    
    // MARK: 338.比特位计数
    // 给定一个非负整数 num。对于 0 ≤ i ≤ num 范围中的每个数字 i ，计算其二进制数中的 1 的数目并将它们作为数组返回。
    func countBits(_ num: Int) -> [Int] {
        if num == 0 {
            return [0]
        }
        var result: [Int] = Array(repeating: 0, count: num + 1)
        for i in 1...num {
            result[i] = result[i & (i-1)] + 1
        }
        return result
    }
    
    // MARK: 354. 俄罗斯套娃信封问题
    // 给定一些标记了宽度和高度的信封，宽度和高度以整数对形式 (w, h) 出现。
    // 当另一个信封的宽度和高度都比这个信封大的时候，这个信封就可以放进另一个信封里，如同俄罗斯套娃一样。
    // 请计算最多能有多少个信封能组成一组“俄罗斯套娃”信封（即可以把一个信封放到另一个信封里面）。
    func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
        let envelopes = envelopes.sorted { (list1, list2) -> Bool in
            if list1[0] == list2[0] {
                return list1[1] > list2[1]
            } else {
                return list1[0] < list2[0]
            }
        }
        let list = envelopes.map { (list) -> Int in
            return list[1]
        }
        //上面的操作是把两维数组做了个降维操作,以w为主排序字段升序排列, h为副排序字段降序排列,保证同等宽的信封不会被重复取值,下面的逻辑还没看懂...
        var tempList = Array(repeating: 1, count: list.count)
        var maxCount = 0
        for i in 0..<list.count {
            for j in 0..<i {
                if list[i] > list[j] {
                    tempList[i] = max(tempList[i], tempList[j] + 1)
                }
            }
            maxCount = max(maxCount, tempList[i])
        }
        return maxCount
    }
    
    // MARK: 395.至少有K个重复字符的最长子串
    // 找到给定字符串（由小写字符组成）中的最长子串 T ， 要求 T 中的每一字符出现次数都不少于 k 。输出 T 的长度。
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        var map: [Character: Int] = [:], maxCount = 0, i = 0
        for c in s {
            if map[c] == nil {
                map[c] = 1
            } else {
                map[c]! += 1
            }
        }
        let conformList = map.keys.filter( {return map[$0]! >= k} ), list = Array(s)
        while i < list.count {
            if !conformList.contains(list[i]) {
                let temp = i
                while i < list.count, !conformList.contains(list[i]) {
                    i += 1
                }
                i -= 1
                return max(longestSubstring(String(list[0..<temp]), k), longestSubstring(String(list[i+1..<list.count]), k))
            } else {
                maxCount += 1
                i += 1
            }
        }
        return maxCount
    }
    
    // MARK: 456. 132模式
    // 给你一个整数数组 nums ，数组中共有 n 个整数。132 模式的子序列 由三个整数 nums[i]、nums[j] 和 nums[k] 组成，并同时满足：i < j < k 和 nums[i] < nums[k] < nums[j] 。如果 nums 中存在 132 模式的子序列 ，返回 true ；否则，返回 false 。
    func find132pattern(_ nums: [Int]) -> Bool {
        //复杂度高,低的不会写
        var list1: [Int] = []
        var minNum = Int.max
        for i in 0..<nums.count {
            list1.append(minNum)
            minNum = min(minNum, nums[i])
            if nums[i] <= minNum {
                continue
            }
            for j in i..<nums.count {
                if nums[j] > minNum, nums[i] > nums[j] {
                    return true
                }
            }
        }
        return false
    }
    
    // MARK: 503.下一个更大元素 II
    // 给定一个循环数组（最后一个元素的下一个元素是数组的第一个元素），输出每个元素的下一个更大元素。数字 x 的下一个更大的元素是
    // 按数组遍历顺序，这个数字之后的第一个比它更大的数，这意味着你应该循环地搜索它的下一个更大的数。如果不存在，则输出 -1。
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        if nums.count == 0 {
            return []
        }
        if nums.count == 1 {
            return [-1]
        }
        let list = nums + nums
        var result: [Int] = []
        for i in 0..<nums.count {
            var hasNextGreater = false
            for j in i+1..<list.count where list[j] > nums[i] {
                result.append(list[j])
                hasNextGreater = true
                break
            }
            if !hasNextGreater {
                result.append(-1)
            }
        }
        return result
    }
    
    // MARK: 766.托普利茨矩阵
    // 给你一个 m x n 的矩阵 matrix 。如果这个矩阵是托普利茨矩阵，返回 true ；否则，返回 false 。
    // 如果矩阵上每一条由左上到右下的对角线上的元素都相同，那么这个矩阵是 托普利茨矩阵 。
    // [
    // [1,2,3]
    // [2,1,2]
    // [3,2,1]
    // ]
    func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
        for i in 1..<matrix.count {
            for j in 1..<matrix[0].count {
                if matrix[i][j] != matrix[i - 1][j - 1] {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: 832. 翻转图像
    // 给定一个二进制矩阵 A，我们想先水平翻转图像，然后反转图像并返回结果。
    // 水平翻转图片就是将图片的每一行都进行翻转，即逆序。例如，水平翻转 [1, 1, 0] 的结果是 [0, 1, 1]。
    // 反转图片的意思是图片中的 0 全部被 1 替换， 1 全部被 0 替换。例如，反转 [0, 1, 1] 的结果是 [1, 0, 0]。
    func flipAndInvertImage(_ A: [[Int]]) -> [[Int]] {
        var result: [[Int]] = []
        let map: [Int: Int] = [1: 0, 0: 1]
        for l in A {
            var temp = l
            var left = 0, right = temp.count - 1
            while left <= right {
                temp.swapAt(left, right)
                temp[left] = map[temp[left]]!
                temp[right] = map[temp[right]]!
                left += 1
                right -= 1
            }
            if left == right {
                temp[left] = map[temp[left]]!
            }
            result.append(temp)
        }
        return result
    }
    
    // MARK: 867. 转置矩阵
    // 给你一个二维整数数组 matrix， 返回 matrix 的 转置矩阵 。
    // 矩阵的 转置 是指将矩阵的主对角线翻转，交换矩阵的行索引与列索引。
    func transpose(_ matrix: [[Int]]) -> [[Int]] {
        let m = matrix.count, n = matrix[0].count
        var result:[[Int]] = Array(repeating: Array(repeating: 0, count: m), count: n)
        for i in 0..<m {
            for j in 0..<n {
                result[j][i] = matrix[i][j]
            }
        }
        return result
    }
    
    // MARK: 896.单调数列
    // 如果数组是单调递增或单调递减的，那么它是单调的。当给定的数组 A 是单调数组时返回 true，否则返回 false。
    func isMonotonic(_ A: [Int]) -> Bool {
        if A.count < 2 { return true }
        let first = A[0], last = A[A.count - 1]
        //是否升序
        var isUp = true
        if first > last {
            isUp = false
        }
        for i in 0..<A.count-1 {
            if isUp {
                if A[i] > A[i+1] {
                    return false
                }
            } else {
                if A[i] < A[i+1] {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: 1052. 爱生气的书店老板
    // 今天，书店老板有一家店打算试营业 customers.length 分钟。每分钟都有一些顾客（customers[i]）会进入书店，
    // 所有这些顾客都会在那一分钟结束后离开。在某些时候，书店老板会生气。 如果书店老板在第 i 分钟生气，那么 grumpy[i] = 1，
    // 否则 grumpy[i] = 0。 当书店老板生气时，那一分钟的顾客就会不满意，不生气则他们是满意的。
    // 书店老板知道一个秘密技巧，能抑制自己的情绪，可以让自己连续 X 分钟不生气，但却只能使用一次。
    // 请你返回这一天营业下来，最多有多少客户能够感到满意的数量。
    // 例: customers = [1,0,1,2,1,1,7,5], grumpy = [0,1,0,1,0,1,0,1], X = 3 输出: 16
    // 书店老板在最后 3 分钟保持冷静。感到满意的最大客户数量 = 1 + 1 + 1 + 1 + 7 + 5 = 16.
    func maxSatisfied(_ customers: [Int], _ grumpy: [Int], _ X: Int) -> Int {
        var normalNum = 0, maxNum = 0
        for i in 0..<customers.count {
            if grumpy[i] == 0 {
                normalNum += customers[i]
            }
        }
        maxNum = normalNum
        var tempNum = normalNum
        var i = 0
        while i < grumpy.count - X + 1 {
            if i == 0 {
                for j in i..<i+X {
                    if grumpy[j] == 1 {
                        tempNum += customers[j]
                    }
                }
            } else {
                if grumpy[i-1] == 1 {
                    tempNum -= customers[i-1]
                }
                if grumpy[i+X-1] == 1 {
                    tempNum += customers[i+X-1]
                }
            }
            maxNum = max(maxNum, tempNum)
            i += 1
        }
        
        return maxNum
    }
    
    // MARK: 1143. 最长子序列
    // 两个字符串的 公共子序列 是这两个字符串所共同拥有的子序列。
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let list1 = Array(text1), list2 = Array(text2)
        var t: [[Int]] = Array(repeating: Array(repeating: 0, count: list2.count + 1), count: list1.count + 1)
        for i in 1...list1.count {
            for j in 1...list2.count {
                if list1[i-1] == list2[j-1] {
                    t[i][j] = t[i-1][j-1] + 1
                } else {
                    t[i][j] = max(t[i][j-1], t[i-1][j])
                }
            }
        
        }
        return t[list1.count][list2.count]
    }
    
}


// MARK: 303.区域和检索 - 数组不可变
// 给定一个整数数组  nums，求出数组从索引 i 到 j（i ≤ j）范围内元素的总和，包含 i、j 两点。
// 实现 NumArray 类：NumArray(int[] nums) 使用数组 nums 初始化对象
// int sumRange(int i, int j) 返回数组 nums 从索引 i 到 j（i ≤ j）范围内元素的总和，包含 i、j 两点（也就是 sum(nums[i], nums[i + 1], ... , nums[j])）
//输入：["NumArray", "sumRange", "sumRange", "sumRange"] [[[-2, 0, 3, -5, 2, -1]], [0, 2], [2, 5], [0, 5]]
// 输出：
// [null, 1, -1, -3]
class NumArray {
    var nums: [Int] = []
    init(_ nums: [Int]) {
        self.nums = nums
    }
    func sumRange(_ i: Int, _ j: Int) -> Int {
        var sum = 0, left = i, right = j
        while left < right {
            sum += nums[left]
            sum += nums[right]
            left += 1
            right -= 1
        }
        if left == right {
            sum += nums[left]
        }
        return sum
    }
}

// MARK: 304. 二维区域和检索 - 矩阵不可变
// 给定一个二维矩阵，计算其子矩形范围内元素的总和，该子矩阵的左上角为 (row1, col1) ，右下角为 (row2, col2)。
class NumMatrix {
    var result: [[Int]] = []
    init(_ matrix: [[Int]]) {
        result = Array(repeating: Array(repeating: 0, count: matrix.first?.count ?? 0), count: matrix.count)
        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                if i == 0 && j == 0 {
                    result[0][0] = matrix[0][0]
                } else if i == 0 {
                    result[0][j] = result[0][j-1] + matrix[0][j]
                } else if j == 0 {
                    result[i][0] = result[i-1][0] + matrix[i][0]
                } else {
                    result[i][j] = result[i-1][j] + result[i][j-1] - result[i-1][j-1] + matrix[i][j]
                }
            }
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0
        sum += result[row2][col2]
        if row1 > 0 {
            sum -= result[row1 - 1][col2]
        }
        if col1 > 0 {
            sum -= result[row2][col1 - 1]
        }
        if row1 > 0, col1 > 0 {
            sum += result[row1 - 1][col1-1]
        }
        return sum
    }
}

// MARK: 232. 用栈实现队列
// 请你仅使用两个栈实现先入先出队列。队列应当支持一般队列的支持的所有操作（push、pop、peek、empty）：
// 实现 MyQueue 类：
// void push(int x) 将元素 x 推到队列的末尾
// int pop() 从队列的开头移除并返回元素
// int peek() 返回队列开头的元素
// boolean empty() 如果队列为空，返回 true ；否则，返回 false
class MyQueue {
    
    var list1: [Int]
    var list2: [Int]
    /** Initialize your data structure here. */
    init() {
        list1 = []
        list2 = []
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        //每次添加新元素的时候把list1清栈,放进list2中入栈,然后添加新元素,然后倾倒给list1,栈顶也就是last元素是最先push的元素
        var count = list1.count
        for _ in 0..<count {
            list2.append(list1.removeLast())
        }
        list2.append(x)
        count = list2.count
        for _ in 0..<count {
            list1.append(list2.removeLast())
        }
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        list1.removeLast()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        return list1.last ?? 0
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return list1.isEmpty
    }
}

// MARK: 1603. 设计停车系统
class ParkingSystem {
    var list = [0,0,0]
    
    init(_ big: Int, _ medium: Int, _ small: Int) {
        list[0] = big
        list[1] = medium
        list[2] = small
    }
    
    func addCar(_ carType: Int) -> Bool {
        list[carType-1] -= 1
        return list[carType-1] >= 0
    }
}

let SL = Solution()
SL.nthUglyNumber(10)



