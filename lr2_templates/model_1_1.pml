// 1.1. "Я выйду замуж не менее двух раз"

bool p = false;

proctype allowed_cases()
{
	if
		::( true ) ->
			p = true;
		::( true ) ->
			p = false;
			p = true;
		::( true ) ->
			p = true;
			p = true;
			p = false;
		::( true ) ->
			p = true;
			p = false;
			p = true;
			p = false;
		::( true ) ->
			p = false;
			p = true;
			p = true;
			p = false;
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

proctype forbidden_cases()
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

init
{
#ifdef ENABLE_ALLOWED_CASES
	run allowed_cases();
#else
	run forbidden_cases();
#endif
}

#define SOLUTION1 (  )

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }
