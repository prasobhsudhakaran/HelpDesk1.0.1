<?php

namespace App\Http\Middleware;

use App\Models\Setting;
use App\Services\LicenseValidationService;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Schema;

class AppIntegrityValidator
{
    protected $licenseService;

    public function __construct(LicenseValidationService $licenseService)
    {
        $this->licenseService = $licenseService;
    }

    public function handle(Request $request, Closure $next)
    {
        // Skip license validation for installer routes
        if ($this->isInstallerRoute($request)) {
            return $next($request);
        }

        // Skip license validation if database is not connected or settings table doesn't exist
        if (! $this->isDatabaseConnected() || ! Schema::hasTable('settings')) {
            return $next($request);
        }

        // Allow installer and other routes (license UI removed)
        $allowedRoutes = [
            'installer.index',
            'installer.check-requirements',
            'installer.test-database',
            'installer.save-environment',
            'installer.run-installation',
        ];

        if (in_array(Route::currentRouteName(), $allowedRoutes)) {
            return $next($request);
        }

        // Skip license validation for public routes (landing pages, etc.)
        if ($this->isPublicRoute($request)) {
            return $next($request);
        }

        // License validation disabled – allow through
        return $next($request);
    }

    private function isDatabaseConnected(): bool
    {
        try {
            DB::connection()->getPdo();
            return true;
        } catch (\Exception $e) {
            return false;
        }
    }

    private function isInstallerRoute(Request $request): bool
    {
        return $request->is('install*') || $request->is('update*');
    }

    private function isPublicRoute(Request $request): bool
    {
        $publicRoutes = [
            '/',
            'home',
            'terms_service',
            'privacy',
            'contact',
            'services',
            'faq',
            'team',
            'kb',
            'blog',
            'login',
            'register',
            'password.request',
            'password.reset',
            'password.email',
            'password.update',
            'verification.notice',
            'verification.verify',
            'verification.resend',
        ];

        $currentRoute = Route::currentRouteName();
        return in_array($currentRoute, $publicRoutes) || $request->is('public/*');
    }

}
