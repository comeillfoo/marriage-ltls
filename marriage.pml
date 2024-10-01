bool p = false /* "Я выхожу замуж" */
int marriages = 0 /* число выходов замуж */

/* "Я никогда не выйду замуж" */
proctype NeverBride() {
    do
    :: p = false;
    od
}

/* "Я выйду замуж точно один раз" */
proctype OnceBride() {
    do
    :: marriages != 1 -> p = true; marriages++
    :: p = false
    od
}

/* "Я выйду замуж не более одного раза" */
proctype NoMoreThanOnceBride() {
    do
    :: marriages <= 1 -> p = true; marriages++
    :: p = false
    od
}

/* "Я выйду замуж не менее одного раза" */
proctype AtLeastOnceBride() {
    do
    :: p = true; marriages++
    :: marriages >= 1 -> p = false
    od
}

/* "Я выйду замуж точно два раза" */
proctype ExactlyTwiceBride() {
    do
    :: marriages != 2 -> p = true; marriages++
    :: p = false
    od
}

/* "Я выйду замуж не более двух раз" */
proctype NoMoreThanTwiceBride() {
    do
    :: marriages <= 2 -> p = true; marriages++
    :: p = false
    od
}

/* "Я выйду замуж не менее двух раз" */
proctype AtLeastTwiceBride() {
    do
    :: p = true; marriages++
    :: marriages >= 2 -> p = false
    od
}

init {
    run NeverBride()
    // run OnceBride()
    // run NoMoreThanOnceBride()
    // run AtLeastOnceBride()
    // run ExactlyTwiceBride()
    // run NoMoreThanTwiceBride()
    // run AtLeastTwiceBride()
}

ltl never_bride { [] !p }
