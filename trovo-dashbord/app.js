// ده الرابط بتاع Railway اللي عليه الداتا الحقيقية
const BASE_URL = "https://trovo-project-production.up.railway.app/api"; 

async function fetchData() {
    const statusText = document.getElementById('sync-status');
    
    try {
        // بننادي على الميثود اللي بتجيب الإحصائيات (الجديدة)
        const response = await fetch(`${BASE_URL}/admin/all-diagnoses`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        });

        const result = await response.json();

        if (result.status === 'success') {
            updateUI(result.stats, result.data);
            statusText.innerText = "● Connected to Railway (Production)";
            statusText.style.color = "#64ffda"; // لون الـ LightBlue بتاعك
        }
    } catch (error) {
        console.error("Connection Error:", error);
        statusText.innerText = "● Offline - Check Railway URL";
        statusText.style.color = "#f87171"; // أحمر في حالة الخطأ
    }
}

function updateUI(stats, data) {
    // 1. تحديث الكروت العلوية من الـ Stats اللي راجعة
    document.getElementById('total_users').innerText = stats.total_users || 0;
    document.getElementById('mild_cases').innerText = stats.mild_cases || 0;
    document.getElementById('moderate_cases').innerText = stats.moderate_cases || 0;
    document.getElementById('severe_cases').innerText = stats.severe_cases || 0;

    // 2. تحديث الجدول
    const tableBody = document.getElementById('diagnosis_table_body');
    tableBody.innerHTML = ''; 

    data.forEach(item => {
        const userName = item.user?.name || "Student";
        const stage = item.brain_rot_stage || "N/A";
        
        const row = `
            <tr class="hover:bg-white/5 transition border-b border-white/5">
                <td class="p-5">
                    <div class="flex items-center gap-3">
                        <div class="w-8 h-8 bg-lightBlue/10 text-lightBlue rounded-full flex items-center justify-center text-xs font-bold border border-lightBlue/20">
                            ${userName.charAt(0)}
                        </div>
                        <span class="font-bold text-white">${userName}</span>
                    </div>
                </td>
                <td class="p-5 text-textMain font-mono">${item.addiction_level} / 10</td>
                <td class="p-5">
                    <span class="px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider ${getStatusStyle(stage)}">
                        ${stage}
                    </span>
                </td>
                <td class="p-5 text-gray-500 text-sm">
                    ${new Date(item.diagnosed_at).toLocaleString('ar-EG')}
                </td>
            </tr>
        `;
        tableBody.innerHTML += row;
    });
}

function getStatusStyle(stage) {
    const s = stage.toLowerCase();
    if (s.includes('mild')) return 'bg-green-500/10 text-green-400 border border-green-500/20';
    if (s.includes('moderate')) return 'bg-yellow-500/10 text-yellow-400 border border-yellow-500/20';
    if (s.includes('severe')) return 'bg-red-500/10 text-red-400 border border-red-500/20';
    return 'bg-white/5 text-gray-400';
}

window.onload = fetchData;
