// The following method should return true if and only if pre is a prefix of str. That is, str starts with pre. 
method isPrefix(pre: string, str: string) returns (res:bool)
{
    if |pre| > |str|
        { return false; }

    var i := 0;
    while i < |pre|
        invariant 0 <= i <= |pre|
    {
        if pre[i] != str[i]
            { return false; }
        i := i + 1;
    }
    return true;
}

// The following method should return true if and only if sub is a substring of str. That is, str contains sub. 
method isSubstring(sub: string, str: string) returns (res:bool)
{
    if |sub| > |str|
        { return false; }

    var rv: bool;
    rv := isPrefix(sub, str);
    if rv
        { return true; }
    
    var i := 0;
    while i < |str|
        invariant 0 <= i <= |str|
    {
        if i != 0
        {
            rv := isPrefix(sub, str[i..]);
            if rv
                { return true; }
        }
        i := i + 1;
    }
    return false;
}

// The following method should return true if and only if str1 and str1 have a common substring of length k. 
method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool)
{
    if k > |str1| || k > |str1|
        { return false; }

    if k == 0
        { return true; }

    var rv: bool;
    var i := 0;
    while i < |str1|
        invariant 0 <= i <= |str1|
    {
        if i+k > |str1|
            { break; }
        var j := 0;
        while j < |str2|
            invariant 0 <= j <= |str2|
        {
            if j+k > |str2|
                { break; }
            rv := isSubstring(str1[i..(i+k)], str2[j..(j+k)]);
            if rv
                { return true; }
            j := j + 1;
        }
        i := i + 1;
    }
    return false;
}

// The following method should return the natural number len which is equal 
// to the length of the longest common substring of str1 and str2.
// Note that every two strings have a common substring of length zero. 
method maxCommonSubstringLength(str1: string, str2: string) returns (len: nat)
{
    var kMax := if |str1| < |str2| then |str1| else |str2|;
    var max := 0;

    len := 0;
    var rv: bool;
    var k: nat := 0;
    while k < (kMax+1)
        invariant 0 <= k <= (kMax+1)
    {
        rv := haveCommonKSubstring(k, str1, str2);
        if rv
            { len := k; }
        k := k + 1;
    }
}
