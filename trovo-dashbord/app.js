const BASE_URL = "http://127.0.0.1:8000/api"; 

async function fetchData() {
    const statusText = document.getElementById('sync-status');
    
    try {
        const response = await fetch(`${BASE_URL}/admin/all-diagnoses`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'ngrok-skip-browser-warning': 'true' // مهم جداً لـ Ngrok
            }
        });

        const result = await response.json();

        if (result.status === 'success') {
            updateUI(result.stats, result.data);
            statusText.innerText = "● متصل ومحدث";
            statusText.classList.replace('text-red-500', 'text-green-500');
            statusText.classList.replace('text-gray-400', 'text-green-500');
        }
    } catch (error) {
        console.error("في مشكلة في الاتصال:", error);
        statusText.innerText = "● خطأ في الاتصال بالسيرفر";
        statusText.classList.add('text-red-500');
    }
}

function updateUI(stats, data) {
    // تحديث الكروت
    document.getElementById('total_users').innerText = stats.total_users || 0;
    document.getElementById('mild_cases').innerText = stats.mild_cases || 0;
    document.getElementById('moderate_cases').innerText = stats.moderate_cases || 0;
    document.getElementById('severe_cases').innerText = stats.severe_cases || 0;

    const tableBody = document.getElementById('diagnosis_table_body');
    tableBody.innerHTML = ''; 

    data.forEach(item => {
        const userName = item.user?.name || "مستخدم غير معروف";
        const row = `
            <tr class="hover:bg-gray-50 transition border-b border-gray-50">
                <td class="p-5">
                    <div class="flex items-center gap-3">
                        <div class="w-8 h-8 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center text-xs font-bold">
                            ${userName.charAt(0)}
                        </div>
                        <span class="font-bold">${userName}</span>
                    </div>
                </td>
                <td class="p-5 text-gray-600 font-mono">${item.addiction_level} / 10</td>
                <td class="p-5">
                    <span class="px-3 py-1 rounded-full text-xs font-bold ${getStatusStyle(item.brain_rot_stage)}">
                        ${item.brain_rot_stage.toUpperCase()}
                    </span>
                </td>
                <td class="p-5 text-left text-gray-400 text-sm">
                    ${new Date(item.diagnosed_at).toLocaleString('ar-EG')}
                </td>
            </tr>
        `;
        tableBody.innerHTML += row;
    });
}

function getStatusStyle(stage) {
    switch(stage?.toLowerCase()) {
        case 'mild': return 'bg-green-100 text-green-700';
        case 'moderate': return 'bg-yellow-100 text-yellow-700';
        case 'severe': return 'bg-red-100 text-red-700';
        default: return 'bg-gray-100 text-gray-700';
    }
}

window.onload = fetchData;