/**
 * TROVO Dashboard Logic - Clean State for Database Integration
 */

document.addEventListener('alpine:init', () => {
    Alpine.data('dashboardApp', () => ({
        // الحالة العامة
        screen: 'overview',
        openProfile: false,
        appStatus: 'Online',
        
        // تصفير بيانات الطالب المختار
        selectedStudent: {
            name: '',
            code: '',
            level: 0,
            matrix: []
        },

        // الألوان ثابتة كما هي لأنها مرتبطة بالمنطق البصري
        barColors: [
            '#10b981', '#34d399', '#6ee7b7', 
            '#fbbf24', '#f59e0b', '#d97706', 
            '#f87171', '#ef4444', '#dc2626', '#7f1d1d' 
        ],

        // الـ 17 حقل الأساسية (مهمة جداً للربط مع الـ Database Columns)
        fields17: [
            'daily_usage_hours', 'screen_time_before_bed', 'phone_checks_per_day', 'apps_used_daily', 
            'time_on_social_media', 'time_on_gaming', 'weekend_usage_hours', 'sleep_hours', 
            'academic_performance', 'social_interactions', 'exercise_hours', 'anxiety_level', 
            'depression_level', 'self_esteem', 'time_on_education', 'gender', 'phone_usage_purpose'
        ],

        // تصفير الإحصائيات (Stats) استعداداً للـ Fetch
        stats: {
            total: 0,
            mild: 0,
            moderate: 0,
            severe: 0,
            avgLevel: 0
        },

        // تصفير أعمدة التوزيع (Distribution)
        distribution: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],

        // تصفير المؤشرات الرئيسية
        mainIssues: [
            { label: 'Doom Scrolling', val: 0 },
            { label: 'Sleep Loss', val: 0 },
            { label: 'Gaming Addiction', val: 0 }
        ],

        // تصفير مصفوفة البيانات السلوكية
        matrixData: [],

        /**
         * Actions & Integration Methods
         */

        // دالة لجلب اللون (تظل كما هي)
        getColor(level) {
            if(!level) return '#1e293b'; // لون افتراضي في حال انعدام الداتا
            let index = Math.min(Math.max(Math.round(level) - 1, 0), 9);
            return this.barColors[index];
        },

        // دالة جلب بيانات لوحة التحكم من الـ API (Laravel)
        async fetchDashboardData() {
            try {
                // مثال للربط:
                // let response = await fetch('/api/dashboard/stats');
                // let data = await response.json();
                // this.stats = data.stats;
                // this.distribution = data.distribution;
                console.log('Fetching data from Laravel...');
            } catch (error) {
                console.error('Error connecting to Database:', error);
            }
        },

        // فتح ملف طالب محدد وجلب بياناته
        async viewStudentProfile(studentId) {
            this.openProfile = true;
            // هنا يتم جلب بيانات الـ 17 حقل للطالب من قاعدة البيانات
            // let response = await fetch(`/api/students/${studentId}`);
            // this.selectedStudent = await response.json();
        },

        handleExcelUpload(event) {
            const file = event.target.files[0];
            if (file) {
                const extension = file.name.split('.').pop().toLowerCase();
                if (!['xlsx', 'xls', 'csv'].includes(extension)) {
                    alert('Invalid file format.');
                    event.target.value = ''; 
                } else {
                    // إرسال الملف للباكيند (Laravel Controller)
                    let formData = new FormData();
                    formData.append('file', file);
                    // fetch('/api/import-students', { method: 'POST', body: formData });
                }
            }
        },

        init() {
            console.log('TROVO Dashboard: Ready for Database Connection.');
            this.fetchDashboardData(); // استدعاء البيانات فور التحميل
        }
    }));
});