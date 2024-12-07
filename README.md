# Red Retriever
<img src="https://github.com/user-attachments/assets/9726bf9b-a03d-452c-9b74-a6c287d24f1e" alt="Alt text" width="100" height="100" style="border-radius: 15px;">

A lost and found social media app to help Cornellians find their lost items around campus. 

## Description 
With over 19,000 acres of land and buildings and **100+ lost and founds**, finding a misplaced item at Cornell can be incredibly challenging. For years, Cornell students resorted to sites like Reddit to search for their lost items to no avail as they were buried under streams of unrelated content. Red Retriever addresses this issue by creating a dedicated platform for Cornellians to report and reclaim lost items. We intend to work with the campus police and the official lost and founds around campus to catalog items, establish safe transactions, and ensure items are returned to the proper owners.

## The App
### Login
<img src="https://github.com/user-attachments/assets/192d08a1-5504-4fda-9f29-089a5cb28c1a" alt="Home Screen" width="300">
<img src="https://github.com/user-attachments/assets/09359cad-a82e-49e9-b674-55d38f9127e4" alt="Additional Screenshot" width="300">

Upon opening the app, users can sign in with their Cornell.edu email account through gmail. After signing, the user is taken to the home page. 

### Home Page and Creating An Item Request
<img src="https://github.com/user-attachments/assets/544ebe78-acac-4937-88ad-41f1a336d94b" alt="Feature 1" width="300">
<img src="https://github.com/user-attachments/assets/4d8c281c-3b66-4a58-98b0-ad710d9bdbf2" alt="Feature 2" width="300">

The home page displays the Top Retrievers leaderboard, item-found posts that match the user's item request, and two buttons (Lost and Found) that the user can press to create either a lost item request or an item-found post.  

### Item Requests and Item Found status page and Item Match Page 
<img src="https://github.com/user-attachments/assets/41d711dd-1598-466f-9b13-18bf31fc6be3" alt="Another Screenshot" width="300">
<img src="https://github.com/user-attachments/assets/452d3a82-cce2-41b2-8805-a384e0986551" alt="Profile Page" width="300">

These screens show the page users are taken to when they want to make an item request post and the page that appears when the user taps on the item matches posts on the home page.  

## The Requirements

### Frontend 
- **Multiple screens that you can navigate between:** Our app has 8+ views that the user can navigate through such as the home screen (HomeVC), creating item request screen (CreateRequestVC), creating item found post screen (RequestsVC), etc.
- **At least one scrollable view:** Our app has several collection views that display data to the user including PostCollectionViewCell which displays item found matches to the user on the home screen.
- **Networking integration with a backend API:** Our app creates and fetches item requests and posts from the backend.    

### Backend
- **At least 4 routes (1 must be GET, 1 must be POST, 1 must be DELETE):**
GET users, GET Specific User, Create User (POST)
GET requests, GET specific request, Create request (POST), Update request (POST), DELETE Request
GET items, GET specific item, Create item (POST), DELETE item

- **At least 2 tables in database with a relationship between them:**
Tables: Users, Request, Item
 The database consists of three tables: a User table, which stores user information; a Request table, which holds the details of item requests; and an Item table, which contains the information about items that can be requested or found. There is a one-to-many relationship between User and Request, where each user can have multiple requests, and there is a many-to-many relationship between Request and Item, where a request can be linked to multiple items, and an item can appear in multiple requests.
- **API specification explaining each implemented route:**


### Design
**Design in Figma:** https://www.figma.com/design/ESTQTcXJHDG98oegfAmgyE/Hack-Challenge?node-id=0-1&t=0ei71U5QRHJbYZeo-1
- **Low fidelity sketches of design:**
- **Medium fidelity explorations of multiple flows in Figma:**
- **High fidelity prototype in Figma:**
- **UI design kit/design system in Figma:**

## The Team
- Tina Chen
- Satria Tjiaman
- Sonja Wang 
- Ethan Seiz
- Allie Lin
