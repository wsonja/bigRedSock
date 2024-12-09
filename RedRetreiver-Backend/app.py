import json

from db import db
from flask import Flask,request
from db import Request,User, Item 
import image_generate
import image_store

import string
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import faiss
import nltk
nltk.download('stopwords')
nltk.download('wordnet')
nltk.download('punkt')
from nltk.corpus import stopwords, wordnet
from nltk.stem import WordNetLemmatizer

# define db filename
app = Flask(__name__)
db_filename = "cms.db"

# setup config
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

# initialize app
db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data,code=200):
    return json.dumps(data),code

def failure_response(message,code=404):
    return json.dumps({"error":message}),code

# your routes here
# User thingies
# How to authenticate 
@app.route("/api/users/", methods=["POST"])
def create_user():
    """
    Endpoint to create a new user.
    """
    body = json.loads(request.data)
    
    name = body.get("name")
    email = body.get("email")
    pfpURL = body.get("pfp_URL")
    
    if not name or not email:
        return failure_response("Missing required fields: 'name' or 'email'", 400)
    
    if User.query.filter_by(name=name).first():
        return failure_response("User with this netid already exists!", 400)
    
    new_user = User(name=name, email=email, pfpURL = pfpURL)
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(), 201)


@app.route("/api/users/", methods=["GET"])
def get_all_users():
    """
    Endpoint to retrieve all users.
    """
    users = User.query.all()
    return success_response({"users": [user.serialize() for user in users]})

@app.route("/api/leaderboard/", methods=["GET"])
def leaderboard():
    """
    Endpoint to retrieve the leaderboard of users by points.
    """
    users = User.query.order_by(User.points.desc()).limit(10).all()
    leaderboard = [{"name": user.name, "points": user.points} for user in users]
    return success_response({"leaderboard": leaderboard})


@app.route("/api/users/<int:user_id>/", methods=["GET"])
def get_user(user_id):
    """
    Endpoint to retrieve a single user by their ID.
    """
    user = User.query.filter_by(id=user_id).first()
    if not user:
        return failure_response("User Not Found!", 404)
    return success_response(user.serialize())


@app.route("/api/users/<int:user_id>/", methods=["PUT"])
def update_points(user_id):
    """
    Endpoint to update user points
    """
    body = request.get_json()
    points = body.get("points")
    pfpURL = body.get("pfpURL")

    if points is None:
        return failure_response("Missing Points!", 400)

    user = User.query.filter_by(id=user_id).first()
    if not user:
        return failure_response("User not found!", 404)

    user.points = points
    db.session.commit()

    return success_response(user.serialize())

@app.route("/api/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    """
    Endpoint to delete a user by their ID.
    """
    user = User.query.filter_by(id=user_id).first()
    if not user:
        return failure_response("User Not Found!", 404)
    
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())


# Requests thingies
@app.route("/api/requests/",methods=["GET"])
def get_requests():
    """
    Endpoint for getting all requests
    """
    return success_response({"requests":[r.serialize() for r in Request.query.all()]})


@app.route("/api/requests/",methods=["POST"])
def create_request():
    """
    Endpoint for creating a new create_request
    """
    body = json.loads(request.data)

    new_request = Request(
        name = body.get('name'),
        user_id = body.get('user_id'),
        status = body.get('status'),
        description = body.get('description'),
        location = body.get('location'),
        email = body.get('email'),
        phone = body.get('phone'),
        date = body.get('date')
    )
    db.session.add(new_request)
    db.session.commit()
    return success_response(new_request.serialize(),201)


@app.route("/api/requests/<int:request_id>/",methods=["GET"])
def get_request(request_id):
    """
    Endpoint for getting a request by id
    """
    request = Request.query.filter_by(id=request_id).first()
    if request is None:
        return failure_response("Request not found!")
    return success_response(request.serialize())


@app.route("/api/requests/<int:request_id>/",methods=["POST"])
def update_request(request_id):
    """
    Endpoint for updating a request by id
    """
    body = json.loads(request.data)
    request2 = Request.query.filter_by(id=request_id).first()
    if request2 is None:
        return failure_response("Request not found!")
    request2.name = body.get('name')
    request2.status = body.get('status')
    request2.description = body.get('description')
    request2.location = body.get('location')
    db.session.commit()
    return success_response(request2.serialize())


@app.route("/api/requests/<int:request_id>/",methods=["DELETE"])
def delete_request(request_id):
    """
    Endpoint for deleting a request by id
    """
    request = Request.query.filter_by(id=request_id).first()
    if request is None:
        return failure_response("Request not found!")
    db.session.delete(request)
    db.session.commit()
    return success_response(request.serialize())

# Items Thingies
@app.route("/api/items/",methods=["GET"])
def get_items():
    """
    Endpoint for getting all items
    """
    return success_response({"items": [item.serialize() for item in Item.query.all()]})


@app.route("/api/items/<int:item_id>/", methods=["GET"])
def get_item(item_id):
    """
    Endpoint for getting a specific item by its ID.
    """
    item = Item.query.filter_by(id=item_id).first() 
    if not item:
        return failure_response("Request Not Found!")
    return success_response(item.serialize())


@app.route("/api/items/", methods=["POST"])
def create_item():
    """
    Endpoint to add a new item.
    """
    body = json.loads(request.data)
    
    if body.get("description") == "":
        imageb64 = body.get('image')
        caption = image_generate.analyze_base64_image(imageb64)
    else:
        caption = body.get('description')
    
    title = body.get("title")
    description = caption
    location = body.get("location")
    status = body.get("status", "unclaimed")
    image = body.get("image")
    finder_id = body.get("finder_id")

    email = body.get("email")
    phone = body.get("phone")
    date = body.get("date")
    

    preprocessed_description = preprocess_text(caption)

    new_item = Item(
        title=body.get("title"), 
        description=description,
        location=body.get("location"),
        status=body.get("status", "unclaimed"),
        preprocessed_description=preprocessed_description,
        image=body.get("image"),
        finder_id=body.get("finder_id"),
        email=body.get("email"),
        phone=body.get("phone"),
        date=body.get("date"),
    )
    db.session.add(new_item)
    db.session.commit()
    
    return success_response(new_item.serialize(), 201)


@app.route("/api/items/<int:item_id>/", methods=["POST"])
def update_item(item_id):
    """
    Endpoint to update an existing item.
    """
    body = json.loads(request.data)
    
    item = Item.query.filter_by(id=item_id).first()
    if not item:
        return failure_response("Request not found!")
    
    item.title = body.get("title", item.title)
    item.description = body.get("description", item.description)
    item.status = body.get("status", item.status)
    item.location = body.get("location", item.location)
    
    if "description" in body:
        item.preprocessed_description = (preprocess_text(item.description))

    db.session.commit()
    return success_response(item.serialize())


@app.route("/api/items/<int:item_id>/", methods=["DELETE"])
def delete_item(item_id):
    """
    Endpoint to delete an item by its ID.
    """
    item = Item.query.filter_by(id=item_id).first()
    if not item:
        return failure_response("Request not found!")
    
    db.session.delete(item)
    db.session.commit()
    return success_response(item.serialize())


# Similarity matching 
def preprocess_text(text):
    """
    Removes unnecessary texts, punctuations, and case to make it more efficient
    """
    # remove punctuation and lowercase
    text = text.lower().translate(str.maketrans('', '', string.punctuation))
    # remove stopwords and lemmatize
    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()
    words = text.split()
    words = [lemmatizer.lemmatize(word) for word in words if word not in stop_words]
    return " ".join(words)


@app.route("/api/requests/<int:request_id>/similar_items/", methods=["POST"])
def find_similar_items(request_id):
    """
    Endpoint to find similar items based on a specific request ID.
    """
    request_obj = Request.query.filter_by(id=request_id).first()
    if not request_obj:
        return failure_response("Request not found!", 404)

    items = Item.query.all()
    if not items:
        return failure_response("No items found in the database!", 404)

    unique_items = list({item.preprocessed_description: item for item in items}.values())
    preprocessed_items = [item.preprocessed_description for item in unique_items]
    item_descriptions = [item.description for item in unique_items]

    # Build FAISS index
    vectorizer = TfidfVectorizer()
    item_vectors = vectorizer.fit_transform(preprocessed_items).toarray()

    dimension = item_vectors.shape[1]
    index = faiss.IndexFlatL2(dimension)
    index.add(np.array(item_vectors, dtype="float32"))

    query_preprocessed = preprocess_text(request_obj.description)
    query_vector = vectorizer.transform([query_preprocessed]).toarray()

    _, similar_indices = index.search(np.array(query_vector, dtype="float32"), k=8)
    results = [
        {
            "item": item_descriptions[i],
            "score": cosine_similarity([query_vector[0]], [item_vectors[i]])[0][0],
            "id": unique_items[i].id
        }
        for i in similar_indices[0]
    ]

    unique_results = {result["id"]: result for result in results}.values()

    filtered_results = [result for result in unique_results if result["score"] > 0]

    if not filtered_results:
        return success_response({"matches": []})
    
    filtered_results = sorted(filtered_results, key=lambda x: x["score"], reverse=True)
    for result in filtered_results:
        matched_item = Item.query.filter_by(id=result["id"]).first()
        if matched_item not in request_obj.items:
            request_obj.items.append(matched_item)

    db.session.commit()

    return success_response({"matches": filtered_results})

              
    
@app.route("/api/requests/<int:request_id>/items/<int:item_id>/", methods=["POST"])
def associate_item_with_request(request_id, item_id):
    """
    Associates and item with a request and updates status
    Request = resolved
    item = claimed
    """
    request2 = Request.query.filter_by(id=request_id).first()
    item2 = Item.query.filter_by(id=item_id).first()
    if not request2 or not item2:
        return failure_response("Request Not Found!")
    
    request2.items.append(item2)
    item2.status = "claimed"
    request2.status = "resolved"
    db.session.commit()

    if item2.finder_id:
        user = User.query.filter_by(id=item2.finder_id).first()
        if user:
            user.points += 5 
            db.session.commit()

    return success_response({"request": request2.serialize(), "item": item2.serialize()})

@app.route("/api/requests/<int:request_id>/add_item/<int:item_id>/", methods=["POST"])
def add_item_to_request(request_id, item_id):
    """
    Eendpoint to manually associate an item with a request by setting the item_id field.
    """
    request_obj = Request.query.filter_by(id=request_id).first()
    item_obj = Item.query.filter_by(id=item_id).first()

    if not request_obj:
        return failure_response("Request not found!", 404)
    if not item_obj:
        return failure_response("Item not found!", 404)

    request_obj.item_id = item_id 
    db.session.commit()

    return success_response(request_obj.serialize())


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
