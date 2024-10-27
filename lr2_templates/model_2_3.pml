// 2.3. a обязательно случится, но это произойдет после того как какое-то время будет истинно b

bool a = false;
bool b = false;

proctype allowed_cases()
{
	if
		::( true ) ->
			b = true;
			b = false;
			a = true;
			a = false;
		::( true ) ->
			b = true;
			a = true;
			b = false;
			a = false;
	fi
}

proctype forbidden_cases()
{
	if
		::( true ) ->
			a = false;
			b = false;
		::( true ) ->
			a = true;
			a = false;
		::( true ) ->
			b = true;
			b = false;
		::( true ) ->
			a = true;
			b = true;
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

#define SOLUTION1 ( ((<> b) U (<> a)) && ((!a) U (b)) )

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }
