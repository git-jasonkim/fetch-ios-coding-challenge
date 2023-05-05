# fetch-ios-coding-challenge

Swift application built programmatically using MVVM and Auto Layout.

![](app_preview.gif)

MainController
>-Root viewcontroller

MealsController+CV
>-lists of desserts\
-vm: MealsViewModel\
-subview of MainController

MealDetailsController+CV
>-detail view that includes name, ingredients/measurements, and instructions\
-vm: MealDetailsViewModel\
-pushed viewcontroller when selecting item from MealsController

API
>-https://themealdb.com/api/json/v1/1/filter.php?c=Dessert \
-https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)

UIImageView Extension
>-fetch image
-cache
