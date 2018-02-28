# Company Finder

It's a simple app that looks for company names using the [Clearbit web API](http://blog.clearbit.com/company-autocomplete-api/). The app shows how to perform async tasks to load the results and how to cancel those tasks if it's necessary. The tasks are performed meanwhile the user writes the company name, so the user can see how the results change when the text is modified.

The app intentionally uses `DispatchWorkItem` instead of `URLSession`, because one of the goals of the app is to use a specific dispatch queue to download and parse the `JSON` content.  

![Preview](img/autosuggest.gif)
