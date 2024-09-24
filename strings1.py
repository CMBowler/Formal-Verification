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

str1 = input("First word: ")
str2 = input("Second word: ")

maxSub = maxCommonSubstringLength(str1, str2)

print(maxSub)

exit()

