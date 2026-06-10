import requests

url = 'http://192.168.1.7:5000//predict'
# دي البيانات الخام (Raw) اللي الموديل مستنيها
# لاحظي بنبعت Gender و Purpose كنصوص عادي
data = {
    "Gender": "Female",
    "Daily_Usage_Hours": 3,
    "Sleep_Hours": 5.0,
    "Academic_Performance": 50,
    "Social_Interactions": 7.0,
    "Exercise_Hours": 1,
    "Anxiety_Level": 3.0,
    "Depression_Level": 3.0,
    "Self_Esteem": 6.0,
    "Screen_Time_Before_Bed": .5,
    "Phone_Checks_Per_Day": 50,
    "Apps_Used_Daily": 2,
    "Time_on_Social_Media": 1,
    "Time_on_Gaming": 0,
    "Time_on_Education": 1,
    "Phone_Usage_Purpose": "Browsing",
    "Weekend_Usage_Hours": 4
}

try:
    response = requests.post(url, json=data)
    print("Status Code:", response.status_code)
    print("Response Data:", response.json())
except Exception as e:
    print("Error:", e)
    