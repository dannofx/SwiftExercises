# Company finder

It's a simple app that looks for company names using the [Clearbit web API](http://blog.clearbit.com/company-autocomplete-api/). The app shows how to perform async tasks to load the results and how to cancel those tasks if it's necessary. The tasks are performed meanwhile the user writes the company name, so the user can see how the results vary when the text is modified.

The app intentionally doesn't use `URLSession` since this by default perform the download task out of the main thread, and one of the purposes of the example is show how to take heavy tasks out of the main thread.
