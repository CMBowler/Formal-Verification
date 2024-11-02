predicate isPrefixPred(pre:string, str:string)
{
	(|pre| <= |str|) && pre == str[..|pre|]
}

predicate isNotPrefixPred(pre:string, str:string)
{
    (|pre| > |str|) || pre != str[..|pre|] // not (isPrefixPred) and De Morgan
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma PrefixNegationLemma(pre:string, str:string)
	ensures  isPrefixPred(pre,str) <==> !isNotPrefixPred(pre,str)
	ensures !isPrefixPred(pre,str) <==>  isNotPrefixPred(pre,str)
{}


predicate isSubstringPred(sub:string, str:string)
{
    (exists i :: ((0 <= i < |str|) && isPrefixPred(sub, str[i..])))
}

predicate isNotSubstringPred(sub:string, str:string)
{
    forall i :: ((0 <= i < |str|) ==> (isNotPrefixPred(sub, str[i..])))
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma SubstringNegationLemma(sub:string, str:string)
	ensures  isSubstringPred(sub,str) <==> !isNotSubstringPred(sub,str)
	ensures !isSubstringPred(sub,str) <==>  isNotSubstringPred(sub,str)
{}


// The following predicate should be true if and only if str1 and str2
//  have a common substring of length k. 
// You can refer to the preceding predicates within the body of 
// this predicate.
predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string)
{
    (k == 0) || ((k <= |str1| && k <= |str2| && (forall i :: (0 <= i < |str1|-k) ==> (forall j :: (0 <= j < |str2|-k) ==> (exists d :: ((k == d) && isSubstringPred(str1[i..(i+k)], str2[j..(j+k)])))))))
}

predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	//TODO: your FOL formula should start with a forall
    !haveCommonKSubstringPred(k, str1, str2)
    //todo are we allowed to just negate the positive predicates?
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
	ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)
	ensures !haveCommonKSubstringPred(k,str1,str2) <==> haveNotCommonKSubstringPred(k,str1,str2)
{}
