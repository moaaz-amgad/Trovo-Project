// الرابط الموحد لجلب كل بيانات الداشبورد
const BASE_URL = "https://trovo-project-production.up.railway.app/api"; 

async function fetchData() {
    const statusText = document.getElementById('sync-status');
    
    try {
        // بننادي على الـ Route الشامل اللي عملناه في الـ AdminDashboardController
        // ملحوظة: لازم تبعت الـ Token لو مفعل الـ Sanctum Middleware
        const response = await fetch(`${BASE_URL}/admin/dashboard-stats`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                // لو عامل تسجيل دخول، فك الكومنت عن السطر اللي جاي وضيف التوكن
                // 'Authorization': 'Bearer ' + localStorage.getItem('admin_token')
            }
        });

        const result = await response.json();

        if (result.status === 'success') {
            // لاحظ هنا بنبعت result.stats لأننا في لارافل رجعنا الداتا جوه مفتاح اسمه stats
            updateUI(result.stats);
            statusText.innerText = "● Connected to Railway (Production)";
            statusText.style.color = "#64ffda"; 
        }
    } catch (error) {
        console.error("Connection Error:", error);
        statusText.innerText = "● Offline - Check Railway URL";
        statusText.style.color = "#f87171";
    }
}

function updateUI(stats) {
    // 1. تحديث الكروت العلوية (المسميات مطابقة تماماً لما أرسله Laravel)
    document.getElementById('total_users').innerText = stats.total_students || 0;
    document.getElementById('mild_cases').innerText = stats.case_distribution?.mild || 0;
    document.getElementById('moderate_cases').innerText = stats.case_distribution?.moderate || 0;
    document.getElementById('severe_cases').innerText = stats.case_distribution?.severe || 0;
    
    // إضافة نسبة الإدمان (دلع من عندنا للدكتور)
    if(document.getElementById('addiction_rate')) {
        document.getElementById('addiction_rate').innerText = stats.addiction_rate || "0%";
    }

    // 2. تحديث الجدول (Recent Activity)
    const tableBody = document.getElementById('diagnosis_table_body');
    tableBody.innerHTML = ''; 

    // بنلف على الـ recent_activity اللي رجعناها في الـ Controller
    const activities = stats.recent_activity || [];

    activities.forEach(item => {
        const userName = item.user?.name || "Student";
        // المسمى الحقيقي في الداتابيز هو brainrot_stage
        const stage = item.brainrot_stage || "N/A";
        
        const row = `
            <tr class="hover:bg-white/5 transition border-b border-white/5">
                <td class="p-5">
                    <div class="flex items-center gap-3">
                        <div class="w-8 h-8 bg-[#64ffda]/10 text-[#64ffda] rounded-full flex items-center justify-center text-xs font-bold border border-[#64ffda]/20">
                            ${userName.charAt(0)}
                        </div>
                        <span class="font-bold text-white">${userName}</span>
                    </div>
                </td>
                <td class="p-5">
                    <span class="px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider ${getStatusStyle(stage)}">
                        ${stage}
                    </span>
                </td>
                <td class="p-5 text-gray-400 text-sm">
                    ${new Date(item.diagnosed_at).toLocaleString('ar-EG')}
                </td>
            </tr>
        `;
        tableBody.innerHTML += row;
    });
}

function getStatusStyle(stage) {
    const s = stage.toLowerCase();
    // المسميات مطابقة لرد الموديل (Mild, Moderate, Severe)
    if (s.includes('mild')) return 'bg-green-500/10 text-green-400 border border-green-500/20';
    if (s.includes('moderate')) return 'bg-yellow-500/10 text-yellow-400 border border-yellow-500/20';
    if (s.includes('severe')) return 'bg-red-500/10 text-red-400 border border-red-500/20';
    return 'bg-white/5 text-gray-400';
}

window.onload = fetchData;
