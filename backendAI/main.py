# import spacy
#
# nlp = spacy.load('en_core_web_sm')
# doc = nlp("This is a red water bottle.")
#
# for token in doc:
#     if token.pos_ in ["NOUN", "ADJ"]:
#         print(token.text)  # Output: red, water, bottle

from transformers import pipeline

classifier = pipeline("zero-shot-classification")
description = "This is a shiny, red water bottle."
labels = ["water bottle", "phone", "red", "blue", "shiny"]

result = classifier(description, labels)
print(result)  # Returns ranked scores for each label
