from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

request_item_association = db.Table(
    'request_items',
    db.Column('request_id', db.Integer, db.ForeignKey('requests.id'), primary_key=True),
    db.Column('item_id', db.Integer, db.ForeignKey('items.id'), primary_key=True)
)

class User(db.Model):
    """
    User Model 
    """
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key = True, autoincrement=True)
    name = db.Column(db.String, nullable = False)
    email = db.Column(db.String, unique = True, nullable = False)
    points = db.Column(db.Integer, default=0)
    pfpURL = db.Column(db.String, nullable = True)
    requests = db.relationship("Request", cascade = "delete")

    found_items = db.relationship("Item", back_populates="found_by_user", lazy=True)

    def __init__(self, **kwargs):
        """
        Initialize User object/entry
        """
        self.name = kwargs.get('name')
        self.email = kwargs.get('email')
        self.points = kwargs.get('points', 0)
        self.pfpURL = kwargs.get('pfpURL')

    def serialize(self):
        """
        Serialize a User object
        """
        return {
            "id": self.id,
            "name": self.name,
            "email": self.email,
            "points": self.points,
            "pfpURL": self.pfpURL,
            "requests": [request.serialize() for request in self.requests]  # Serialize requests
        }
    
class Request(db.Model):
    """
    Request Model 
    """
    __tablename__ = 'requests'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    status = db.Column(db.String, nullable = False) #idk how to make it pending or resolved (boolean?)
    name = db.Column(db.String, nullable = False)
    location = db.Column(db.String, nullable = True)
    description = db.Column(db.String, nullable = False)
    
    email = db.Column(db.String, nullable = False)
    phone = db.Column(db.String, nullable = True)
    date = db.Column(db.Float, nullable = False)

    items = db.relationship("Item", secondary=request_item_association, back_populates = "requests")

    def __init__(self, **kwargs):
        """
        Initialize Request object/entry
        """
        self.user_id = kwargs.get('user_id')
        self.status = kwargs.get('status')
        self.name = kwargs.get('name')
        self.location = kwargs.get('location')
        self.description = kwargs.get('description')
        self.email = kwargs.get("email")
        self.phone = kwargs.get("phone")
        self.date = kwargs.get("date")


    def serialize(self):
        """
        Serialize a Request object
        """
        return {
            "id": self.id,
            "user_id": self.user_id,
            "status": self.status,
            "name": self.name,
            "location": self.location,
            "description": self.description,          
            "items": [item.serialize_limited() for item in self.items],
            "email": self.email,
            "phone": self.phone,
            "date": self.date 
        }
    

    def serialize_limited(self):
        """
        Makes it so that it doesn't keep recursing
        """
        return {
            "id": self.id,
            "user_id": self.user_id,
            "name": self.name,
            "status": self.status,
            "last_location": self.location,
            "email": self.email,
            "phone": self.phone,
            "date": self.date
        }
    
class Item(db.Model):
    """
    Item Model
    """
    __tablename__ = "items"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String, nullable=True)  # Updated field name from 'name' to 'title'
    description = db.Column(db.String, nullable=True)
    status = db.Column(db.String, nullable=False, default="unclaimed")  # Default to "unclaimed"
    location = db.Column(db.String, nullable=False)
    image = db.Column(db.String, nullable=True)

    email = db.Column(db.String, nullable=False)
    phone = db.Column(db.String, nullable=False)
    date = db.Column(db.Float, nullable=False)

    preprocessed_description = db.Column(db.String, nullable=True)  # For optimized search
    finder_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=True)
    found_by_user = db.relationship("User", back_populates="found_items")

    requests = db.relationship("Request", secondary=request_item_association, back_populates="items")

    def __init__(self, **kwargs):
        """
        Initialize Item object/entry
        """
        self.title = kwargs.get("title")  # Changed from 'name' to 'title'
        self.description = kwargs.get("description")
        self.status = kwargs.get("status", "unclaimed")
        self.location = kwargs.get("location")
        self.preprocessed_description = kwargs.get("preprocessed_description")
        self.image = kwargs.get("image")
        self.finder_id = kwargs.get("finder_id")
        self.email = kwargs.get("email")
        self.phone = kwargs.get("phone")
        self.date = kwargs.get("date")

    def serialize(self):
        """
        Serialize an Item object
        """
        return {
            "id": self.id,
            "title": self.title,  
            "description": self.description,
            "location": self.location,
            "preprocessed_description": self.preprocessed_description,
            "status": self.status,
            "image": self.image,
            "finder_id": self.finder_id,
            "requests": [request.serialize_limited() for request in self.requests],
            "email": self.email,
            "phone": self.phone,
            "date": self.date
        }

    def serialize_limited(self):
        """
        Serialize limited fields to avoid recursion
        """
        return {
            "id": self.id,
            "title": self.title,  
            "status": self.status,
            "description": self.description,
            "location": self.location, 
            "email": self.email,
            "phone": self.phone,
            "date": self.date
        }
