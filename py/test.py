from module_ import default__

isPrefix = default__.isPrefix
isSubstring = default__.isSubstring
haveCommonKSubstring = default__.haveCommonKSubstring
maxCommonSubstringLength = default__.maxCommonSubstringLength

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
    test_isPrefix()
    test_isSubstring()
    # test_haveCommonKSubstring()
    # test_maxCommonSubstringLength()


if __name__ == "__main__":
    main()
