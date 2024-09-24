def maxCommonSubstringLength(str1, str2):
    
    sub = 0
    subMax = 0
    # find length of input arrays.
    len1 = len(str1)
    len2 = len(str2)

    for i in range(len1):
        for j in range(len2):
            if str1[i] == str2[j]:
                sub = sub + 1
                if sub > subMax:
                    subMax = sub
                i = i + 1
                if i == len1:
                    i = i - 1
                    break
            else:
                sub = 0

    return subMax

def isSubstring(sub, str):
    # return True if the length of the common substring
    # is the same as the length of the substring

    lenSub = len(sub)
    lenStr = len(str)
    
    if lenStr < lenSub:
        return False

    commonSubStrLen = maxCommonSubstringLength(sub, str)

    return lenSub == commonSubStrLen

def haveCommonKSubstring(k, str1, str2):
    return False

def isPrefix(pre, str):
    lenPre = len(pre)
    lenStr = len(str)
    
    if lenStr < lenPre:
        return False

    for i in range(lenPre):
        if str[i] != pre[i]:
            return False
    return True

def test_maxCommonSubstringLength():
    str1 = input("First word: ")
    str2 = input("Second word: ")

    maxSub = maxCommonSubstringLength(str1, str2)

    print(maxSub)

def test_isPrefix():
    assert not isPrefix("123", "456") # not prefix
    assert not isPrefix("1234", "56") # prefix too long
    assert isPrefix("", "123456") # empty prefix
    assert isPrefix("", "") # empty prefix and string
    assert isPrefix("123", "123") # same
    assert isPrefix("12", "123") # matching prefix
    print("test_isPrefix passed")

def test_isSubstring():
    assert isSubstring("", "")
    assert isSubstring("", "1")
    assert not isSubstring("1", "")
    assert isSubstring("123", "123")
    assert not isSubstring("12", "3456")
    assert isSubstring("12", "123456")
    assert isSubstring("34", "123456")
    assert isSubstring("56", "123456")
    print("test_isSubstring passed")

def main():
    # test_maxCommonSubstringLength()
    # test_isPrefix()
    # test_isSubstring()
    pass

if __name__ == "__main__":
    main()