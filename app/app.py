import os
from flask import Flask, request, jsonify, render_template
import pickle
import pandas as pd

app = Flask(__name__)

def load_model():
    global model
    with open('../models/rf_model.pkl', 'rb') as f:
        model = pickle.load(f)
        print("model loaded")

def process_input(data):
    
    # add empty keys for dummy-encoded property areas
    data['Property_Area_Urban'] = 0
    data['Property_Area_Semiurban'] = 0
    data['Property_Area_Rural'] = 0

    # convert to dataframe for easy processing
    df = pd.DataFrame([data])

    # create mapping dictionaries
    gender_values = {'Female' : 0, 'Male' : 1} 
    married_values = {'No' : 0, 'Yes' : 1}
    education_values = {'Graduate' : 0, 'Not Graduate' : 1}
    employed_values = {'No' : 0, 'Yes' : 1}
    credit_history = {'No' : 0, 'Yes' : 1}
    dependent_values = {'3+': 3, '0': 0, '2': 2, '1': 1}

    # perform mapping of values
    df.replace({'Gender': gender_values, 'Married': married_values, 'Education': education_values, \
                'Self_Employed': employed_values, 'Dependents': dependent_values, 'Credit_History': credit_history}, inplace=True)

    # map the property area to the appropriate encoded column
    propArea = df['Property_Area']
    df['Property_Area'+'_'+propArea] = 1

    # drop the property_area field
    df = df.drop('Property_Area', axis=1)

    return df


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        input_data = request.form.to_dict()
        data = process_input(input_data)
        value = model.predict(data)
        return render_template('index.html', result=value)

    return render_template('index.html')

if __name__ == "__main__":
    load_model()
    app.run(debug=True)