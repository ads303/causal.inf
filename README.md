# causal.inf
R package for backdoor criterion causal effect analysis 

The backdoor adjustment method is a fundamental concept in causal inference.

The backdoor adjustment method involves controlling for confounding variables by conditioning on them in order to eliminate their effects on the causal relationship between the treatment and outcome variables. This can be achieved using various methods, such as regression or propensity score matching.

<img width="1103" alt="image" src="https://user-images.githubusercontent.com/108133717/221062053-6ea6a5be-82ec-4d16-9e14-a791beea5551.png">

(excerpted from a [CMU Statistics Lecture](https://www.stat.cmu.edu/~cshalizi/350/lectures/31/lecture-31.pdf))

In this package, I use a linear regression model to estimate the conditional distribution of an outcome variable given input causal variables and confounding variables. By controlling for the confounding variables in this way, we are able to estimate the causal effect of the input variables on the outcome variable while minimizing confounding bias. 

The `estimate_causal_effects` function returns a list of the estimated causal effects of each causal variable on the effect variable. Each element of the list corresponds to a single causal variable and contains the estimated causal effect, along with its standard error, 95% confidence interval, and p-value.

For example, if you have a causal variable X1 and an effect variable Y, running estimate_causal_effects will return a list with a single element. This element will contain the estimated causal effect of X1 on Y, along with other information such as the standard error, 95% confidence interval, and p-value.

You can use the estimated causal effects to make inferences about the causal relationships between variables in your data. If the p-value is less than 0.05 (or whatever you choose to set as your alpha value for the purposes of your task), you can reject the null hypothesis that there is no causal effect and conclude that there is evidence of a causal relationship between the causal variable and the effect variable. 

When using the `causal.inf` package, it's important to keep in mind that additional methods and analyses may be needed to fully understand the causal relationships in your data. This tool is just meant to be an introductory, exploratory guide to your data. 

If you have any concerns, please email me at mailto:ads303@pitt.edu 

