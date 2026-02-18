<?php

function translations($json) {
    if(!file_exists($json)) {
        return [];
    }
    return json_decode(file_get_contents($json), true);
}

if (! function_exists('language_path')) {
    /**
     * Get the path to the language folder.
     *
     * @param  string  $path
     * @return string
     */
    function language_path($path = '')
    {
        return base_path('lang'.($path ? DIRECTORY_SEPARATOR.$path : $path));
    }
}

if (!function_exists('static_asset')) {
    /**
     * Generate an asset path for the application.
     *
     * @param string $path
     * @param bool|null $secure
     * @return string
     */
    function static_asset($path, $secure = null) {
        return app('url')->asset('public/' . $path, $secure);
    }
}

function isActive($route, $className = 'active') {
    if (is_array($route)) {
        return in_array(Route::currentRouteName(), $route) ? $className : '';
    }
    if (Route::currentRouteName() == $route) {
        return $className;
    }
    if (strpos(URL::current(), $route)) {
        return $className;
    }
}

if (!function_exists('setting')) {
    /**
     * Get a setting value from the database.
     *
     * @param  string  $key
     * @param  mixed  $default
     * @return mixed
     */
    function setting($key, $default = null) {
        try {
            // Check if database is available
            if (!\Illuminate\Support\Facades\DB::connection()->getPdo()) {
                return $default;
            }
            
            $settings = \Illuminate\Support\Facades\Cache::remember('app_settings', now()->addMinutes(60), function () {
                try {
                    $settings = \App\Models\Setting::all();
                    $settingsArray = [];
                    
                    foreach ($settings as $setting) {
                        // Decode JSON values for JSON type settings
                        if ($setting->type === 'json' && $setting->value) {
                            $settingsArray[$setting->slug] = json_decode($setting->value, true);
                        } else {
                            $settingsArray[$setting->slug] = $setting->value;
                        }
                    }
                    
                    return $settingsArray;
                } catch (\Exception $e) {
                    \Illuminate\Support\Facades\Log::error('Failed to fetch settings from database', ['error' => $e->getMessage()]);
                    return [];
                }
            });
            
            return $settings[$key] ?? $default;
        } catch (\Exception $e) {
            // Silently return default if database is not available (e.g., during installation)
            return $default;
        }
    }
}
