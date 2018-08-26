---
layout: post
title: "Adding Dummy Variables"
author: "Meti"
categories: journal
tags: [r, fastDummies, data cleaning]
image: coffee.jpg
---

Earlier today, I was working with a super irritating dataset that contained one feature that was a string of categorical labels, containing repeats (as well as misspellings!). This is a short post showing how I used the `fastDummies` R package to clean the messy dataframe up and turn this annoying column into a collection of dummy variable columns. There are very likely easier ways to go about this, but I am taking the opportunity to document some other functions I've found useful along the way.

For this example, let's use a dataset `df` I invented that contains the id number and names of a bunch of people and the annoying column will be the different types of caffeinated beverage these people prefer. They are allowed to prefer more than one. (P.S. I used this [random name generator](https://www.behindthename.com/random/) to find names!)

```
library(tidyverse)
library(fastDummies)

id <- c(1, 2, 3, 4, 5, 6)
name <- c("Louise", "Suman", "Apurva", "Ariel", "Kunal", "Diana")
preferred_bev <- c("Coffee, Black Tea, Matcha", "Matcha", "Coffee, Coffee, Coffee", "Black Tea, Chai", "Chai, Coffee, Chai", "Black Tea")

df <- data.frame(id, name, preferred_bev) 
```

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> preferred_bev </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Louise </td>
   <td style="text-align:left;"> Coffee, Black Tea, Matcha </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Suman </td>
   <td style="text-align:left;"> Matcha </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Apurva </td>
   <td style="text-align:left;"> Coffee, Coffee, Coffee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Ariel </td>
   <td style="text-align:left;"> Black Tea, Chai </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Kunal </td>
   <td style="text-align:left;"> Chai, Coffee, Chai </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Diana </td>
   <td style="text-align:left;"> Black Tea </td>
  </tr>
</tbody>
</table>

In my dataframe, I had no idea if the repeats were meaningful. For now, let's assume they are not meaningful, but just the result of a few different instances of repeated data collection. 

First, we'll split the string in `preferred_bev` to turn it into a list, and then we can `unnest` the `preferred_bev` list to create a "tidy" dataframe with one row for each person and an instance of their preferred beverage. We'll also run a distinct to remove duplicates at this point. (Note that because we split the string on the ",", some of the features have leading whitespace. So, we also trim the whitespace before running a distinct, otherwise it will treat "Coffee" as a different feature from " Coffee").

```
df %>%
  rowwise() %>%
  mutate(preferred_bev = str_split(preferred_bev, ",")) %>%
  ungroup() %>%
  unnest(preferred_bev) %>%
  mutate(preferred_bev = trimws(preferred_bev)) %>%
  distinct
```

These operations create the dataframe:

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> preferred_bev </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Louise </td>
   <td style="text-align:left;"> Coffee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Louise </td>
   <td style="text-align:left;"> Black Tea </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Louise </td>
   <td style="text-align:left;"> Matcha </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Suman </td>
   <td style="text-align:left;"> Matcha </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Apurva </td>
   <td style="text-align:left;"> Coffee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Ariel </td>
   <td style="text-align:left;"> Black Tea </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Ariel </td>
   <td style="text-align:left;"> Chai </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Kunal </td>
   <td style="text-align:left;"> Chai </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Kunal </td>
   <td style="text-align:left;"> Coffee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Diana </td>
   <td style="text-align:left;"> Black Tea </td>
  </tr>
</tbody>
</table>

Finally, we'll use the `fastDummies` package to create dummy columns for the `preferred_bev` feature. I found it useful to also clean up the text in `preferred_bev` to change it to lowercase and replace spaces with underscores. Finally, I used the `summarize_all` function to reduce the dataframe so that we ended up with only one row per person.

```
df %>%
  rowwise() %>%
  mutate(preferred_bev = str_split(preferred_bev, ",")) %>%
  ungroup() %>%
  unnest(preferred_bev) %>%
  mutate(preferred_bev = trimws(preferred_bev)) %>%
  mutate(preferred_bev = tolower(preferred_bev)) %>%
  mutate(preferred_bev = gsub(" ", "_", preferred_bev)) %>%
  distinct %>%
  dummy_cols(select_columns="preferred_bev") %>%
  select(-preferred_bev) %>%
  group_by(id, name) %>%
  summarize_all(funs(sum)) %>%
  ungroup()
```

<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; overflow-x: scroll; width:100%; "><table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> name </th>
   <th style="text-align:right;"> preferred_bev_coffee </th>
   <th style="text-align:right;"> preferred_bev_black_tea </th>
   <th style="text-align:right;"> preferred_bev_matcha </th>
   <th style="text-align:right;"> preferred_bev_chai </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Louise </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Suman </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Apurva </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Ariel </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Kunal </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Diana </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table></div>








