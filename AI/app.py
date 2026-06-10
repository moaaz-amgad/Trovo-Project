from flask import Flask, request, jsonify
import joblib
import pandas as pd
import numpy as np
import traceback
# استيراد الوظيفة المحدثة من logic.py
from logic import smart_recommendation_system

app = Flask(__name__)

# =========================
# تحميل الموديل والأدوات
# =========================
try:
    model = joblib.load('best_xgb_model.pkl')
    scaler = joblib.load('scaler.pkl')
    feature_names = joblib.load('features_names.pkl') 

    # استخراج الأوزان من الموديل (خلاصة التدريب)
    if hasattr(model, 'feature_importances_'):
        model_importance_map = dict(zip(feature_names, model.feature_importances_))
    else:
        # أوزان افتراضية في حالة الفشل (مجموعها 1.0)
        model_importance_map = {f: 1.0/len(feature_names) for f in feature_names}

    print("\n" + "="*50)
    print("API Server Status: RUNNING (Optimized Logic)")
    print(f"Model Importances Loaded for {len(feature_names)} features.")
    print("="*50 + "\n")
except Exception as e:
    print(f" Critical Error loading model files: {e}")

@app.route('/', methods=['GET'])
def home():
    return "<h1>Brainrot Analysis API v3.0</h1><p>Status: Ready for Predictions</p>"

# =========================
# دالة التوقع (Prediction)
# =========================
@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        if not data:
            return jsonify({'status': 'error', 'message': 'No data provided'}), 400

        # 1️⃣ المعالجة اليدوية للنصوص (Encoding)
        gender_map = {'Female': 0, 'Male': 1, 'Other': 1} 
        purpose_map = {'Browsing': 0, 'Education': 1, 'Social Media': 2, 'Gaming': 3, 'Other': 4}

        processed_data = data.copy()
        processed_data['Gender'] = float(gender_map.get(data.get('Gender', 'Male'), 1))
        processed_data['Phone_Usage_Purpose'] = float(purpose_map.get(data.get('Phone_Usage_Purpose', 'Other'), 4))

        input_df = pd.DataFrame([processed_data])

        # دالة مساعدة لجلب القيم بأمان وتحويلها لـ float
        def get_v(col):
            val = input_df.get(col)
            try:
                return float(val[0]) if (val is not None and not pd.isna(val[0])) else 0.0
            except: return 0.0

        # 2️⃣ الـ Feature Engineering (يجب أن يطابق تدريب الموديل)
        input_df['Check_Per_Hour'] = get_v('Phone_Checks_Per_Day') / (get_v('Daily_Usage_Hours') + 1)
        input_df['App_Switching_Rate'] = get_v('Apps_Used_Daily') / (get_v('Daily_Usage_Hours') + 1)
        input_df['Usage_Sleep_Ratio'] = get_v('Daily_Usage_Hours') / (get_v('Sleep_Hours') + 1)
        input_df['nonproductive_ratio'] = (get_v('Time_on_Social_Media') + get_v('Time_on_Gaming')) / (get_v('Time_on_Education') + 1)
        input_df['focus_ratio'] = get_v('Time_on_Education') / (get_v('Time_on_Social_Media') + 1)
        input_df['bedtime_ratio'] = get_v('Screen_Time_Before_Bed') / (get_v('Sleep_Hours') + 1)
        input_df['sleep_disturbance_score'] = (get_v('Screen_Time_Before_Bed') * get_v('Phone_Checks_Per_Day')) / (get_v('Sleep_Hours') + 1)

        # إعادة ترتيب الأعمدة لتطابق الموديل
        final_df = input_df.reindex(columns=feature_names, fill_value=0.0)

        # 3️⃣ تحويل البيانات باستخدام الـ Scaler
        # ده مهم جداً لأن الـ logic معتمد على قيم بين 0 و 1
        scaled_values = scaler.transform(final_df.values)
        
        # 4️⃣ التوقع (Addiction Score من الموديل)
        addiction_pred = model.predict(scaled_values)[0]
        addiction_pred = max(1, min(10, addiction_pred))

        # 5️⃣ التحليل الذكي للـ Brainrot والتوصيات
        # نستخدم البيانات الـ Scaled عشان نضمن إن الـ 1-val في الـ logic تشتغل صح
        user_scaled_dict = dict(zip(feature_names, scaled_values[0]))
# استدعاء السيستم
        analysis = smart_recommendation_system(user_scaled_dict, model_importance_map)

        # الرد النهائي المنظم
        return jsonify({
            'status': 'success',
            'addiction_level': round(float(addiction_pred), 2),
            'brainrot_stage': analysis['brainrot_stage'],
            'analysis_intro': analysis['personal_analysis'],
            'top_factors': analysis['top_contributing_factors'],
            'recommendations': analysis['recommendations']
        })
    except Exception as e:
        print("ERROR TRACE:\n", traceback.format_exc())
        return jsonify({'status': 'error', 'message': str(e)}), 500

import os

if __name__ == "__main__":
    # Railway بيستخدم متغير بيئة اسمه PORT
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)