#define ASSERT_LTL(fun, condition) \
bool p = false \
int marriages = 0 \
active proctype fun##BrideProc() { \
    fun(p, marriages) \
} \
ltl fun##_cond { (condition) }


/* "Я никогда не выйду замуж" */
inline NeverBride(p, marriages) {
    do
    :: p = false;
    od
}

/* "Я выйду замуж точно один раз" */
inline ExactlyOnceBride(p, marriages) {
    int pt = 100, pf = 100;
    do
    :: pt > 0 -> atomic { p = true; marriages++; pt = 0; pf = 100 }
    :: pf > 0 -> atomic { p = false; pf-- }
    :: else -> break
    od;
    assert (marriages == 1)
}

/* "Я выйду замуж не более одного раза" */
inline NoMoreThanOnceBride(p, marriages) {
    do
    :: marriages < 1 -> atomic { p = true; marriages++ }
    :: p = false
    od
}

/* "Я выйду замуж не менее одного раза" */
inline AtLeastOnceBride(p, marriages) {
    int pt = 100, pf = 100;
    do
    :: pt > 0 -> atomic { p = true; marriages++; pt-- }
    :: pf > 0 -> atomic { p = false; pf-- }
    :: else -> break
    od;
    assert marriages >= 1
}

/* "Я выйду замуж точно два раза" */
inline ExactlyTwiceBride(p, marriages) {
    do
    :: marriages != 2 -> atomic { p = true; marriages++ }
    :: p = false
    od
}

/* "Я выйду замуж не более двух раз" */
inline NoMoreThanTwiceBride(p, marriages) {
    do
    :: marriages < 2 -> atomic { p = true; marriages++ }
    :: p = false
    od
}

/* "Я выйду замуж не менее двух раз" */
inline AtLeastTwiceBride(p, marriages) {
    do
    :: atomic { p = true; marriages++ }
    :: marriages >= 2 -> p = false
    od
}

#ifdef NEVER
// My variant:
#define CONDITION ([] !(p))
ASSERT_LTL(NeverBride, CONDITION)

#elif defined(EXACTLY_ONCE)
// My variant:
#define CONDITION (<>(p && X ([] !p)))
// Book variant:
// #define CONDITION ((<>p) && ([](p -> X ([] !p))))
ASSERT_LTL(ExactlyOnceBride, CONDITION)

#elif defined(NO_MORE_THAN_ONCE)
// My variant:
#define CONDITION (([] !p) || (<> (p && X ([] !p))))
// Book variant:
// #define CONDITION ([](p -> X ([] !p)))
ASSERT_LTL(NoMoreThanOnceBride, CONDITION)

#elif defined(AT_LEAST_ONCE)
#define CONDITION (<> p)
ASSERT_LTL(AtLeastOnceBride, CONDITION)

#elif defined(EXACTLY_TWICE)
// My variant:
#define CONDITION ((<> p) && X (<>(p && (X([] !p)))))
// Spin-complaint variant:
// #define CONDITION ((<> p) -> X (<>(p && (X([] !p)))))
ASSERT_LTL(ExactlyTwiceBride, CONDITION)

#elif defined(NO_MORE_THAN_TWICE)
// My variant:
#define CONDITION (([] !p) || (<> (p && X ([] !p))) || ((<> p) && X (<>(p && (X([] !p))))))
ASSERT_LTL(NoMoreThanTwiceBride, CONDITION)

#elif defined(AT_LEAST_TWICE)
// My variant (negation of no more than once):
#define CONDITION (!(([] !p) || (<> (p && X ([] !p)))))
ASSERT_LTL(AtLeastTwiceBride, CONDITION)

#else
#error "Unknown verification target"
#endif
