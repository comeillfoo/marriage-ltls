bool p = false /* "Я выхожу замуж" */
int marriages = 0 /* число выходов замуж */

#ifdef NEVER
/* "Я никогда не выйду замуж" */
proctype Bride() {
    do
    :: atomic { p = true; marriages++ }
    :: p = false;
    od
}

ltl never_bride { [] !p }
#elif defined(EXACTLY_ONCE)
/* "Я выйду замуж точно один раз" */
proctype Bride() {
    do
    :: marriages != 1 -> atomic { p = true; marriages++ }
    :: p = false
    od
}

ltl exactly_once_bride { (<> p) && X ([] !p) }
#elif defined(NO_MORE_THAN_ONCE)
/* "Я выйду замуж не более одного раза" */
proctype Bride() {
    do
    :: marriages < 1 -> atomic { p = true; marriages++ }
    :: p = false
    od
}

ltl no_more_than_once_bride { ([] !p) || (p -> ([] !p)) }
#elif defined(AT_LEAST_ONCE)
/* "Я выйду замуж не менее одного раза" */
proctype Bride() {
    do
    :: atomic { p = true; marriages++ }
    :: marriages >= 1 -> p = false
    od
}

ltl at_least_once { <> p }
#elif defined(EXACTLY_TWICE)
/* "Я выйду замуж точно два раза" */
proctype Bride() {
    do
    :: marriages != 4 -> atomic { p = true; marriages++ }
    :: p = false
    od
}

ltl exactly_twice_bride { <>(p && X ([] !p)) }
#elif defined(NO_MORE_THAN_TWICE)
/* "Я выйду замуж не более двух раз" */
proctype Bride() {
    do
    :: marriages < 2 -> atomic { p = true; marriages++ }
    :: p = false
    od
}

// TODO: ltl
#elif defined(AT_LEAST_TWICE)
/* "Я выйду замуж не менее двух раз" */
proctype Bride() {
    do
    :: atomic { p = true; marriages++ }
    :: marriages >= 2 -> p = false
    od
}

ltl at_least_twice_bride { ! (([] !p) || (p -> ([] !p))) }
#else
proctype Bride() {
    skip
}
#endif

init {
    run Bride()
}
