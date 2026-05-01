/**
 * TROVO Intelligence System - Core Engine v7.0 (REFACTORED)
 * Project: Digital Dopamine Addiction Diagnosis AI
 * Status: Unified, cleaned, all API mismatches fixed
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
        token: localStorage.getItem('trovo_token'),
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
        // 3. DATA CONTAINERS
        // ==========================================
        students: [], 
        selectedStudent: {},
        
        // ==========================================
        // 4. FORM INTERACTION MODELS
        // ==========================================
        enrollForm: { 
            name: '', 
            phone_number: '', 
            student_code: '' 
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
        
        // ==========================================
        // 6. ANALYTICS & STATISTICAL MODELS
        // ==========================================
        stats: { 
            total_students: 0, 
            total_diagnoses: 0,
            addiction_rate: '0%',
            case_distribution: { mild: 0, moderate: 0, severe: 0 },
            top_impact_factors: [],
            recent_activity: []
        },
        
        // Pagination state
        currentPage: 1,
        lastPage: 1,
        totalRecords: 0,

        // ==========================================
        // 7. COMPUTED LOGIC (SEARCH & FILTER)
        // ==========================================
        filteredStudents() {
            if (!this.students || !this.students.length) return [];
            
            // لو مفيش بحث، رجع الكل
            if (!this.searchQuery) return this.students;
            
            const q = this.searchQuery.toLowerCase().trim();
            const filtered = this.students.filter(s => {
                const nameMatch = s.name?.toLowerCase().includes(q);
                const codeMatch = s.student_code?.toLowerCase().includes(q);
                return nameMatch || codeMatch;
            });

            console.log(`TROVO Filter: Query "${q}" | Before: ${this.students.length} | After: ${filtered.length}`);
            return filtered;
        },

        // ==========================================
        // 8. SYSTEM INITIALIZATION
        // ==========================================
        async init() {
            console.log('TROVO: System Initializing v7.0...');
            
            if (this.token) {
                axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                await this.checkAuthStatus();
            }
        },

        async checkAuthStatus() {
            try {
                const res = await axios.get(`${this.apiBase}/admin/me`);
                if (res.data) {
                    this.isLoggedIn = true;
                    this.userRole = res.data.role; 
                    this.currentUsername = res.data.username || res.data.name;
                    await this.fetchDashboardData();
                }
            } catch (e) { 
                console.log('TROVO: Session Expired. Re-authentication Required.'); 
                this.logoutSilently();
            }
        },

        // API base URL — computed property
        // API base URL — dynamic detection
        get apiBase() {
            const host = window.location.hostname;
            const isLocal = host === 'localhost' || host === '127.0.0.1' || host.startsWith('192.168.');
            // لو محلي، بنروح لبورت 8000 (بورت لارفيل الافتراضي)
            return isLocal 
                ? 'http://localhost:8000/api' 
                : 'https://trovo-project-production.up.railway.app/api';
        },

        // ==========================================
        // 9. CORE ACTIONS (LOGIN, SYNC, MANAGE)
        // ==========================================
        
        async performAdminAuth() {
            if (!this.loginForm.username || !this.loginForm.password) return;
            this.isLoading = true;
            this.errorMessage = '';

            try {
                const response = await axios.post(`${this.apiBase}/admin/login`, {
                    username: this.loginForm.username,
                    password: this.loginForm.password
                });

                const data = response.data;

                if (data.status === 'success' && data.access_token) {
                    this.token = data.access_token;
                    localStorage.setItem('trovo_token', this.token);
                    
                    axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                    
                    this.isLoggedIn = true;
                    this.userRole = data.admin.role; 
                    this.currentUsername = data.admin.username;
                    
                    localStorage.setItem('trovo_user', this.currentUsername);
                    localStorage.setItem('trovo_role', this.userRole);

                    await this.fetchDashboardData();
                    alert('IDENTITY VERIFIED: Welcome ' + (data.admin.name || 'Operator'));
                }
            } catch (error) {
                console.error('Login Failure:', error.response?.data);
                const errorMsg = error.response?.data?.message || 'Access Denied: Invalid Credentials';
                this.errorMessage = errorMsg;
            } finally {
                this.isLoading = false;
            }
        },

        async fetchDashboardData(page = 1) {
            if (!this.isLoggedIn) return;
            this.isLoading = true;
            this.currentPage = page;
            console.log(`TROVO: Fetching page ${page} from ${this.apiBase}...`);

            try {
                const [diagnosesRes, statsRes] = await Promise.all([
                    axios.get(`${this.apiBase}/admin/all-diagnoses?page=${page}`),
                    axios.get(`${this.apiBase}/admin/dashboard-stats`)
                ]);

                console.log('TROVO: API Raw Data:', diagnosesRes.data);

                // استخراج البيانات من Pagination لارفيل
                const apiResponse = diagnosesRes.data;
                const diagData = apiResponse.data;

                if (diagData && diagData.data) {
                    this.students = diagData.data;
                    console.log('TROVO: Students array populated with:', this.students.length, 'items');
                    this.currentPage = diagData.current_page || 1;
                    this.lastPage = diagData.last_page || 1;
                    this.totalRecords = diagData.total || 0;
                } else {
                    console.warn('TROVO: Unexpected API structure', apiResponse);
                    this.students = [];
                }
                
                if (statsRes.data?.stats) {
                    this.stats = statsRes.data.stats;
                }
                
            } catch (error) {
                console.error('TROVO: Sync Error:', error.response?.data || error.message);
                if (error.response?.status === 401) {
                    this.logoutSilently();
                }
            } finally {
                this.isLoading = false;
            }
        },

        async handleEnrollment() {
            if (!this.enrollForm.name || !this.enrollForm.student_code) return;
            this.isLoading = true;
            try {
                const response = await axios.post(`${this.apiBase}/admin/add-student-manual`, {
                    name: this.enrollForm.name,
                    phone_number: this.enrollForm.phone_number,
                    student_code: this.enrollForm.student_code 
                });

                if (response.data) {
                    await this.fetchDashboardData();
                    this.enrollForm = { name: '', phone_number: '', student_code: '' };
                    alert('STUDENT REGISTERED: Record successfully injected into database.');
                    this.screen = 'database';
                }
            } catch (error) {
                const msg = error.response?.data?.message || 'REGISTRATION ERROR: Security conflict or duplicate student code.';
                alert(msg);
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
                await axios.post(`${this.apiBase}/admin/import-students`, formData, {
                    headers: { 'Content-Type': 'multipart/form-data' }
                });
                await this.fetchDashboardData();
                alert('IMPORT COMPLETE: Neural records updated via bulk file.');
            } catch (e) {
                alert('IMPORT FAILED: Malformed Excel structure detected.');
            } finally {
                this.isLoading = false;
                event.target.value = '';
            }
        },

        async viewDetails(studentId) {
            this.isLoading = true;
            try {
                const res = await axios.get(`${this.apiBase}/admin/student/${studentId}`);
                this.selectedStudent = res.data?.data || res.data;
                this.openProfile = true;
            } catch (e) {
                alert('ACCESS DENIED: Detailed profile is locked or missing.');
            } finally {
                this.isLoading = false;
            }
        },

        async createAdmin() {
            if (!this.adminForm.username || !this.adminForm.password) return;
            this.isLoading = true;
            try {
                const res = await axios.post(`${this.apiBase}/admin/create-admin`, this.adminForm);
                alert(`Operator ${this.adminForm.username} authorized successfully.`);
                this.adminForm = { username: '', password: '' };
            } catch (err) {
                const msg = err.response?.data?.message || 'Authority error.';
                alert(msg);
            } finally {
                this.isLoading = false;
            }
        },

        // ==========================================
        // 10. UTILITY FUNCTIONS
        // ==========================================
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
                axios.post(`${this.apiBase}/admin/logout`).finally(() => {
                    this.clearAuthAndReload();
                });
            }
        },

        logoutSilently() {
            this.clearAuthAndReload();
        },

        clearAuthAndReload() {
            localStorage.removeItem('trovo_token');
            localStorage.removeItem('trovo_user');
            localStorage.removeItem('trovo_role');
            this.isLoggedIn = false;
            this.token = null;
            delete axios.defaults.headers.common['Authorization'];
            window.location.reload();
        }
    }));
});
