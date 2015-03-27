(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


BeginPackage["CellsToTeX`Tests`Unit`annotationRulesToBoxRules`", {"MUnit`"}]


Get["CellsToTeX`"]

Get["CellsToTeX`Tests`Utilities`"]

$ContextPath =
	Join[
		{
			"SyntaxAnnotations`",
			"CellsToTeX`Configuration`",
			"CellsToTeX`Internal`"
		},
		$ContextPath
	]


(* ::Section:: *)
(*Tests*)


TestMatch[
	{"type" -> {"key", "comand"}} // annotationRulesToBoxRules
	,
	{
		SyntaxBox[
			Verbatim[Pattern][boxes_, Verbatim[_]], "type", Verbatim[___]
		] :>
			"\\comand{" <> makeString[boxes_] <> "}"
	}
	,
	TestID -> "1 rule"
]

TestMatch[
	{"type1" -> {"key1", "comand1"}, "type2" -> {"key2", "comand2"}} //
		annotationRulesToBoxRules
	,
	{
		SyntaxBox[
			Verbatim[Pattern][boxes_, Verbatim[_]], "type1", Verbatim[___]
		] :>
			"\\comand1{" <> makeString[boxes_] <> "}"
		,
		SyntaxBox[
			Verbatim[Pattern][boxes_, Verbatim[_]], "type2", Verbatim[___]
		] :>
			"\\comand2{" <> makeString[boxes_] <> "}"
	}
	,
	TestID -> "2 rules"
]


(* ::Subsection:: *)
(*Incorrect arguments*)


Module[{testArg},
	Test[
		Catch[annotationRulesToBoxRules[testArg];, _, HoldComplete]
		,
		expectedIncorrectArgsError[annotationRulesToBoxRules[testArg]]
		,
		TestID -> "Incorrect arguments"
	]
]


(* ::Section:: *)
(*TearDown*)


Unprotect["`*"]
Quiet[Remove["`*"], {Remove::rmnsm}]


EndPackage[]
$ContextPath = Rest[$ContextPath]