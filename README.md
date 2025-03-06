
# Foundations of Business Analytics

<!-- badges: start -->
<!-- badges: end -->

View the currently compiled version of the book [here](https://unimelb-cmce-10002.github.io/fba-book/).

## Course Schedule and Quarto Book Alignment

This table aligns the course schedule with the corresponding parts and chapters in the Quarto book.

| **Week**  | **Topic**                                           | **Quarto Book Part**                     | **QMD File**                           |
|----------|---------------------------------------------------|-----------------------------------------|----------------------------------------|
| 1        | Intro / Why Business Analytics                    | Foundations                              | `foundations/what_is_business_analytics.qmd` |
| 2        | How to do Business Analytics                      | Foundations                              | `foundations/how_to_do_business_analytics.qmd` |
| 3        | Importing and visualizing data                    | Getting Our First Insights from Data     | `insights/data_visualisation.qmd`     |
| 4        | Wrangling with data: Essentials                   | Getting Our First Insights from Data     | `insights/data_manipulation.qmd`      |
| 5        | Wrangling with data: Next Steps                   | Getting Our First Insights from Data     | `insights/data_analysis.qmd`          |
| 6        | Getting Data                                      | Finding and Storing Data                 | `data_management/data_collection.qmd` |
| 7        | Storing and Retrieving Data                       | Finding and Storing Data                 | `data_management/data_storage.qmd`    |
| 8        | Describing and explaining variation in data over time | Extracting Deeper Insights from Data | `advanced_analytics/data_variation.qmd` |
| 9        | Describing and explaining variation in data across and within groups | Extracting Deeper Insights from Data | `advanced_analytics/descriptive_analytics.qmd` |
| 10       | Generating Data and Causality                     | Extracting Deeper Insights from Data     | `advanced_analytics/causal_analytics.qmd` |
| 11       | Forming and Evaluating Predictions                | Extracting Deeper Insights from Data     | `advanced_analytics/predictive_analytics.qmd` |
| 12       | Ethics, Governance & Analytics & Wrap Up         | Ethics and Privacy                       | `ethics_privacy/ethics.qmd`            |
|          |                                                 | Ethics and Privacy                       | `ethics_privacy/privacy.qmd`           |
|          |                                                 | Conclusion                               | `conclusion/conclusion.qmd`            |

## Data Storage and Usage

- Raw data and scripts used for preparing teaching materials are stored in the `data-raw/` directory.
- The data used in the Quarto book is stored separately in the `data/` directory.

## Building the Quarto Book Locally

### **Prerequisites**
Ensure you have the following installed on your machine:

1. **Quarto** – Download and install it from [quarto.org](https://quarto.org/)
2. **R and RStudio** – Install from [CRAN](https://cran.r-project.org/)
3. **Required R Packages** – Install `quarto`, `tidyverse`, and `knitr` using R:
   
   ```r
   install.packages(c("quarto", "tidyverse", "knitr"))
   ```

### **Steps to Build the Book**

#### 1. **Clone the Repository**  
If you haven’t already, clone the repository containing the Quarto book:

```sh
git clone <repository-url>
cd <repository-directory>
```

#### 2. **Open the Project in RStudio**
Launch RStudio and open the project folder where the Quarto book files are located.

#### 3. **Render the Book**  
Run the following command in the RStudio terminal:

```sh
quarto render
```

This will generate the book in the `_book/` directory.

#### 4. **Preview the Book Locally**  
To serve the book locally and view it in your browser:

```sh
quarto preview
```

This will start a local web server and open the book in your default browser. Any changes you make will be automatically reflected upon saving.

### **Publishing the Book**
To publish the book on GitHub Pages:

```sh
quarto publish gh-pages
```

