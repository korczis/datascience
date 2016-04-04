require("data.table")

downloadFoodFactsFields <- function(url = "http://world.openfoodfacts.org/data/data-fields.txt", file = "data-fields.txt") {
  download.file(url, destfile = file)
}

downloadFoodFactsData <- function(url = "http://world.openfoodfacts.org/data/en.openfoodfacts.org.products.csv", file = "food-facts.csv") {
  download.file(url, destfile = file)
}

loadFoodFacts <- function(file = "food-facts.csv") {
  fread(file)
}
