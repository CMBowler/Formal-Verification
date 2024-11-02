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
    isPrefixPred(sub, str) || ((|sub| <= |str|) && (exists i :: ((0 <= i < |str|) && isPrefixPred(sub, str[i..]))))
}

predicate isNotSubstringPred(sub:string, str:string)
{
	//TODO: your FOL formula should start with a forall
    // forall k :: k == 0 ==> !isSubstringPred(sub, str)
    !isSubstringPred(sub, str)
    //todo: really don't know how they want a forall here
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
    //TODO



    isSubstringPred

    (exists i ::
}

// predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)
// {
// 	//TODO: your FOL formula should start with a forall
// }

// Sanity check: Dafny should be able to automatically prove the following lemma
// lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
// 	ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)
// 	ensures !haveCommonKSubstringPred(k,str1,str2) <==> haveNotCommonKSubstringPred(k,str1,str2)
// {}
