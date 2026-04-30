/**
 * TROVO Intelligence System - Core Engine v6.1 (STABLE REVISION)
 * Project: Digital Dopamine Addiction Diagnosis AI
 * Status: Unified Variable Naming & Auth Keys Sync - FINAL PRODUCTION READY
 */

document.addEventListener('alpine:init', () => {
    Alpine.data('dashboardApp', () => ({
        // ==========================================
        // 1. AUTHENTICATION & SECURITY STATE
        // ==========================================
        isLoggedIn: false,
        userRole: null, 
        currentUsername: '',
        errorMessage: '',
        // استخدام المفتاح الموحد trovo_admin_token للتخزين المحلي
        token: localStorage.getItem('trovo_admin_token'),
        loginForm: { 
            username: '', 
            password: '' 
        },
        
        // ==========================================
        // 2. UI NAVIGATION & GLOBAL STATES
        // ==========================================
        screen: 'overview',
        isLoading: false, 
        openProfile: false,
        searchQuery: '',

        // ==========================================
        // 3. DATA CONTAINERS (NEURAL REPOSITORY)
        // ==========================================
        students: [], 
        admins: [],   
        selectedStudent: {},
        
        // ==========================================
        // 4. FORM INTERACTION MODELS
        // ==========================================
        enrollForm: { 
            name: '', 
            phone: '', 
            code: '' 
        },
        adminForm: { 
            username: '', 
            password: '' 
        },

        // ==========================================
        // 5. PROJECT CONFIGURATION & CORE METRICS
        // ==========================================
        barColors: [
            '#10b981', '#34d399', '#6ee7b7', '#fbbf24', '#f59e0b', 
            '#d97706', '#f87171', '#ef4444', '#dc2626', '#7f1d1d'
        ],
        
        fields17: [
            'daily_usage_hours', 'screen_time_before_bed', 'phone_checks_per_day', 
            'apps_used_daily', 'time_on_social_media', 'time_on_gaming', 
            'weekend_usage_hours', 'sleep_hours', 'academic_performance', 
            'social_interactions', 'exercise_hours', 'anxiety_level', 
            'depression_level', 'self_esteem', 'time_on_education', 
            'gender', 'phone_usage_purpose'
        ],

        // ==========================================
        // 6. ANALYTICS & STATISTICAL MODELS
        // ==========================================
        stats: { 
            total: 0, 
            mild: 0, 
            moderate: 0, 
            severe: 0, 
            avgLevel: 0 
        },
        distribution: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        mainIssues: [
            { label: 'Dopamine Loop', val: 0 },
            { label: 'Circadian Rhythm', val: 0 },
            { label: 'Neural Threshold', val: 0 }
        ],

        // ==========================================
        // 7. COMPUTED LOGIC (SEARCH & FILTER)
        // ==========================================
        get filteredStudents() {
            if (!this.searchQuery) return this.students;
            const q = this.searchQuery.toLowerCase();
            return this.students.filter(s => 
                (s.student?.name?.toLowerCase().includes(q)) || 
                (s.student?.student_code?.toLowerCase().includes(q))
            );
        },

        // ==========================================
        // 8. SYSTEM INITIALIZATION
        // ==========================================
        async init() {
            console.log('TROVO: System Synchronizing (Full Spectrum)...');
            
            axios.defaults.baseURL = 'https://trovo-project-production.up.railway.app';
            
            if (this.token) {
                axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                await this.checkAuthStatus();
            }
        },

        async checkAuthStatus() {
            try {
                const res = await axios.get('/api/admin/me');
                if (res.data) {
                    this.isLoggedIn = true;
                    // مطابقة المسميات مع رد الميدل وير والكنترولر (userRole و username)
                    this.userRole = res.data.role; 
                    this.currentUsername = res.data.username || res.data.name;
                    await this.syncDataWithProduction();
                }
            } catch (e) { 
                console.log('TROVO: Session Expired. Re-authentication Required.'); 
                this.logoutSilently();
            }
        },

        // ==========================================
        // 9. CORE ACTIONS (LOGIN, SYNC, MANAGE)
        // ==========================================
        
        async performAdminAuth() {
            if (!this.loginForm.username || !this.loginForm.password) return;
            this.isLoading = true;
            this.errorMessage = '';

            try {
                // إرسال طلب تسجيل الدخول للمسار الصحيح
                const response = await axios.post('/api/admin/login', {
                    username: this.loginForm.username,
                    password: this.loginForm.password
                });

                const data = response.data;

                // مطابقة رد الكنترولر: status === 'success' و access_token
                if (data.status === 'success' && data.access_token) {
                    this.token = data.access_token;
                    localStorage.setItem('trovo_admin_token', this.token);
                    
                    // تحديث هيدر الأوثنتيكيشن فوراً للطلبات القادمة
                    axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                    
                    this.isLoggedIn = true;
                    
                    // الوصول لبيانات الأدمن من مفتاح 'admin' كما في الكنترولر وصورة بوست مان
                    this.userRole = data.admin.role; 
                    this.currentUsername = data.admin.username;
                    
                    // تخزين إضافي للتأكد من استقرار الجلسة عبر الصفحات
                    localStorage.setItem('trovo_user', this.currentUsername);
                    localStorage.setItem('trovo_role', this.userRole);

                    await this.syncDataWithProduction();
                    alert('IDENTITY VERIFIED: Welcome ' + (data.admin.name || 'Super Operator'));
                }
            } catch (error) {
                console.error('Login Failure:', error.response?.data);
                // عرض الرسالة القادمة من الـ CheckAdmin Middleware أو الكنترولر (رسائل عربية/إنجليزية)
                const errorMsg = error.response?.data?.message || 'Access Denied: Invalid Credentials';
                alert(errorMsg);
                this.errorMessage = errorMsg;
            } finally {
                this.isLoading = false;
            }
        },

        async syncDataWithProduction() {
            if (!this.isLoggedIn) return;
            this.isLoading = true;
            try {
                const [studentRes, statsRes] = await Promise.all([
                    axios.get('/api/admin/all-diagnoses'),
                    axios.get('/api/admin/dashboard-stats')
                ]);

                this.students = studentRes.data;
                this.applyServerStats(statsRes.data);
                this.recalculateLocalAnalytics();
                
            } catch (error) {
                console.error('TROVO Sync Error:', error);
            } finally {
                this.isLoading = false;
            }
        },

        async handleEnrollment() {
            if (!this.enrollForm.name || !this.enrollForm.phone || !this.enrollForm.code) return;
            this.isLoading = true;
            try {
                const response = await axios.post('/api/admin/add-student-manual', {
                    name: this.enrollForm.name,
                    phone: this.enrollForm.phone,
                    student_code: this.enrollForm.code 
                });

                if (response.data) {
                    await this.syncDataWithProduction();
                    this.enrollForm = { name: '', phone: '', code: '' };
                    alert('STUDENT REGISTERED: Record successfully injected into database.');
                    this.screen = 'database';
                }
            } catch (error) {
                alert('REGISTRATION ERROR: Security conflict or duplicate student code.');
            } finally {
                this.isLoading = false;
            }
        },

        async handleBulkImport(event) {
            const file = event.target.files[0];
            if (!file) return;

            const formData = new FormData();
            formData.append('file', file); 

            this.isLoading = true;
            try {
                await axios.post('/api/admin/import-students', formData, {
                    headers: { 'Content-Type': 'multipart/form-data' }
                });
                await this.syncDataWithProduction();
                alert('IMPORT COMPLETE: Neural records updated via bulk file.');
            } catch (e) {
                alert('IMPORT FAILED: Malformed Excel structure detected.');
            } finally {
                this.isLoading = false;
                event.target.value = ''; // إعادة تعيين الحقل
            }
        },

        // ==========================================
        // 10. DIAGNOSTIC ANALYTICS ENGINE
        // ==========================================
        applyServerStats(serverData) {
            if (serverData.stats) {
                this.stats = serverData.stats;
            }
        },

        recalculateLocalAnalytics() {
            const count = this.students.length;
            if (count === 0) return;

            this.stats.total = count;
            this.stats.mild = this.students.filter(s => s.score <= 30).length;
            this.stats.moderate = this.students.filter(s => s.score > 30 && s.score <= 70).length;
            this.stats.severe = this.students.filter(s => s.score > 70).length;
            
            let dist = new Array(10).fill(0);
            this.students.forEach(s => {
                let lvl = Math.ceil(s.score / 10); 
                if (lvl >= 1 && lvl <= 10) dist[lvl - 1]++;
            });
            this.distribution = dist;
        },

        async openSubjectDossier(studentId) {
            this.isLoading = true;
            try {
                const res = await axios.get(`/api/admin/student/${studentId}`);
                this.selectedStudent = res.data;
                this.openProfile = true;
            } catch (e) {
                alert('ACCESS DENIED: Detailed neural profile is locked or missing.');
            } finally {
                this.isLoading = false;
            }
        },

        getColor(score) {
            let index = Math.min(Math.max(Math.floor(score / 10), 0), 9);
            return this.barColors[index];
        },

        // ==========================================
        // 11. SESSION CONTROL
        // ==========================================
        logout() {
            if (confirm('Terminate Session and Purge Local Auth Cache?')) {
                this.isLoading = true;
                axios.post('/api/admin/logout').finally(() => {
                    this.clearAuthAndReload();
                });
            }
        },

        logoutSilently() {
            this.clearAuthAndReload();
        },

        clearAuthAndReload() {
            localStorage.removeItem('trovo_admin_token');
            localStorage.removeItem('trovo_user');
            localStorage.removeItem('trovo_role');
            this.isLoggedIn = false;
            this.token = null;
            window.location.reload();
        }
    }));
});
