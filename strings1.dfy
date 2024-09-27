// The following method should return true if and only if pre is a prefix of str. That is, str starts with pre. 
method isPrefix(pre: string, str: string) returns (res:bool)
    // requires |pre| <= |str| // todo: do we want the function to reject these cases?
{
    if |pre| > |str|
        { return false;}

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
    // requires |sub| <= |str| // todo: do we want the function to reject these cases?
{
    if |sub| > |str|
        { return false;}

    var rv: bool; 
    rv := isPrefix(sub, str);
    if rv
        { return true; }
    
    var i := 0;
    while  i < |str|
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
// method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool)
// {

// }

// The following method should return the natural number len which is equal 
// to the length of the longest common substring of str1 and str2.
// Note that every two strings have a common substring of length zero. 
// method maxCommonSubstringLength(str1: string, str2: string) returns (len:nat)
// {

// }