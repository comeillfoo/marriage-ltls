// 1.5. "Я выйду замуж не более одного раза"

bool p = false;

proctype allowed_cases()
{
	if
		::( true ) ->
			p = false;
		::( true ) ->
			p = true;
			p = false;
		::( true ) ->
			p = false;
			p = true;
			p = false;
	fi
}

proctype forbidden_cases()
{
	if
		::( true ) ->
			p = false;
			p = true;
			p = false;
			p = true;
		::( true ) ->
			p = false;
			p = true;
			p = false;
			p = true;
			p = false;
		::( true ) ->
			p = false;
			p = true;
			p = false;
			p = true;
			p = false;
			p = true;
		::( true ) ->
			p = false;
			p = true;
			p = false;
			p = true;
			p = false;
			p = true;
			p = false;
	fi
}

init
{
#ifdef ENABLE_ALLOWED_CASES
	run allowed_cases();
#else
	run forbidden_cases();
#endif
}

#define SOLUTION1 ( ([]!p) || ((<>p) && ([](p -> (X[]!p)))) )
#define SOLUTION2 ( [](p -> (X[]!p)) )

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }

ltl  p2 {  ( SOLUTION1 ) }
ltl np2 { !( SOLUTION1 ) }
