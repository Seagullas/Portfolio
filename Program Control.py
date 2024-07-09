from programa import Programa
import numpy as np
def pasirinkimai():
    print("1. Baigti programą")
    print("2. Įvesti tekstą")

if __name__ == "__main__":
    programa = Programa(model_path='modelis_final.pkl', vectorizer_path='vektoraizeris.pkl')
    
    while True:
        pasirinkimai()
        pasirinkimas = input('Įveskite pasirinkimą: ')
        if pasirinkimas == '1':
            print('Programos pabaiga.')
            break
        elif pasirinkimas == '2': 
            text_input = input('Įveskite teksta: ')
            prediction = programa.predict(text_input)
            if prediction is not None:
                if isinstance(prediction, (np.ndarray, list)):
                    prediction = prediction[0]
                prediction = int(prediction)
                programa.priimti_teksta(text_input, prediction)



        else:
            print('Pasirinkimas netinkamas, kartokite.')