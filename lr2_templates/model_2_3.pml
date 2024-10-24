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
	run allowed_cases();
	//run forbidden_cases();
}

#define SOLUTION1 (  )

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }
