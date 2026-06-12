/**
 * TROVO Intelligence System — Core Engine v10.0
 * Digital Dopamine Addiction Diagnosis AI Dashboard
 */
document.addEventListener('alpine:init', () => {
    Alpine.data('dashboardApp', () => ({
        // === AUTH ===
        isLoggedIn: false,
        currentUsername: '',
        errorMessage: '',
        token: localStorage.getItem('trovo_token'),
        loginForm: { username: '', password: '' },

        // === UI ===
        screen: 'requests',
        isLoading: false,
        currentFilter: 'all',
        openProfile: false,
        toastMsg: '',
        toastType: 'success',

        // === STUDENTS ===
        students: [],
        studentsPage: 1,
        studentsLastPage: 1,
        studentsTotal: 0,
        studentSearch: '',
        pendingCount: 0,

        // === DIAGNOSES ===
        diagnoses: [],
        diagPage: 1,
        diagLastPage: 1,
        diagTotal: 0,
        diagSearch: '',

        // === STATS ===
        stats: {
            total_students: 0, total_diagnoses: 0, avg_addiction_level: 0,
            addiction_rate: '0%',
            case_distribution: { mild: 0, moderate: 0, severe: 0 },
            level_distribution: {}, top_impact_factors: [], recent_activity: []
        },

        // === FEATURES ===
        featureData: null,

        // === PROFILE ===
        selectedStudent: {},

        // === ENROLLMENT ===
        enrollForm: { name: '', email: '', password: '' },

        // === MINIGAMES ===
        miniGameStats: null,
        selectedGameType: 'all',

        // === API BASE ===
        get apiBase() {
            const h = window.location.hostname;
            const p = window.location.protocol;
            // file:// protocol (opened locally) or localhost/LAN → use local backend
            const isLocal = !h || h === 'localhost' || h === '127.0.0.1' || h.startsWith('192.168.') || p === 'file:';
            return isLocal
                ? 'http://localhost:8000/api'
                : 'https://trovo-project-production.up.railway.app/api';
        },

        // === INIT ===
        async init() {
            if (this.token) {
                axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                await this.checkAuthStatus();
            }
        },

        async checkAuthStatus() {
            try {
                const res = await axios.get(`${this.apiBase}/admin/me`);
                if (res.data?.status === 'success') {
                    this.isLoggedIn = true;
                    this.currentUsername = res.data.username || res.data.name;
                    await this.fetchAllData();
                }
            } catch (e) {
                this.logoutSilently();
            }
        },

        // === LOGIN ===
        async performAdminAuth() {
            if (!this.loginForm.username || !this.loginForm.password) return;
            this.isLoading = true;
            this.errorMessage = '';
            try {
                const res = await axios.post(`${this.apiBase}/admin/login`, {
                    username: this.loginForm.username,
                    password: this.loginForm.password
                });
                const data = res.data;
                if (data.status === 'success' && data.access_token) {
                    this.token = data.access_token;
                    localStorage.setItem('trovo_token', this.token);
                    axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                    this.isLoggedIn = true;
                    this.currentUsername = data.admin.username || data.admin.name;
                    localStorage.setItem('trovo_user', this.currentUsername);
                    await this.fetchAllData();
                }
            } catch (error) {
                this.errorMessage = error.response?.data?.message || 'Access Denied: Invalid Credentials';
            } finally {
                this.isLoading = false;
            }
        },

        // === FETCH ALL ===
        async fetchAllData() {
            if (!this.isLoggedIn) return;
            this.isLoading = true;
            try {
                await Promise.all([
                    this.fetchStats(), this.fetchStudents(),
                    this.fetchDiagnoses(), this.fetchFeatures(),
                    this.fetchMiniGames()
                ]);
            } catch (e) {
                if (e.response?.status === 401) this.logoutSilently();
            } finally {
                this.isLoading = false;
            }
        },

        async fetchStats() {
            try {
                const res = await axios.get(`${this.apiBase}/admin/dashboard-stats`, {
                    params: { filter: this.currentFilter }
                });
                if (res.data?.stats) this.stats = res.data.stats;
                this.fetchPendingCount();
            } catch (e) { console.error('Stats error:', e.message); }
        },

        async fetchPendingCount() {
            try {
                const res = await axios.get(`${this.apiBase}/admin/all-students`, {
                    params: { filter: 'pending', page: 1 }
                });
                if (res.data?.data) this.pendingCount = res.data.data.total || 0;
            } catch (e) { /* silent */ }
        },

        async fetchStudents(page = 1) {
            try {
                const res = await axios.get(`${this.apiBase}/admin/all-students`, {
                    params: { filter: this.currentFilter, search: this.studentSearch, page }
                });
                if (res.data?.data) {
                    const d = res.data.data;
                    this.students = d.data || [];
                    this.studentsPage = d.current_page || 1;
                    this.studentsLastPage = d.last_page || 1;
                    this.studentsTotal = d.total || 0;
                }
            } catch (e) { console.error('Students error:', e.message); }
        },

        async fetchDiagnoses(page = 1) {
            try {
                const res = await axios.get(`${this.apiBase}/admin/all-diagnoses`, {
                    params: { filter: this.currentFilter, search: this.diagSearch, page }
                });
                if (res.data?.data) {
                    const d = res.data.data;
                    this.diagnoses = d.data || [];
                    this.diagPage = d.current_page || 1;
                    this.diagLastPage = d.last_page || 1;
                    this.diagTotal = d.total || 0;
                }
            } catch (e) { console.error('Diagnoses error:', e.message); }
        },

        async fetchFeatures() {
            try {
                const res = await axios.get(`${this.apiBase}/admin/feature-averages`, {
                    params: { filter: this.currentFilter }
                });
                if (res.data?.data) this.featureData = res.data.data;
            } catch (e) { console.error('Features error:', e.message); }
        },

        async fetchMiniGames() {
            try {
                const res = await axios.get(`${this.apiBase}/admin/mini-game-stats`, {
                    params: { filter: this.currentFilter }
                });
                if (res.data?.data) this.miniGameStats = res.data.data;
            } catch (e) { console.error('MiniGames error:', e.message); }
        },

        // === STUDENT ACTIONS ===
        async approveStudent(id) {
            this.isLoading = true;
            try {
                await axios.post(`${this.apiBase}/admin/student/${id}/approve`);
                this.showToast('Student approved successfully', 'success');
                await this.refreshAfterAction();
            } catch (e) {
                this.showToast(e.response?.data?.message || 'Failed', 'error');
            } finally { this.isLoading = false; }
        },

        async rejectStudent(id) {
            this.isLoading = true;
            try {
                await axios.post(`${this.apiBase}/admin/student/${id}/reject`);
                this.showToast('Student approval revoked', 'success');
                await this.refreshAfterAction();
            } catch (e) {
                this.showToast(e.response?.data?.message || 'Failed', 'error');
            } finally { this.isLoading = false; }
        },

        async deleteStudent(id, name) {
            if (!confirm(`Delete student "${name}" and ALL their data permanently?`)) return;
            this.isLoading = true;
            try {
                await axios.delete(`${this.apiBase}/admin/student/${id}`);
                if (this.selectedStudent?.id === id) {
                    this.openProfile = false;
                    this.selectedStudent = {};
                }
                this.showToast('Student deleted permanently', 'success');
                await this.refreshAfterAction();
            } catch (e) {
                this.showToast(e.response?.data?.message || 'Failed', 'error');
            } finally { this.isLoading = false; }
        },

        async deleteDiagnosis(id) {
            if (!confirm('Delete this diagnosis record permanently?')) return;
            this.isLoading = true;
            try {
                await axios.delete(`${this.apiBase}/admin/diagnosis/${id}`);
                this.showToast('Diagnosis deleted', 'success');
                await this.refreshAfterAction();
                if (this.openProfile && this.selectedStudent?.id) {
                    await this.viewProfile(this.selectedStudent.id);
                }
            } catch (e) {
                this.showToast(e.response?.data?.message || 'Failed', 'error');
            } finally { this.isLoading = false; }
        },

        // === PROFILE ===
        async viewProfile(studentId) {
            this.isLoading = true;
            try {
                const res = await axios.get(`${this.apiBase}/admin/student/${studentId}`);
                this.selectedStudent = res.data?.data || {};
                this.openProfile = true;
            } catch (e) {
                this.showToast('Could not load student profile', 'error');
            } finally { this.isLoading = false; }
        },

        // === ENROLLMENT ===
        async handleEnrollment() {
            if (!this.enrollForm.name || !this.enrollForm.email) {
                this.showToast('Please fill name and email', 'error');
                return;
            }
            this.isLoading = true;
            try {
                await axios.post(`${this.apiBase}/admin/add-student-manual`, {
                    name: this.enrollForm.name,
                    email: this.enrollForm.email,
                    password: this.enrollForm.password
                });
                this.enrollForm = { name: '', email: '', password: '' };
                this.showToast('Student account created (auto-approved)', 'success');
                await this.refreshAfterAction();
                this.screen = 'requests';
            } catch (error) {
                this.showToast(error.response?.data?.message || 'Registration failed', 'error');
            } finally { this.isLoading = false; }
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
                await this.refreshAfterAction();
                this.showToast('Bulk import completed (all auto-approved)', 'success');
            } catch (e) {
                this.showToast('Import failed — check Excel format', 'error');
            } finally {
                this.isLoading = false;
                event.target.value = '';
            }
        },

        // === MAINTENANCE ===
        async toggleMaintenance(action) {
            const msg = action === 'down'
                ? 'Enable maintenance mode? Students will be locked out.'
                : 'Disable maintenance mode? Students can access again.';
            if (!confirm(msg)) return;
            this.isLoading = true;
            try {
                const res = await axios.post(`${this.apiBase}/admin/toggle-maintenance`, { action });
                this.showToast(res.data?.message || 'Done', 'success');
            } catch (e) {
                this.showToast(e.response?.data?.message || 'Failed', 'error');
            } finally { this.isLoading = false; }
        },

        // === EXPORT ===
        exportData(type) {
            const url = `${this.apiBase}/admin/export/${type}?filter=${this.currentFilter}`;
            fetch(url, { headers: { 'Authorization': `Bearer ${this.token}` } })
                .then(r => r.blob())
                .then(blob => {
                    const a = document.createElement('a');
                    a.href = window.URL.createObjectURL(blob);
                    a.download = `trovo_${type}_${new Date().toISOString().slice(0,10)}.csv`;
                    document.body.appendChild(a);
                    a.click();
                    a.remove();
                    window.URL.revokeObjectURL(a.href);
                })
                .catch(() => this.showToast('Export failed', 'error'));
        },

        // === NAV & FILTER ===
        switchScreen(s) { this.screen = s; },

        async setFilter(f) {
            this.currentFilter = f;
            this.isLoading = true;
            try {
                await Promise.all([
                    this.fetchStats(), this.fetchStudents(),
                    this.fetchDiagnoses(), this.fetchFeatures(),
                    this.fetchMiniGames()
                ]);
            } finally { this.isLoading = false; }
        },

        // === REFRESH ===
        async refreshAfterAction() {
            await Promise.all([
                this.fetchStats(), this.fetchStudents(this.studentsPage),
                this.fetchDiagnoses(this.diagPage), this.fetchFeatures(),
                this.fetchMiniGames()
            ]);
        },

        // === TOAST ===
        showToast(msg, type = 'success') {
            this.toastMsg = msg;
            this.toastType = type;
            setTimeout(() => { this.toastMsg = ''; }, 3000);
        },

        // === UTILS ===
        formatDate(dateStr) {
            if (!dateStr) return '—';
            const d = new Date(dateStr);
            if (isNaN(d.getTime())) return '—';
            return d.toLocaleDateString('en-US', {
                year: 'numeric', month: 'short', day: 'numeric',
                hour: '2-digit', minute: '2-digit'
            });
        },

        getBarHeight(count) {
            if (!count) return 4;
            const dist = this.stats.level_distribution || {};
            const maxCount = Math.max(...Object.values(dist), 1);
            return Math.max(4, Math.round((count / maxCount) * 160));
        },

        getBarClass(level) {
            const lvl = parseInt(level);
            if (lvl <= 3) return 'bar-green';
            if (lvl <= 6) return 'bar-amber';
            return 'bar-red';
        },

        getStageClass(stage) {
            if (!stage) return '';
            const s = stage.toLowerCase();
            if (s.includes('mild')) return 'stage-mild';
            if (s.includes('moderate')) return 'stage-moderate';
            if (s.includes('severe')) return 'stage-severe';
            return '';
        },

        getLevelClass(level) {
            if (level <= 3) return 'level-low';
            if (level <= 6) return 'level-mid';
            return 'level-high';
        },

        // === SESSION ===
        logout() {
            if (confirm('Logout?')) {
                this.isLoading = true;
                axios.post(`${this.apiBase}/admin/logout`).finally(() => {
                    this.clearAuthAndReload();
                });
            }
        },

        logoutSilently() { this.clearAuthAndReload(); },

        clearAuthAndReload() {
            localStorage.removeItem('trovo_token');
            localStorage.removeItem('trovo_user');
            this.isLoggedIn = false;
            this.token = null;
            delete axios.defaults.headers.common['Authorization'];
            window.location.reload();
        }
    }));
});
