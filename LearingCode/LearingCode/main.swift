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
    
}
let SL = Solution()
SL.searchRange1([2,2], 2)






