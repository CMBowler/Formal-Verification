predicate isPrefixPred(pre:string, str:string)
{
    (|pre| <= |str|) && (pre == str[..|pre|])
}

predicate isNotPrefixPred(pre:string, str:string)
{
    (|pre| > |str|) || (pre != str[..|pre|])
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma PrefixNegationLemma(pre:string, str:string)
    ensures isPrefixPred(pre,str) <==> !isNotPrefixPred(pre,str)
    ensures !isPrefixPred(pre,str) <==>  isNotPrefixPred(pre,str)
{}

predicate isSubstringPred(sub:string, str:string)
{
    (exists i :: ((0 <= i < |str|) && (isPrefixPred(sub, str[i..])))) || (|sub| == 0)
}

predicate isNotSubstringPred(sub:string, str:string)
{
    (forall i :: ((0 <= i < |str|) ==> (isNotPrefixPred(sub, str[i..])))) && (|sub| != 0)
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma SubstringNegationLemma(sub:string, str:string)
    ensures  isSubstringPred(sub,str) <==> !isNotSubstringPred(sub,str)
    ensures !isSubstringPred(sub,str) <==>  isNotSubstringPred(sub,str)
{}

// The following predicate should be true if and only if str1 and str2
// have a common substring of length k.
predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string)
{
    // _s start _e end
    (exists i_s, i_e :: (((0 <= i_s < (|str1| - k)) && (i_e == (i_s + k))) && isSubstringPred(str1[i_s..i_e], str2))) &&
    (exists j_s, j_e :: (((0 <= j_s < (|str2| - k)) && (j_e == (j_s + k))) && isSubstringPred(str2[j_s..j_e], str1)))
}

predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)
{
    // _s start _e end
    (forall i_s, i_e :: (((0 <= i_s < (|str1| - k)) && (i_e == (i_s + k))) ==> isNotSubstringPred(str1[i_s..i_e], str2))) ||
    (forall j_s, j_e :: (((0 <= j_s < (|str2| - k)) && (j_e == (j_s + k))) ==> isNotSubstringPred(str2[j_s..j_e], str1)))
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
    ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)
    ensures !haveCommonKSubstringPred(k,str1,str2) <==> haveNotCommonKSubstringPred(k,str1,str2)
{}
