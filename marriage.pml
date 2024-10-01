bool p = false /* "Я выхожу замуж" */
int marriages = 0 /* число выходов замуж */

active proctype Bride() {
    do
    :: p = true; marriages++
    :: p = false
    od
}
