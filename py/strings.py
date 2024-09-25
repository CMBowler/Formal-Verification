import test_input as test

# The following method should return true if and only if pre is a prefix of str. That is, str starts with pre. 
def isPrefix(pre, str) -> bool:
    lenPre = len(pre)
    lenStr = len(str)

    if lenStr < lenPre:
        return False

    for i in range(lenPre):
        if str[i] != pre[i]:
            return False
    return True

# The following method should return true if and only if sub is a substring of str. That is, str contains sub. 
def isSubstring(sub, str) -> bool:
    lenSub = len(sub)
    lenStr = len(str)

    if lenStr < lenSub:
        return False

    if isPrefix(sub, str):
        return True

    for i in range(lenStr):
        if i == 0:
            continue
        if isPrefix(sub, str[i:]):
            return True

    return False

# The following method should return true if and only if str1 and str1 have a common substring of length k. 
def haveCommonKSubstring(k: int, str1, str2) -> bool:
    lenStr1 = len(str1)
    lenStr2 = len(str2)

    if k > lenStr1 or k > lenStr2:
        return False

    if k == 0:
        return True

    for i in range(lenStr1):
        if i+k > lenStr1:
            break
        for j in range(lenStr2):
            if j+k > lenStr2:
                break
            if isSubstring(str1[i:i+k], str2[j:j+k]):
                return True

    return False

# The following method should return the natural number len which is equal 
# to the length of the longest common substring of str1 and str2.
# Note that every two strings have a common substring of length zero. 
def maxCommonSubstringLength(str1, str2) -> int:
    lenStr1 = len(str1)
    lenStr2 = len(str2)

    kMax = lenStr1 if lenStr1 < lenStr2 else lenStr2
    max = 0

    for k in range(kMax+1):
        if haveCommonKSubstring(k, str1, str2):
            max = k
    return max

def test_haveCommonKSubstring():
    pass

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
    assert not isSubstring("123", "456")
    assert not isSubstring("456", "123")
    assert not isSubstring("12", "3456")
    assert not isSubstring("3456", "12")
    assert isSubstring("12", "123456")
    assert isSubstring("34", "123456")
    assert isSubstring("56", "123456")
    print("test_isSubstring passed")

def test_haveCommonKSubstring():
    assert haveCommonKSubstring(0, "", "")
    assert haveCommonKSubstring(0, "123", "456")
    assert haveCommonKSubstring(0, "123", "")
    assert haveCommonKSubstring(0, "", "456")

    assert not haveCommonKSubstring(1, "", "")
    assert not haveCommonKSubstring(1, "123", "456")
    assert not haveCommonKSubstring(1, "123", "")
    assert not haveCommonKSubstring(1, "", "456")

    assert haveCommonKSubstring(1, "123A", "456A")
    assert haveCommonKSubstring(1, "123A", "A456")
    assert haveCommonKSubstring(1, "123A", "45A6")
    assert haveCommonKSubstring(1, "A123", "A456")
    assert haveCommonKSubstring(1, "A123", "456A")
    assert haveCommonKSubstring(1, "A123", "45A6")
    assert haveCommonKSubstring(1, "1A23", "45A6")
    assert haveCommonKSubstring(1, "1A23", "456A")
    assert haveCommonKSubstring(1, "1A23", "A456")

    assert haveCommonKSubstring(2, "123456", "12")
    assert haveCommonKSubstring(2, "12", "123456")
    assert haveCommonKSubstring(2, "12", "12")
    assert haveCommonKSubstring(2, "123456", "XXXX56")
    assert not haveCommonKSubstring(2, "123456", "XXXX")

    assert not haveCommonKSubstring(3, "123456", "12")
    assert not haveCommonKSubstring(3, "12", "123456")
    assert not haveCommonKSubstring(3, "12", "12")
    assert not haveCommonKSubstring(3, "123456", "XXXX56")

    print("test_haveCommonKSubstring passed")


def test_maxCommonSubstringLength():
    assert maxCommonSubstringLength("", "") == 0
    assert maxCommonSubstringLength("123", "") == 0
    assert maxCommonSubstringLength("123", "456") == 0
    assert maxCommonSubstringLength("", "456") == 0

    assert maxCommonSubstringLength("123A", "456A") == 1
    assert maxCommonSubstringLength("123A", "A456") == 1
    assert maxCommonSubstringLength("123A", "45A6") == 1
    assert maxCommonSubstringLength("A123", "A456") == 1
    assert maxCommonSubstringLength("A123", "456A") == 1
    assert maxCommonSubstringLength("A123", "45A6") == 1
    assert maxCommonSubstringLength("1A23", "45A6") == 1
    assert maxCommonSubstringLength("1A23", "456A") == 1
    assert maxCommonSubstringLength("1A23", "A456") == 1

    assert maxCommonSubstringLength("12", "123456") == 2
    assert maxCommonSubstringLength("123456", "12") == 2
    assert maxCommonSubstringLength("12", "12") == 2
    assert maxCommonSubstringLength("123456", "XXXX56") == 2

    print("test_maxCommonSubstringLength passed")

def main():

    command = "_"
    print("Select test or exit:")
    print("Test Max Common Substring Length: " + test.TEST_MAX_COMMON_SUBSTRING + " ")
    print("Test Common K Substring: " + test.TEST_IS_K_SUBSTRING + " ")
    print("Test Substring: " + test.TEST_SUBSTRING + " ")
    print("Test Prefix: " + test.TEST_PREFIX + " ")
    print("Test All: " + test.TEST_ALL + " ")
    while command != test.EXIT:
        command = input("Chosen Test: ")
        match command:
            case test.TEST_MAX_COMMON_SUBSTRING:
                test_maxCommonSubstringLength()
            case test.TEST_IS_K_SUBSTRING:
                test_haveCommonKSubstring()
            case test.TEST_SUBSTRING:
                test_isSubstring()
            case test.TEST_PREFIX:
                test_isPrefix()
            case test.TEST_ALL:
                test_maxCommonSubstringLength()
                test_haveCommonKSubstring()
                test_isSubstring()
                test_isPrefix()


if __name__ == "__main__":
    main()
