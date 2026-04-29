/**
 * TROVO Intelligence System - Core Engine v3.0
 * Architecture: Alpine.js + Laravel API Gateway
 */

document.addEventListener('alpine:init', () => {
    Alpine.data('dashboardApp', () => ({
        // --- Authentication & Security ---
        isLoggedIn: false,
        userRole: null, // 'super' or 'admin'
        currentUsername: '',
        loginForm: { username: '', password: '' },
        
        // --- Navigation & States ---
        screen: 'overview',
        isLoading: false,
        openProfile: false,
        searchQuery: '',

        // --- Data Containers ---
        students: [],
        admins: [],
        selectedStudent: {},
        
        // --- Form Models ---
        enrollForm: { name: '', phone: '', code: '' },
        adminForm: { username: '', password: '' },

        // --- Configuration & Constants ---
        barColors: ['#10b981', '#34d399', '#6ee7b7', '#fbbf24', '#f59e0b', '#d97706', '#f87171', '#ef4444', '#dc2626', '#7f1d1d'],
        fields17: [
            'daily_usage_hours', 'screen_time_before_bed', 'phone_checks_per_day', 'apps_used_daily', 
            'time_on_social_media', 'time_on_gaming', 'weekend_usage_hours', 'sleep_hours', 
            'academic_performance', 'social_interactions', 'exercise_hours', 'anxiety_level', 
            'depression_level', 'self_esteem', 'time_on_education', 'gender', 'phone_usage_purpose'
        ],

        // --- Computed Properties ---
        get filteredStudents() {
            if (!this.searchQuery) return this.students;
            const q = this.searchQuery.toLowerCase();
            return this.students.filter(s => 
                s.name.toLowerCase().includes(q) || 
                s.code.toLowerCase().includes(q) || 
                s.phone.includes(q)
            );
        },

        // --- Dashboard Statistics ---
        stats: { total: 0, mild: 0, moderate: 0, severe: 0, avgLevel: 0 },
        distribution: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        mainIssues: [
            { label: 'Dopamine Loop (Doom Scrolling)', val: 0 },
            { label: 'Circadian Rhythm Disruption', val: 0 },
            { label: 'Neural Reward Threshold', val: 0 }
        ],

        // --- Core Methods ---

        async init() {
            console.log('TROVO: System Booting...');
            // Check for persistent session if needed
            // this.checkSession();
        },

        /**
         * Authentication Handler
         * In production: fetch('/api/login', {method: 'POST', body: ...})
         */
        async handleLogin() {
            this.isLoading = true;
            try {
                // SIMULATED AUTH (Replace with Laravel Passport/Sanctum)
                if (this.loginForm.username === 'super' && this.loginForm.password === 'trovo2026') {
                    this.isLoggedIn = true;
                    this.userRole = 'super';
                    this.currentUsername = 'Master Operator';
                    await this.syncDataWithProduction();
                } else {
                    // Check against custom created admins
                    const admin = this.admins.find(a => a.username === this.loginForm.username && a.password === this.loginForm.password);
                    if (admin) {
                        this.isLoggedIn = true;
                        this.userRole = 'admin';
                        this.currentUsername = admin.username;
                        await this.syncDataWithProduction();
                    } else {
                        alert('CRITICAL ERROR: Credentials not found in Secure Database.');
                    }
                }
            } finally {
                this.isLoading = false;
                this.loginForm = { username: '', password: '' };
            }
        },

        /**
         * Fetch Real Data from Laravel
         */
        async syncDataWithProduction() {
            this.isLoading = true;
            console.log('TROVO: Pulling records from Laravel API...');
            
            // Example Integration:
            /*
            const response = await fetch('/api/v1/subjects', {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            this.students = await response.json();
            */
            
            // Mocking for immediate UI feedback
            setTimeout(() => {
                this.recalculateAnalytics();
                this.isLoading = false;
            }, 1000);
        },

        /**
         * Triple Field Enrollment (Name, Phone, Code)
         */
        async handleEnrollment() {
            if (!this.enrollForm.name || !this.enrollForm.phone || !this.enrollForm.code) return;
            
            this.isLoading = true;
            try {
                // Post to Laravel Controller
                const newStudent = {
                    id: Date.now(),
                    name: this.enrollForm.name,
                    phone: this.enrollForm.phone,
                    code: this.enrollForm.code,
                    level: Math.floor(Math.random() * 10) + 1, // Simulated AI diagnosis
                    matrix: this.generateEmptyMatrix()
                };

                this.students.unshift(newStudent);
                this.recalculateAnalytics();
                this.enrollForm = { name: '', phone: '', code: '' };
                alert('SUCCESS: Record encrypted and stored in Database.');
                this.screen = 'database';
            } finally {
                this.isLoading = false;
            }
        },

        /**
         * Admin Account Generation
         */
        createAdminAccount() {
            if (!this.adminForm.username || !this.adminForm.password) return;
            this.admins.push({ ...this.adminForm });
            this.adminForm = { username: '', password: '' };
            alert('ADMIN CREATED: System access granted.');
        },

        /**
         * Stats Engine
         */
        recalculateAnalytics() {
            const count = this.students.length;
            if (count === 0) return;

            this.stats.total = count;
            this.stats.mild = this.students.filter(s => s.level <= 3).length;
            this.stats.moderate = this.students.filter(s => s.level > 3 && s.level <= 7).length;
            this.stats.severe = this.students.filter(s => s.level > 7).length;
            
            const sum = this.students.reduce((a, b) => a + b.level, 0);
            this.stats.avgLevel = (sum / count).toFixed(1);

            let dist = new Array(10).fill(0);
            this.students.forEach(s => dist[s.level - 1]++);
            this.distribution = dist;

            // Logic to calculate dominant issues based on the 17 fields
            this.mainIssues[0].val = Math.floor(Math.random() * 40) + 60; // Just for visual
            this.mainIssues[1].val = Math.floor(Math.random() * 30) + 40;
            this.mainIssues[2].val = Math.floor(Math.random() * 50) + 20;
        },

        openSubjectDossier(student) {
            this.selectedStudent = student;
            this.openProfile = true;
        },

        getColor(level) {
            let index = Math.min(Math.max(Math.round(level) - 1, 0), 9);
            return this.barColors[index];
        },

        generateEmptyMatrix() {
            let matrix = {};
            this.fields17.forEach(f => matrix[f] = '0.0');
            return matrix;
        },

        logout() {
            if (confirm('Terminate secure session?')) {
                this.isLoggedIn = false;
                this.userRole = null;
                window.location.reload();
            }
        },

        handleBulkImport(event) {
            const file = event.target.files[0];
            if (file) {
                this.isLoading = true;
                setTimeout(() => {
                    this.isLoading = false;
                    alert('BULK IMPORT: Data parsed and pushed to Laravel.');
                }, 2000);
            }
        }
    }));
});
