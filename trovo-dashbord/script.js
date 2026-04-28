/**
 * TROVO Dashboard Logic
 * Handling Screen Switching, Data Rendering, and UI Interactivity
 */

document.addEventListener('alpine:init', () => {
    Alpine.data('dashboardApp', () => ({
        screen: 'overview',
        openProfile: false,
        selectedStudent: {},
        
        // ألوان الأعمدة المتدرجة (ليفل من 1 لـ 10)
        barColors: [
            '#00f5d4', '#00e0c2', '#00cbb0', 
            '#fee440', '#ffcf33', '#ffbc26', 
            '#ff70a6', '#ff477e', '#ff0a54', '#7c0021'
        ],

        // بيانات تجريبية (سيتم استبدالها لاحقاً ببيانات من Laravel API)
        stats: {
            total: 1248,
            mild: 452,
            moderate: 512,
            severe: 284,
            avgLevel: 6.7
        },

        // دالة لفتح ملف الطالب وعرض بيانات الـ 17 حقل
        viewStudentProfile(studentData) {
            this.selectedStudent = studentData;
            this.openProfile = true;
        },

        // دالة لحساب ارتفاع العمود بناءً على الداتا
        getBarHeight(count, max) {
            return (count / max) * 100 + '%';
        },

        // تهيئة البيانات عند تحميل الصفحة
        init() {
            console.log('TROVO Dashboard Initialized...');
            // هنا ممكن مستقبلاً تعمل Fetch للداتا من الباكيند
        }
    }));
});

// دالة إضافية للتعامل مع رفع ملفات الإكسيل (Validation بسيط)
function handleExcelUpload(event) {
    const file = event.target.files[0];
    if (file) {
        const extension = file.name.split('.').pop().toLowerCase();
        if (extension !== 'xlsx' && extension !== 'xls' && extension !== 'csv') {
            alert('Please upload a valid Excel or CSV file.');
            event.target.value = ''; // Reset input
        } else {
            console.log('File ready for processing:', file.name);
            // هنا هننادي الـ Route بتاع Laravel اللي بيعمل Import
        }
    }
}