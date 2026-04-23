// 1. حط لينك الـ Railway بتاعك هنا مكان النجوم
const BASE_URL = "https://your-project-name.railway.app/api"; 

async function fetchData() {
    const statusText = document.getElementById('sync-status');
    
    try {
        // بنكلم الـ Route الجديد اللي عملناه للأدمن
        const response = await fetch(`${BASE_URL}/admin/all-diagnoses`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                // لو عامل حماية بـ Token، حطه هنا، لو فاتحه عام للتجربة سيبه كدة
                // 'Authorization': 'Bearer YOUR_TOKEN' 
            }
        });

        const result = await response.json();

        if (result.status === 'success') {
            updateUI(result.stats, result.data);
            statusText.innerText = "● متصل ومحدث";
            statusText.classList.replace('text-gray-400', 'text-green-500');
        }
    } catch (error) {
        console.error("في مشكلة في الاتصال:", error);
        statusText.innerText = "● خطأ في الاتصال بالسيرفر";
        statusText.classList.replace('text-green-500', 'text-red-500');
    }
}

function updateUI(stats, data) {
    // تحديث الكروت بالأرقام الحقيقية من الداتابيز
    document.getElementById('total_users').innerText = stats.total_users;
    document.getElementById('mild_cases').innerText = stats.mild_cases;
    document.getElementById('moderate_cases').innerText = stats.moderate_cases;
    document.getElementById('severe_cases').innerText = stats.severe_cases;

    // تحديث الجدول
    const tableBody = document.getElementById('diagnosis_table_body');
    tableBody.innerHTML = ''; // تنظيف الجدول قبل العرض

    data.forEach(item => {
        const row = `
            <tr class="hover:bg-gray-50 transition">
                <td class="p-5 font-bold">${item.user.name}</td>
                <td class="p-5 text-gray-600">${item.addiction_level} / 10</td>
                <td class="p-5">
                    <span class="px-3 py-1 rounded-full text-xs font-bold ${getStatusStyle(item.brain_rot_stage)}">
                        ${item.brain_rot_stage.toUpperCase()}
                    </span>
                </td>
                <td class="p-5 text-left text-gray-400 text-sm">
                    ${new Date(item.diagnosed_at).toLocaleDateString('ar-EG')}
                </td>
            </tr>
        `;
        tableBody.innerHTML += row;
    });
}

function getStatusStyle(stage) {
    switch(stage) {
        case 'mild': return 'bg-green-100 text-green-700';
        case 'moderate': return 'bg-yellow-100 text-yellow-700';
        case 'severe': return 'bg-red-100 text-red-700';
        default: return 'bg-gray-100 text-gray-700';
    }
}

// أول ما الصفحة تحمل، اسحب الداتا فوراً
window.onload = fetchData;