<template>
    <img v-if="name === 'white'" class="logo w-auto h-auto max-w-[180px] max-h-10" :src="whiteLogoPath" alt="Logo">
    <img v-else class="logo w-auto h-auto max-w-[180px] max-h-10" :src="mainLogoPath" alt="Logo" />
</template>
<script>
export default {
    props: {
        name: String,
    },
    computed: {
        mainLogoPath() {
            try {
                // Get logo path from settings, fallback to default
                const settings = this.$page?.props?.settings || {};
                const logoSetting = settings.main_logo;
                
                // If it's a string (flat structure from middleware)
                if (typeof logoSetting === 'string' && logoSetting.trim()) {
                    return logoSetting;
                }
                
                // If it's an object with value property (nested structure from SettingsController)
                if (logoSetting && typeof logoSetting === 'object' && logoSetting.value) {
                    const value = logoSetting.value;
                    if (typeof value === 'string' && value.trim()) {
                        return value;
                    }
                }
            } catch (e) {
                console.warn('Error getting main logo path:', e);
            }
            
            // Fallback to default
            return '/images/logo.png';
        },
        whiteLogoPath() {
            try {
                // Get white logo path from settings, fallback to default
                const settings = this.$page?.props?.settings || {};
                const logoWhiteSetting = settings.main_logo_white;
                
                // If it's a string (flat structure from middleware)
                if (typeof logoWhiteSetting === 'string' && logoWhiteSetting.trim()) {
                    return logoWhiteSetting;
                }
                
                // If it's an object with value property (nested structure from SettingsController)
                if (logoWhiteSetting && typeof logoWhiteSetting === 'object' && logoWhiteSetting.value) {
                    const value = logoWhiteSetting.value;
                    if (typeof value === 'string' && value.trim()) {
                        return value;
                    }
                }
            } catch (e) {
                console.warn('Error getting white logo path:', e);
            }
            
            // Fallback to default
            return '/images/logo_white.png';
        },
    },
}
</script>
