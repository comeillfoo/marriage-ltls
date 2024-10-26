// 2.1. a может случиться только во время b

bool a = false;
bool b = false;

proctype allowed_cases()
{
	if
		::( true ) ->
			a = false;
			b = false;
		::( true ) ->
			b = true;
			b = false;
		::( true ) ->
			b = true;
			a = true;
			a = false;
			b = false;
		::( true ) ->
			b = true;
			b = false;
			b = true;
			a = true;
			a = false;
			b = false;
	fi
}

proctype forbidden_cases()
{
	if
		::( true ) ->
			a = true;
			b = true;
			b = false;
			a = false;
		::( true ) ->
			b = true;
			a = true;
			b = false;
			a = false;
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

#define SOLUTION1 ( ((!a) W (b)) )

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }
