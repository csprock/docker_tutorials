import os
import psycopg2 as pg
import pandas as pd

from dash import Dash, html, dcc, dash_table
from dash.dependencies import Input, Output, State
import dash_bootstrap_components as dbc


app = Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])

def get_db():
    conn = pg.connect(
        dbname="dvdrental",
        user=os.getenv('DB_USER', "postgres"),
        password=os.getenv('DB_PASSWORD', "password"),
        host=os.getenv('DB_PORT', 5432),
        port=os.getenv('DB_HOST', "localhost")
    )
    return conn

class Queries:

    ratings = """
    SELECT DISTINCT rating FROM film
    """

    genre = """
    SELECT name FROM category
    """

    movies = """
    SELECT
        film.film_id,
        film.title,
        film.description,
        film.release_year,
        lang.name
    FROM film LEFT JOIN language as lang ON film.language_id = lang.language_id
        LEFT JOIN film_category ON film.film_id = film_category.film_id
        LEFT JOIN category ON film_category.category_id = category.category_id
    WHERE
        category.name = %(category)s AND
        film.rating = %(rating)s
    """



# Layout for the app
app.layout = dbc.Container([
    html.H1("DVD Rental Movie Explorer", className="text-center my-4"),
    
    dbc.Row([
        dbc.Col([
            html.Label("Select Category:"),
            dcc.Dropdown(
                id='category-dropdown',
                placeholder="Select a category",
            ),
        ], width=6),
        
        dbc.Col([
            html.Label("Select Rating:"),
            dcc.Dropdown(
                id='rating-dropdown',
                placeholder="Select a rating",
            ),
        ], width=6),
    ], className="mb-4"),
    
    dbc.Row([
        dbc.Col([
            dbc.Button("Search Movies", id="search-button", color="primary", className="w-100")
        ], width=12),
    ], className="mb-4"),
    
    dbc.Row([
        dbc.Col([
            html.Div(id="table-container")
        ], width=12)
    ])
], fluid=True)

# Callback to populate the dropdowns when the app starts
@app.callback(
    [Output('category-dropdown', 'options'),
     Output('rating-dropdown', 'options')],
    [Input('category-dropdown', 'id')]  # Dummy input to trigger on load
)
def populate_dropdowns(_):
    conn = get_db()
    
    # Get categories
    df_categories = pd.read_sql_query(Queries.genre, conn)
    category_options = [{'label': name, 'value': name} for name in df_categories['name'].tolist()]
    
    # Get ratings
    df_ratings = pd.read_sql_query(Queries.ratings, conn)
    rating_options = [{'label': rating, 'value': rating} for rating in df_ratings['rating'].tolist()]
    
    conn.close()
    return category_options, rating_options

# Callback to update the table based on dropdown selections
@app.callback(
    Output('table-container', 'children'),
    [Input('search-button', 'n_clicks')],
    [State('category-dropdown', 'value'),
     State('rating-dropdown', 'value')]
)
def update_table(n_clicks, category, rating):
    if n_clicks is None or category is None or rating is None:
        return html.Div("Select a category and rating, then click 'Search Movies'")
    
    conn = get_db()
    
    # Execute query with parameters
    df = pd.read_sql_query(Queries.movies, conn, params={'category': category, 'rating': rating})
    conn.close()
    
    if df.empty:
        return html.Div("No movies found matching your criteria.")
    
    # Rename columns for better display
    df = df.rename(columns={
        'film_id': 'ID',
        'title': 'Title',
        'description': 'Description',
        'release_year': 'Year',
        'name': 'Language'
    })
    
    table = dash_table.DataTable(
        id='results-table',
        columns=[{"name": col, "id": col} for col in df.columns],
        data=df.to_dict('records'),
        style_table={'overflowX': 'auto'},
        style_cell={
            'textAlign': 'left',
            'padding': '10px',
            'whiteSpace': 'normal',
            'height': 'auto'
        },
        style_header={
            'backgroundColor': '#f8f9fa',
            'fontWeight': 'bold'
        },
        style_data_conditional=[
            {
                'if': {'row_index': 'odd'},
                'backgroundColor': '#f5f5f5'
            }
        ],
        page_size=10
    )
    
    return table

if __name__ == '__main__':
    app.run_server(debug=True, host='0.0.0.0', port=8050)