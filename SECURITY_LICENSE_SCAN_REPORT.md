# Security & License Scan Report

**Scan date:** Generated from codebase analysis  
**Scope:** Entire codebase excluding `vendor/` and `node_modules/`

---

## 1. LICENSE-RELATED RESTRICTIONS & DATA TRANSFER

### 1.1 External license server (data sent off-site)

| Location | What is sent | Destination |
|----------|--------------|-------------|
| `app/Services/LicenseCore.php` | `purchase_code`, `domain`, `item_id` | **https://api.softentra.com** (hardcoded C5, C6) |
| `app/Services/LicenseValidationService.php` | `purchase_code`, `domain` | `config('services.license.server_url')` → **https://api.softentra.com** |
| `app/Console/Commands/LicensePingCommand.php` | `purchase_code`, `item_id` | Same server `/api/ping` |
| `config/services.php` | N/A (config only) | `server_url` = `https://api.softentra.com`, `item_id` = `40309046` |

**Endpoints called:**
- `POST /api/verify` – verify license (purchase_code, domain, item_id)
- `POST /api/activate` – activate (purchase_code, domain, item_id)
- `POST /api/deactivate` – deactivate (purchase_code, domain, item_id)
- `POST /api/ping` – daily ping (purchase_code, item_id) – **scheduled in `app/Console/Kernel.php`**

**Summary:** Purchase code and current domain are sent to `api.softentra.com` for license verification, activation, deactivation, and daily ping. This is standard license-check behavior but constitutes data transfer to a third-party server.

---

### 1.2 Remaining license-based restrictions in app logic

| File | Behavior |
|------|----------|
| `app/Http/Controllers/ReportController.php` | `generateMonthlyReport()` calls `abort(403, 'License Not Verified. This feature is disabled.')` if `KernelStatusService::isVerified()` is false. **Note:** This controller is not referenced in `routes/web.php`; only `ReportsController` is used for the `reports` route. So this is effectively dead code unless called elsewhere. |
| `app/Providers/AppServiceProvider.php` | Shares `license_invalid` with all views based on `KernelStatusService::isVerified()` (true = invalid). Used by frontend (e.g. `Layout.vue`) for optional UI. |
| `app/Services/KernelStatusService.php` | `isVerified()` returns `Cache::get('license_verification_status', false)`. So if license is never verified, this stays false. |

**Middleware (already relaxed in your setup):**
- `LicenseGuard.php` – License validation disabled; always `return $next($request)`.
- `AppIntegrityValidator.php` – Same; allows all through.

---

### 1.3 Background job and scheduled task

| Item | Purpose |
|------|---------|
| `app/Jobs/VerifyLicenseJob.php` | Calls `LicenseCore::check()`, which can perform HTTP request to api.softentra.com and cache result. |
| `app/Console/Kernel.php` | `$schedule->command('license:ping')->daily();` – runs daily and sends purchase_code + item_id to license server. |

---

## 2. MALFUNCTION / INTEGRITY CODE (POTENTIAL TO AFFECT SYSTEM)

### 2.1 CodeIntegrityChecker – expects deleted file

| File | Issue |
|------|--------|
| `app/Services/CodeIntegrityChecker.php` | `$criticalFiles` still includes `'app/Http/Controllers/LicenseController.php'` and `hasExpectedContent()` expects patterns from `LicenseController`. That file was removed; integrity check will always report "Missing critical file" and "Unexpected content" for it. Any code or test that relies on `CodeIntegrityChecker::checkIntegrity()` will see violations. |

**Recommendation:** Remove `LicenseController.php` from `CodeIntegrityChecker`’s `$criticalFiles` and from `$expectedPatterns` (see fixes below).

### 2.2 LicenseGuard integrity check

- `LicenseGuard::integrityCheck()` was already updated to **not** require `LicenseController.php`; it only checks `LicenseCore.php` and `LicenseGuard.php`. No change needed there.

### 2.3 No dangerous patterns found

- **No** `eval()`, `base64_decode()` on user input, `assert()`, or `preg_replace(..., '/e')` found in `app/`.
- No obvious backdoors or obfuscated execution in scanned code.

---

## 3. DATA LEAKAGE & EXTERNAL DATA TRANSFER

### 3.1 Outbound data (excluding license)

| Location | Data | Destination |
|----------|------|-------------|
| `app/Http/Controllers/SettingsController.php` | GET request (no user data in URL) | **https://gitlab.com** – `/api/v4/projects/44441130/releases` for update check (version, release info). No PII or purchase code. |
| Mail (EmailService, Listeners) | User emails, ticket/content as per app logic | Configured SMTP (user’s mail server). No evidence of sending to third-party analytics or unknown endpoints. |

### 3.2 Frontend (resources/js)

- All `fetch()` / `axios` / form posts target **relative URLs** (e.g. `route('...')`, `/dashboard`, `/chat/...`). No hardcoded external domains sending user data.
- No evidence of analytics or tracking scripts sending data to external servers in the scanned JS.

### 3.3 Summary

- **License-related data transfer:** Purchase code and domain to `https://api.softentra.com` (LicenseCore, LicenseValidationService, LicensePingCommand).
- **Other outbound:** GitLab for update check (no user/purchase data); mail via configured SMTP only.
- **No** evidence of secret data exfiltration, hidden form submissions to external URLs, or unauthorized bulk export to third parties in the scanned code.

---

## 4. RECOMMENDATIONS

1. **Remove or redirect license server usage if you don’t want any license checks**
   - Option A: Remove/disable `license:ping` from `app/Console/Kernel.php` schedule.
   - Option B: In `LicenseCore` and `LicenseValidationService`, short-circuit HTTP calls (e.g. return success or skip) so no request is sent to api.softentra.com.
   - Option C: Leave as-is if you still want optional license verification later.

2. **Fix CodeIntegrityChecker**
   - Remove `app/Http/Controllers/LicenseController.php` from `$criticalFiles` and from `hasExpectedContent()` patterns so integrity checks don’t fail due to the deleted file.

3. **Optional: Clean up dead license UI / reporting**
   - `ReportController::generateMonthlyReport()` is not routed; remove or repurpose if you want to avoid any license-gated logic.
   - `license_invalid` in `AppServiceProvider` and `Layout.vue` can be kept for future use or removed if you no longer need license-related UI.

4. **Config**
   - `config/services.php` and `LicenseCore` (constants C5, C6) both reference api.softentra.com and item_id. If you stop using the license server, you can leave config as-is or clear/comment it for clarity.

---

## 5. FILES INVOLVED (QUICK REFERENCE)

**License / verification / ping:**
- `app/Services/LicenseCore.php`
- `app/Services/LicenseValidationService.php`
- `app/Services/KernelStatusService.php`
- `app/Console/Commands/LicensePingCommand.php`
- `app/Jobs/VerifyLicenseJob.php`
- `app/Console/Kernel.php` (schedule)
- `config/services.php`

**Middleware (currently permissive):**
- `app/Http/Middleware/LicenseGuard.php`
- `app/Http/Middleware/AppIntegrityValidator.php`

**Restriction / shared state:**
- `app/Http/Controllers/ReportController.php` (unused in routes)
- `app/Providers/AppServiceProvider.php`
- `resources/js/Shared/Layout.vue` (license_invalid)

**Integrity (needs update):**
- `app/Services/CodeIntegrityChecker.php`

**External HTTP (non-license):**
- `app/Http/Controllers/SettingsController.php` (GitLab releases)
