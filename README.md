# causal.inf
R package for backdoor criterion causal effect analysis 

The backdoor adjustment method is a fundamental concept in causal inference.

The backdoor adjustment method involves controlling for confounding variables by conditioning on them in order to eliminate their effects on the causal relationship between the treatment and outcome variables. This can be achieved using various methods, such as regression or propensity score matching.

**If we want to know the effect of X on Y and have a set of variables S as the
control, then S satisfies the back-door criterion if (i) S blocks every path from
X to Y that has an arrow into X (“blocks the back door”), and (ii) no node in
S is a descendant of X.** Then:

$Pr$ $(Y |do(X = x))$ $=$ $\sum_{s}$
$Pr (Y |X = x, S = s)$ $Pr (S = s)$

Notice that all the items on the right-hand side are observational conditional
probabilities, not counterfactuals.

(excerpted from a [CMU Statistics Lecture](https://www.stat.cmu.edu/~cshalizi/350/lectures/31/lecture-31.pdf) on Causal Inference)

In this package, I use a linear regression model to estimate the conditional distribution of an outcome variable given input causal variables and confounding variables. By controlling for the confounding variables in this way, we are able to estimate the causal effect of the input variables on the outcome variable while minimizing confounding bias. This is primarily the utility of the `estimate_causal_effect` in the package. 

The `estimate_causal_effects` function, on the other hand, is a less-specific estimator that returns a list of the estimated causal effects of each causal variable on the effect variable. Each element of the list corresponds to a single causal variable and contains the estimated causal effect, along with its standard error, 95% confidence interval, and p-value.

For example, if you have a causal variable X1 and an effect variable Y, running estimate_causal_effects will return a list with a single element. This element will contain the estimated causal effect of X1 on Y, along with other information such as the standard error, 95% confidence interval, and p-value.

You can use the estimated causal effects to make inferences about the causal relationships between variables in your data. If the p-value is less than 0.05 (or whatever you choose to set as your alpha value for the purposes of your task), you can reject the null hypothesis that there is no causal effect and conclude that there is evidence of a causal relationship between the causal variable and the effect variable. 

When using the `causal.inf` package, it's important to keep in mind that additional methods and analyses may be needed to fully understand the causal relationships in your data. This tool is just meant to be an introductory, exploratory guide to your data. 

If you have any inquiries or concerns, please email me at [ads303@pitt.edu](mailto:ads303@pitt.edu)

