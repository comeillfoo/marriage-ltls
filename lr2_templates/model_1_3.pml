// 1.3. "Я выйду замуж точно два раза"

bool p = false;

proctype allowed_cases()
{
	if
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
	fi
}

proctype forbidden_cases()
{
	if
		::( true ) ->
			p = false;
		::( true ) ->
			p = true;
		::( true ) ->
			p = false;
			p = true;
		::( true ) ->
			p = false;
			p = true;
			p = false;
		::( true ) ->
			p = false;
			p = true;
			p = true;
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

#define SUBSOLUTION_A ( <>(p && (X<>p)) )
#define SUBSOLUTION_B ( [](p -> (X[](p -> (X[]!p)))) )
#define SOLUTION1 ( SUBSOLUTION_A && SUBSOLUTION_B )

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }
