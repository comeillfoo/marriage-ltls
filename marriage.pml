#define ASSERT_LTL(fun, condition) \
bool fun##_p = false \
int fun##_marriages = 0 \
active proctype fun##BrideProc() { \
    fun(fun##_p, fun##_marriages) \
} \
ltl fun##_cond { (condition) }

#define ASSERT_LTL_TRUE(fun, condition) ASSERT_LTL(fun, (condition))
#define ASSERT_LTL_FALSE(fun, condition) ASSERT_LTL(fun, (!(condition)))

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

/* "Может быть выйду, может быть нет" */
inline RandomBride(p, marriages) {
    do
    :: atomic { p = true; marriages++ }
    :: p = false
    od
}

#ifdef NEVER

#define NEVER_LTL(p) ([] !(p))
ASSERT_LTL_TRUE(NeverBride, NEVER_LTL(NeverBride_p))
#elif defined(EXACTLY_ONCE)
#define EXACTLY_ONCE_LTL(p) (<>(p && X ([] !p)))
// ASSERT_LTL_FALSE(NeverBride, EXACTLY_ONCE_LTL(NeverBride_p))
ASSERT_LTL_TRUE(ExactlyOnceBride, EXACTLY_ONCE_LTL(ExactlyOnceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanOnceBride, EXACTLY_ONCE_LTL(NoMoreThanOnceBride_p))
// ASSERT_LTL_FALSE(AtLeastOnceBride, EXACTLY_ONCE_LTL(AtLeastOnceBride_p))
// ASSERT_LTL_FALSE(ExactlyTwiceBride, EXACTLY_ONCE_LTL(ExactlyTwiceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanTwiceBride, EXACTLY_ONCE_LTL(NoMoreThanTwiceBride_p))
// ASSERT_LTL_FALSE(AtLeastTwiceBride, EXACTLY_ONCE_LTL(AtLeastTwiceBride_p))
#elif defined(NO_MORE_THAN_ONCE)

#define NO_MORE_THAN_ONCE_LTL(p) (([] !p) || (<> (p && X ([] !p))))
// ASSERT_LTL_FALSE(NeverBride, NO_MORE_THAN_ONCE_LTL(NeverBride_p))
// ASSERT_LTL_FALSE(ExactlyOnceBride, NO_MORE_THAN_ONCE_LTL(ExactlyOnceBride_p))
ASSERT_LTL_TRUE(NoMoreThanOnceBride, NO_MORE_THAN_ONCE_LTL(NoMoreThanOnceBride_p))
// ASSERT_LTL_FALSE(AtLeastOnceBride, NO_MORE_THAN_ONCE_LTL(AtLeastOnceBride_p))
// ASSERT_LTL_FALSE(ExactlyTwiceBride, NO_MORE_THAN_ONCE_LTL(ExactlyTwiceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanTwiceBride, NO_MORE_THAN_ONCE_LTL(NoMoreThanTwiceBride_p))
// ASSERT_LTL_FALSE(AtLeastTwiceBride, NO_MORE_THAN_ONCE_LTL(AtLeastTwiceBride_p))
#elif defined(AT_LEAST_ONCE)

#define AT_LEAST_ONCE_LTL(p) (<> p)
// ASSERT_LTL_FALSE(NeverBride, AT_LEAST_ONCE_LTL(NeverBride_p))
// ASSERT_LTL_FALSE(ExactlyOnceBride, AT_LEAST_ONCE_LTL(ExactlyOnceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanOnceBride, AT_LEAST_ONCE_LTL(NoMoreThanOnceBride_p))
ASSERT_LTL_TRUE(AtLeastOnceBride, AT_LEAST_ONCE_LTL(AtLeastOnceBride_p))
// ASSERT_LTL_FALSE(ExactlyTwiceBride, AT_LEAST_ONCE_LTL(ExactlyTwiceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanTwiceBride, AT_LEAST_ONCE_LTL(NoMoreThanTwiceBride_p))
// ASSERT_LTL_FALSE(AtLeastTwiceBride, AT_LEAST_ONCE_LTL(AtLeastTwiceBride_p))
#elif defined(EXACTLY_TWICE)

#define EXACTLY_TWICE_LTL(p) ([] !p)
// ASSERT_LTL_FALSE(NeverBride, EXACTLY_TWICE_LTL(NeverBride_p))
// ASSERT_LTL_FALSE(ExactlyOnceBride, EXACTLY_TWICE_LTL(ExactlyOnceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanOnceBride, EXACTLY_TWICE_LTL(NoMoreThanOnceBride_p))
// ASSERT_LTL_FALSE(AtLeastOnceBride, EXACTLY_TWICE_LTL(AtLeastOnceBride_p))
ASSERT_LTL_TRUE(ExactlyTwiceBride, EXACTLY_TWICE_LTL(ExactlyTwiceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanTwiceBride, EXACTLY_TWICE_LTL(NoMoreThanTwiceBride_p))
// ASSERT_LTL_FALSE(AtLeastTwiceBride, EXACTLY_TWICE_LTL(AtLeastTwiceBride_p))
#elif defined(NO_MORE_THAN_TWICE)
// TODO: ltl
#elif defined(AT_LEAST_TWICE)

#define AT_LEAST_TWICE_LTL(p) (! (([] !p) || (p -> ([] !p))))
// ASSERT_LTL_FALSE(NeverBride, AT_LEAST_TWICE_LTL(NeverBride_p))
// ASSERT_LTL_FALSE(ExactlyOnceBride, AT_LEAST_TWICE_LTL(ExactlyOnceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanOnceBride, AT_LEAST_TWICE_LTL(NoMoreThanOnceBride_p))
// ASSERT_LTL_FALSE(AtLeastOnceBride, AT_LEAST_TWICE_LTL(AtLeastOnceBride_p))
// ASSERT_LTL_FALSE(ExactlyTwiceBride, AT_LEAST_TWICE_LTL(ExactlyTwiceBride_p))
// ASSERT_LTL_FALSE(NoMoreThanTwiceBride, AT_LEAST_TWICE_LTL(NoMoreThanTwiceBride_p))
ASSERT_LTL_TRUE(AtLeastTwiceBride, AT_LEAST_TWICE_LTL(AtLeastTwiceBride_p))
#else
#error "Unknown case"
#endif
