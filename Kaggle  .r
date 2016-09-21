# Import the training set: train
train_url <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv"
train <- read.csv(train_url)
  
# Import the testing set: test
test_url <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"
test <- read.csv(test_url)
  
# Print train and test to the console
print(train );
print(test)
----------------------
# Create the column child, and indicate whether child or no child
train$Child <- NA
train$Child[train$Age<18] <- 1
train$Child[train$Age >=18] <- 0

# Two-way comparison
prop.table(table(train$Child, train$Survived), 1)
-----------------
str(train)
str(test)

# Create the column child, and indicate whether child or no child
train$Child <- NA
train$Child[train$Age<18] <- 1
train$Child[train$Age >=18] <- 0

# Two-way comparison
prop.table(table(train$Child, train$Survived), 1)
--------------
# Load in the R package  
library(rpart)
# Build the decision tree
my_tree_two <- rpart(Survived~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

# Visualize the decision tree using plot() and text()
plot(my_tree_two)
text(my_tree_two)

# Load in the packages to build a fancy plot
library(rattle)
library (rpart.plot)
library  (RColorBrewer)
# Time to plot your fancy tree

fancyRpartPlot(my_tree_two)
----------------------------
# Make predictions on the test set
my_prediction <- predict(my_tree_two, test, type = "class")

# Finish the data.frame() call
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Use nrow() on my_solution

nrow(my_solution)
# Finish the write.csv() call
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)


my_tree_three <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
                     data = train, method = "class", control = rpart.control(minsplit = 50, cp = 0))
  
# Visualize my_tree_three and reenginering
fancyRpartPlot(my_tree_three)
# Create train_two
train_two <- train
train_two$family_size <- train_two$SibSp + train_two$Parch + 1

# Finish the command
my_tree_four <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked +family_size, 
                      data = train_two, method = "class")

# Visualize your new decision tree
fancyRpartPlot(my_tree_four)
