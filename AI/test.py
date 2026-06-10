import requests

url = 'http://127.0.0.1:5000/predict'
# دي البيانات الخام (Raw) اللي الموديل مستنيها
# لاحظي بنبعت Gender و Purpose كنصوص عادي
data = {
    "Gender": "Male",
    "Daily_Usage_Hours": 8.5,
    "Sleep_Hours": 5.0,
    "Academic_Performance": 2.0,
    "Social_Interactions": 1.0,
    "Exercise_Hours": 0.5,
    "Anxiety_Level": 4.0,
    "Depression_Level": 3.0,
    "Self_Esteem": 2.0,
    "Screen_Time_Before_Bed": 3.0,
    "Phone_Checks_Per_Day": 120,
    "Apps_Used_Daily": 30,
    "Time_on_Social_Media": 5.0,
    "Time_on_Gaming": 2.0,
    "Time_on_Education": 0.5,
    "Phone_Usage_Purpose": "Gaming",
    "Weekend_Usage_Hours": 12.0
}

try:
    response = requests.post(url, json=data)
    print("Status Code:", response.status_code)
    print("Response Data:", response.json())
except Exception as e:
    print("Error:", e)