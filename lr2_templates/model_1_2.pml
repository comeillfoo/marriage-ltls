// 1.2. "Я выйду замуж не более двух раз"

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
		::( true ) ->
			p = true;
			p = false;
			p = true;
			p = false;
		::( true ) ->
			p = true;
			p = true;
			p = false;
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
			p = true;
		::( true ) ->
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
	run allowed_cases();
	//run forbidden_cases();
}

#define SOLUTION1 (  )

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }

ltl  p2 {  ( SOLUTION2 ) }
ltl np2 { !( SOLUTION2 ) }
