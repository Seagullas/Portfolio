import joblib
import os
import sqlite3

class Programa:
    def __init__(self, model_path, vectorizer_path):
        self.model = self.load_model(model_path)
        self.vectorizer = self.load_vectorizer(vectorizer_path)
    
    def load_model(self, model_path):
        modelio_kelias = os.path.abspath(model_path)
        print(f"Loading model from: {modelio_kelias}")
        
        if not os.path.isfile(modelio_kelias):
            raise FileNotFoundError(f"Nera {modelio_kelias}")
        
        try:
            model = joblib.load(modelio_kelias)
            print("Model loaded successfully")
            return model
        except Exception as e:
            print(f"Erroras: {e}")
            return None
    
    def load_vectorizer(self, vectorizer_path):
        rectorizerio_kelias = os.path.abspath(vectorizer_path)
        print(f"Loading vectorizer from: {rectorizerio_kelias}")
        
        if not os.path.isfile(rectorizerio_kelias):
            raise FileNotFoundError(f"Vectorizer file not found at {rectorizerio_kelias}")
        
        try:
            vectorizer = joblib.load(rectorizerio_kelias)
            print("Vectorizer loaded successfully")
            return vectorizer
        except Exception as e:
            print(f"Error loading the vectorizer: {e}")
            return None
    
    def predict(self, text):
        if not self.model or not self.vectorizer:
            print("Neuzloadinta")
            return
        
        try:
            transformed_text = self.vectorizer.transform([text])
            prediction = self.model.predict(transformed_text)
            print(f"Prediction: {prediction}")
            return prediction[0]
        except ValueError as ve:
            print(f"Error: {ve}")
            return None
    def priimti_teksta(self, text, rezas):
        print(f"Dedam i database: Text - {text}, Prediction - {rezas}")
        conn = sqlite3.connect('duomenu_baze.db')
        cursor = conn.cursor()
        
        cursor.execute('''CREATE TABLE IF NOT EXISTS tekstai
                          (id INTEGER PRIMARY KEY,
                           tekstas TEXT,
                           predikcija INTEGER)''')
        
        cursor.execute('INSERT INTO tekstai (tekstas, predikcija) VALUES (?, ?)', (text, rezas))
        conn.commit()
        conn.close()