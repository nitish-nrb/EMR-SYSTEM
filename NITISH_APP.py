import mysql.connector
from mysql.connector import Error
import requests
from flask import Flask, request, render_template, redirect, url_for, session, make_response
from flask import jsonify
from flask import flash, get_flashed_messages



NITISH_APP = Flask(__name__)
NITISH_APP.secret_key = 'Apple@123'

@NITISH_APP.route('/SignIn', methods=['GET', 'POST'])
def SignIn():
    if request.method == 'POST':
        try:
            user_type = request.form['user_type']
            
            if user_type == 'patient':
                patient_id = int(request.form['patient_id'])
                first_name = request.form['patient_first_name']
                last_name = request.form['patient_last_name']
                gender = request.form['gender']
                age = request.form['age']
                patient_phone = request.form['patient_phone']
                patient_email = request.form['patient_email']
                password = request.form['patient_password']
                patient_address = request.form['patient_address']
                insurance_id = request.form['insurance_id']
                userType = request.form['user_type']
                
            elif user_type == 'provider':
                provider_id = request.form['provider_id']
                first_name = request.form['provider_first_name']
                last_name = request.form['provider_last_name']
                specialty = request.form['specialty']
                provider_email = request.form['provider_email']
                password = request.form['provider_password']
                appointment_fee = request.form['appointment_fee']
                nurse_id = request.form['nurse_id']
                number_id = request.form['number_id']
                userType = request.form['user_type']

            elif user_type == 'nurse':
                nurse_id = request.form['nurse_id']
                nurse_name = request.form['nurse_name']
                nurse_email = request.form['nurse_email']
                password = request.form['nurse_password']
                nurse_phone = request.form['nurse_phone']
                visit_id = request.form['visit_id']
                priority_id = request.form['priority_id']
                userType = request.form['user_type']
              

            connection = mysql.connector.connect(
                host='localhost',
                database='projectone',
                user='root',
                password='root'
            )

            cursor = connection.cursor()

            
            print("user_type "+user_type)

            if user_type == 'patient':
                cursor.execute("SELECT * FROM Patient WHERE patient_id = %s", (patient_id,))
                existing_patient = cursor.fetchone()
                if existing_patient:
                    error_message = "Patient with ID {} already exists.".format(patient_id)
                    flash(error_message, 'error')
                    return render_template('SignIn.html')
                cursor.callproc('CreatePatient', (patient_id, first_name, last_name, gender, age, patient_phone, patient_email, patient_address, insurance_id, password, userType))                
            elif user_type == 'provider':
                cursor.execute("SELECT * FROM Provider WHERE provider_id = %s", (provider_id,))
                existing_provider = cursor.fetchone()
                if existing_provider:
                    error_message = "Provider with ID {} already exists.".format(provider_id)
                    flash(error_message, 'error')
                    return render_template('SignIn.html')
                cursor.callproc('CreateProvider', (provider_id, first_name, last_name, specialty, provider_email, appointment_fee, nurse_id, number_id, password, userType))
         

               
            if user_type == 'nurse':
                cursor.execute("SELECT * FROM Nurse WHERE nurse_id = %s", (nurse_id,))
                existing_nurse = cursor.fetchone()
                if existing_nurse:
                    error_message = "Nurse with ID {} already exists.".format(nurse_id)
                    flash(error_message, 'error')
                    return render_template('SignIn.html')   
                cursor.callproc('CreateNurse', (nurse_id, nurse_name, nurse_phone, visit_id, priority_id, nurse_email, password, userType))

               

            connection.commit()

            # Redirect to the login page after successful registration
            return redirect(url_for('login'))

        except Error as e:
            print('Error:', e)

        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'connection' in locals() and connection.is_connected():
                connection.close()

    return render_template('SignIn.html')






@NITISH_APP.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        try:
            
            email = request.form['email']
            password = request.form['password']
            user_type = request.form['user_type']

            connection = mysql.connector.connect(
                host='localhost',
                database='projectone',
                user='root',
                password='root'
            )
               

            cursor = connection.cursor()
            if user_type == 'patient':
                select_query = "SELECT * FROM patient WHERE email = %s AND password = %s AND userType = %s"
                cursor.execute(select_query, (email, password, user_type))
                result = cursor.fetchone()
            elif user_type == 'provider':
                select_query = "SELECT * FROM provider WHERE email = %s AND password = %s AND userType = %s"
                cursor.execute(select_query, (email, password, user_type))
                result = cursor.fetchone()
            elif user_type == 'nurse':
                select_query = "SELECT * FROM nurse WHERE email = %s AND password = %s AND userType = %s"
                cursor.execute(select_query, (email, password, user_type))
                result = cursor.fetchone()
            print(user_type +"  "+ str(result))

            if result is not None and user_type == 'patient':
                session['patient_id'] = result[0]  # Assuming the patient ID is at index 3 of the tuple
                session['email'] = result[6]
                session['user_type'] = result[-1]  # Assuming the user type is at index 2 of the tuple
    
                message = "Login successful!"
                return redirect(url_for('user_interface', user_type=user_type, email=email))
            
            elif result is not None and user_type == 'provider':
                session['provider_id'] = result[0]  # Assuming the patient ID is at index 3 of the tuple
                session['email'] = result[4]
                session['user_type'] = result[-1]  # Assuming the user type is at index 2 of the tuple
    
                message = "Login successful!"
                return redirect(url_for('user_interface', user_type=user_type, email=email))
            elif result is not None and user_type == 'nurse':
                session['nurse_id'] = result[0]  
                session['email'] = result[5]
                session['user_type'] = result[-1]  
    
                message = "Login successful!"
                return redirect(url_for('user_interface', user_type=user_type, email=email))



            else:
                message = "Invalid email or password or userType. Please try again."
                flash("Invalid email or password. Please try again.", "error")
                return render_template('login.html', message=message)

        except Error as e:
            print('Error:', e)

        finally:
            if connection.is_connected():
                cursor.close()
                connection.close()

    return render_template('login.html')



@NITISH_APP.route('/user_interface', methods=['GET', 'POST'])
def user_interface():
    if 'user_type' in session:
        user_type = session['user_type']
        email = session['email']
        messages = get_flashed_messages()
      
        visits = []
        
        bill_amount = None
        if user_type == 'patient' and request.method == 'POST' and 'fetchBillButton' in request.form:
            patient_id = session.get('patient_id')
            provider_id = session.get('provider_id')
            print(provider_id+ ' in patient')
            print(patient_id + ' in patient')

            if patient_id is not None:
                
                url = 'http://localhost:5000/generate_bill'
                params = {**session, 'patient_id': patient_id, 'user_type': user_type}
                
                try:
                    response = requests.get(url, params=params)
                    response.raise_for_status()

                    bill_data = response.json()
                    if 'bill' in bill_data:
                        bill_amount = bill_data['bill']
                    else:
                        print('Error fetching bill:', bill_data.get('error'))

                except requests.exceptions.RequestException as e:
                    print('Error fetching bill:', str(e))

        if user_type == 'provider' and request.method == 'POST' and 'fetchBillButton' in request.form:
            
            if provider_id:
                url = 'http://localhost:5000/generate_bill'
                params = {**session, 'patient_id': provider_id, 'user_type': user_type}

                try:
                    response = requests.get(url, params=params)
                    response.raise_for_status()

                    bill_data = response.json()
                    if 'bill' in bill_data:
                        bill_amount = bill_data['bill']
                    else:
                        print('Error fetching bill:', bill_data.get('error'))

                except requests.exceptions.RequestException as e:
                    print('Error fetching bill:', str(e))


        
        return render_template('user_interface.html', user_type=user_type, email=email, bill_amount=bill_amount,messages=messages)

    return render_template('user_interface.html')






@NITISH_APP.route('/generate_bill', methods=['GET'])
def generate_bill():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='PROJECTONE',
            user='root',
            password='root'
        )
        cursor = connection.cursor()
        if(session.get('user_type')=='provider'):
            patient_id = request.args.get('patient_id')
            print(patient_id)
        
        elif(session.get('user_type')=='nurse'):
            patient_id = request.args.get('patient_id')
            print(patient_id)

        else:
            patient_id = session.get('patient_id')
        cursor.callproc('CalculateBill', [patient_id])
        
        bill_amount = None
        for result in cursor.stored_results():
            bill_amount = result.fetchone()[0]
            if bill_amount == None:
                return jsonify({'bill': 0})
            
        return jsonify({'bill': bill_amount})

    except mysql.connector.Error as e:
            print('Error:', e)

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

    return jsonify({'error': 'Error occurred while generating the bill.'})




@NITISH_APP.route('/update_patient_form', methods=['GET'])
def update_patient_form():
    patient_id = session.get('patient_id')
    if(session.get('user_type')=='provider'):
        patient_id = request.args.get('patient_id')
        session['patient_id'] = patient_id
        
        print(str(patient_id)+' 2')
    if(session.get('user_type')=='nurse'):
        email = session.get('email')
        flash('{} you are a nurse and not authorized to update user details'.format(email), 'error')
        return redirect(url_for('user_interface'))
        
    
   
    return render_template('update_patient.html', patient_id=patient_id)


@NITISH_APP.route('/update_patient', methods=['POST'])
def update_patient():
    try:
        
        patient_id = session.get('patient_id')
        print(patient_id)
        phone = request.form['phone']
        age = request.form['age']
        address = request.form['address']
        connection = mysql.connector.connect(
            host='localhost',
            database='PROJECTONE',
            user='root',
            password='root'
        )
        cursor = connection.cursor()
        cursor.callproc('UpdatePatientDetails', [patient_id, phone, age, address])
        connection.commit()
        return redirect(url_for('user_interface'))
    except Exception as e:
        print('Error updating patient details:', str(e))
        connection.rollback()
        return 'Error updating patient details'

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

    return 'Invalid request method'



@NITISH_APP.route('/logout', methods=['GET', 'POST'])
def logout():
    session.clear()
    response = make_response(redirect(url_for('login')))
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    return response



if __name__ == '__main__':
    
    NITISH_APP.run()
    NITISH_APP.debug = True
  
