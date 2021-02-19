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
    
}
let SL = Solution()



