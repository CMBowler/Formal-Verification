predicate isPrefixPred(pre:string, str:string)
{
	(|pre| <= |str|) && 
	pre == str[..|pre|]
}

predicate isNotPrefixPred(pre:string, str:string)
{
	(|pre| > |str|) || 
	pre != str[..|pre|]
}

lemma PrefixNegationLemma(pre:string, str:string)
	ensures  isPrefixPred(pre,str) <==> !isNotPrefixPred(pre,str)
	ensures !isPrefixPred(pre,str) <==>  isNotPrefixPred(pre,str)
{}

method isPrefix(pre: string, str: string) returns (res:bool)
	ensures !res <==> isNotPrefixPred(pre,str)
	ensures  res <==> isPrefixPred(pre,str)

{
    if |pre| > |str| {
        res:=false;
    } else {
        res := true;
        var i := 0;

        while i < |pre|
            invariant 0 <= i <= |pre|
            invariant  res <==> isPrefixPred(pre[..i], str)
            invariant !res <==> isNotPrefixPred(pre[..i], str)
        {
            if pre[i] != str[i] {
                res := false;
            } else {
                res := res;
            }
            i := i + 1;
        }
    }
}

predicate isSubstringPred(sub:string, str:string)
{
	(exists i :: 0 <= i <= |str| &&  isPrefixPred(sub, str[i..]))
}

predicate isNotSubstringPred(sub:string, str:string)
{
	(forall i :: 0 <= i <= |str| ==> isNotPrefixPred(sub,str[i..]))
}

lemma SubstringNegationLemma(sub:string, str:string)
	ensures  isSubstringPred(sub,str) <==> !isNotSubstringPred(sub,str)
	ensures !isSubstringPred(sub,str) <==>  isNotSubstringPred(sub,str)
{}

method isSubstring(sub: string, str: string) returns (res:bool)
	ensures  res <==> isSubstringPred(sub, str)
	ensures !res <==> isNotSubstringPred(sub, str) // This postcondition follows from the above lemma.
{
    res := false;
    var i := 0;

    while i <= |str|
        invariant 0 <= i <= |str|+1
        invariant res <==> (exists j :: 0 <= j < i <= |str|+1 && isPrefixPred(sub, str[j..]))
        invariant !res <==> (forall j :: 0 <= j < i <= |str|+1 ==> isNotPrefixPred(sub, str[j..]))
    {
        var rv := isPrefix(sub, str[i..]);
        if rv {
            res := true;
        } else {
            res := res;
        }
        i := i + 1;
    }
}

predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	exists i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k && isSubstringPred(str1[i1..j1],str2)
}

predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	forall i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k ==>  isNotSubstringPred(str1[i1..j1],str2)
}

lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
	ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)
	ensures !haveCommonKSubstringPred(k,str1,str2) <==>  haveNotCommonKSubstringPred(k,str1,str2)
{}

method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool)
	ensures found  <==>  haveCommonKSubstringPred(k,str1,str2)
	ensures !found <==> haveNotCommonKSubstringPred(k,str1,str2) // This postcondition follows from the above lemma.
{
    if k > |str1| || k > |str2| {
        found := false;
    } else {
        found := false;
        var i1 := 0;

        while i1 <= |str1|- k
            invariant 0 <= i1 <= |str1| - k + 1
            invariant found <==> (exists i2, j2 :: 0 <= i2 < i1 <= |str1| - k + 1 && j2 == i2 + k && isSubstringPred(str1[i2..j2],str2))
            invariant !found <==> (forall i2, j2 :: 0 <= i2 < i1 <= |str1| - k + 1 && j2 == i2 + k ==> isNotSubstringPred(str1[i2..j2],str2))
        {
            var j1 := i1 + k;
            var rv := isSubstringPred(str1[i1..j1],str2);
            if rv {
                found := true;
            } else {
                found := found;
            }
            i1 := i1 + 1;
        }
    }
}

lemma haveCommon0SubstringLemma(str1:string, str2:string)
    ensures  haveCommonKSubstringPred(0,str1,str2)
{
    assert isPrefixPred(str1[0..0], str2[0..]);
}

method maxCommonSubstringLength(str1: string, str2: string) returns (len:nat)
	requires (|str1| <= |str2|)
	ensures (forall k :: len < k <= |str1| ==> !haveCommonKSubstringPred(k,str1,str2))
	ensures haveCommonKSubstringPred(len,str1,str2)
{
    var check := 0;
    len := 0;

    // hint for Dafny
    haveCommon0SubstringLemma(str1, str2);

    while check <= |str1|
        invariant 0 <= check <= |str1| + 1
        invariant (forall j :: len < j < check <= |str1| + 1 ==> !haveCommonKSubstringPred(j,str1,str2))
        invariant haveCommonKSubstringPred(len,str1,str2)
    {
        var rv := haveCommonKSubstringPred(check,str1,str2);
        if rv {
            len := check;
        } else {
            len := len;
        }
        check := check + 1;
    }
}
