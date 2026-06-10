import pandas as pd
import numpy as np

# قاموس النصائح (نفسه مع التأكد من جودته)
feature_recs = {
    "Time_on_Social_Media": "Social media is ghosting your real life. Try 30 mins post-work and then, you know, exist?",
    "App_Switching_Rate": "Stop jumping between apps like a caffeinated squirrel. Focus is sexy, try it for 20 mins!",
    "Phone_Checks_Per_Day": "Your phone isn't a long-lost lover. Stop checking it every 2 seconds; keep it in another room.",
    "Screen_Time_Before_Bed": "Blue light is a vibe killer. Swap the scroll for a physical book—your brain will thank you.",
    "Daily_Usage_Hours": "Your screen time is higher than your GPA. Set a limit before you turn into a literal battery icon.",
    "Anxiety_Level": "Deep breaths! Try the 4-7-8 technique—it’s like a factory reset for your stressed-out brain.",
    "nonproductive_ratio": "You're spending too much time on 'brain-mush' content. Audit your apps before your last brain cell leaves.",
    "Sleep_Hours": "Sleep isn't for the weak; it's for the functional. Aim for 7-8 hours or enjoy looking like a zombie.",
    "Check_Per_Hour": "Notification Squad is ruining your life. Disable the pings and reclaim your sanity.",
    "Usage_Sleep_Ratio": "Scrolling at 3 AM isn't a personality trait. Prioritize sleep or prepare for a major system crash."
}

def get_brain_rot_stage(score):
    # السكور الآن مضمون يكون بين 0 و 1 بفضل الـ clip
    if score < 0.35: return "Low (Mild)"
    elif score < 0.70: return "Medium (Moderate)"
    else: return "High (Severe)"

def get_feature_contributions(user, importance_map):
    contributions = {}
    for feature, weight in importance_map.items():
        if feature in user:
            val = user[feature]
            if feature in ['Sleep_Hours', 'Social_Interactions', 'focus_ratio', 'Time_on_Education']:
                val = max(0, 1.0 - val) 
            # بنضيف قيمة ضئيلة جداً (1e-6) عشان نتفادى الأصفار المطلقة في الحساب
            contributions[feature] = weight * (val + 1e-6)
    return contributions

def smart_recommendation_system(user, importance_map):
    contributions = get_feature_contributions(user, importance_map)
    
    total_weights_used = sum(importance_map.values())
    raw_score = sum(contributions.values())
    
    # تطبيع السكور وضمان إنه بين 0 و 1
    normalized_score = np.clip(raw_score / total_weights_used, 0, 1) if total_weights_used > 0 else 0
    
    stage = get_brain_rot_stage(normalized_score)
    
    stage_msg = {
        "Low (Mild)": "You're doing great! Your digital habits are mostly healthy. ✨",
        "Medium (Moderate)": "You're at a crossroads. Some habits are starting to drag you down. 🚧",
        "High (Severe)": "Red alert! Your digital habits are literally frying your focus. 🔥"
    }
    
    personal_intro = f"{stage_msg.get(stage, '')} Based on YOUR specific data, here is exactly what's messing with your brain:"

    # ترتيب العوامل
    sorted_factors = sorted(contributions.items(), key=lambda x: x[1], reverse=True)
    
    final_recs = []
    top_factors_names = []
    
    for f_name, val in sorted_factors[:3]:
        # عرض اسم العامل فقط بدون النسبة المئوية
        top_factors_names.append(f_name.replace('_', ' '))
        if f_name in feature_recs:
            final_recs.append(f"👉 {feature_recs[f_name]}")

    return {
        "brainrot_stage": stage,
        "personal_analysis": personal_intro,
        "top_contributing_factors": top_factors_names, # قائمة بالأسماء فقط
        "recommendations": final_recs
    }