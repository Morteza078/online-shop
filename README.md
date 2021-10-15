# online-shop
this project is my final project of maktab-sharif-53(online-shop by django)

Bilingual Online Shopping System Project with Python &amp; Django Framework &amp; REST API

## Photos:

### 1
![image](https://user-images.githubusercontent.com/86655899/136507176-f461633d-ee7b-4711-8151-13fc49122a8f.png)
### 2
![image](https://user-images.githubusercontent.com/86655899/136507301-e595db78-38df-4ced-a064-b9c99d6edc8b.png)
### 3
![image](https://user-images.githubusercontent.com/86655899/136506967-809b7f88-4b15-40e0-a2b5-b41f2b7f9cf2.png)
### 4
![image](https://user-images.githubusercontent.com/86655899/136507780-a2dbde6e-d665-460f-85fd-39ec53f7fd39.png)
### 5
![image](https://user-images.githubusercontent.com/86655899/136509496-8eba2cb2-f790-4d2f-bb2f-3632e6f299d8.png)

## Tools:
1. Back-End: Python, Django, REST API
2. Data Base: PostgreSQL
3. Front-End: HTML5, CSS3, JavaScript, Bootstrap5, jQuery, AJAX

## How to Run?
1. Clone the Project
* `git clone https://github.com/Morteza078/online-shop.git`
2. Cd to online-shop folder and Create a Virtual Environment
* `cd online-shop`
* `py -3 -m venv venv`
3. Activate the Interpreter of the Virtual Environment
* Windows: `venv\Scripts\activate`
* windows in git bash:`source venv/Scripts/activate`
* Linux: `source venv/bin/active`
4. Create a database called `shop` on your system and import shop.pgsql 
5. In settings.py, set up the database as follows:
* `DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'shop',
        'USER': 'postgres',
        'PASSWORD': 'your password',
        'HOST': '127.0.0.1',
        'PORT': '5432',
    }
}`
6. In settings.py, set up the email as follows:
* `EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_USE_TLS = True
EMAIL_PORT = 587
EMAIL_HOST_USER = 'your email'
EMAIL_HOST_PASSWORD = 'your email password'`

7. Install the Requirements
* `pip install -r requirements.txt`

8. Write the Following Commands to Create Your Tables
* `python manage.py makemigrations`
* `python manage.py migrate`

9. Write the Following Command to Create a Superuser
* `python manage.py createsuperuser`

10. Write the Following Command to Run the Server
* `python manage.py runserver`




