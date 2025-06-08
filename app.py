import sqlite3
from flask import Flask, jsonify, render_template

# This creates the Flask web server application
app = Flask(__name__)

# --- Database Connection Function ---
# A helper function to connect to our database file
def get_db_connection():
    """Creates a connection to the SQLite database."""
    conn = sqlite3.connect('agrilink.db')
    # This line makes the query results work like dictionaries, which is very useful
    conn.row_factory = sqlite3.Row
    return conn

# --- Route to serve your main HTML page ---
# This tells Flask: "When someone visits the homepage ('/'), run this function."
@app.route('/')
def index():
    # This looks for a file named 'index.html' inside a folder named 'templates'
    # and sends it to the browser.
    return render_template('index.html')

# --- API Endpoint to get all products ---
# This creates a special URL just for our JavaScript to get data.
@app.route('/api/products')
def get_products():
    conn = get_db_connection()
    # Execute a SQL query to get all products
    products = conn.execute('SELECT id, name, image_url FROM products').fetchall()
    conn.close()
    # Convert the database rows into a list that can be sent as JSON
    product_list = [dict(row) for row in products]
    return jsonify(product_list)

# --- API Endpoint to get all news updates ---
# Another special URL for our JavaScript to get the news updates.
@app.route('/api/news')
def get_news():
    conn = get_db_connection()
    news = conn.execute('SELECT content FROM news_updates ORDER BY created_at DESC').fetchall()
    conn.close()
    news_list = [dict(row) for row in news]
    return jsonify(news_list)

# --- This is the part that starts the server ---
# The 'if' statement is standard Python practice for runnable scripts.
if __name__ == '__main__':
    # This command actually starts the web server.
    # debug=True is very helpful because it will show you errors in the browser.
    # port=5000 means your website will be at http://localhost:5000
    app.run(debug=True, port=5000)
