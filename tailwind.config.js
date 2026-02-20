const colors = require('tailwindcss/colors')
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
    content: [
    // prettier-ignore
    './resources/**/*.blade.php',
    './resources/**/*.js',
    './resources/**/*.vue',
  ],
    darkMode: ['class', '[data-mode="dark"]'],
    // important: true,
    safelist: [
        'bg-slate-800',
        'bg-slate-900',
    ],
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      // Include all default colors
      ...colors,
      // Custom colors - using slate instead of gray to avoid deprecation warnings
      // gray: colors.slate, // This is now the default
      indigo: {
        100: '#e6e8ff',
        300: '#b2b7ff',
        400: '#7886d7',
        500: '#6574cd',
        600: '#5661b3',
        800: '#2f365f',
        900: '#191e38',
      },
      // SOD Infotech logo primary (bright cyan-blue – from logo)
      primary: {
        DEFAULT: '#00AEEF',
        50: '#e6f9fd',
        100: '#b3ecfa',
        200: '#80dff6',
        300: '#4dd2f2',
        400: '#1ac5ee',
        500: '#00AEEF',
        600: '#008bc0',
        700: '#006891',
        800: '#004562',
        900: '#002233',
        950: '#001119',
      },
      // SOD Infotech logo secondary (charcoal gray – “Request a Consultation” style)
      accent: {
        50: '#f5f5f5',
        100: '#e5e5e5',
        200: '#c4c4c4',
        300: '#a3a3a3',
        400: '#818181',
        500: '#5E5E5E',
        600: '#4b4b4b',
        700: '#383838',
        800: '#262626',
        900: '#131313',
        950: '#0a0a0a',
      },
    },
      screens: {
          xs: '540px',
          sm: '640px',
          md: '768px',
          lg: '1024px',
          xl: '1280px',
          '2xl': '1536px',
      },
      fontFamily: {
          'nunito': ['"Nunito", sans-serif'],
      },
    extend: {
        colors: {
            'dark': '#3c4858',
            'black': '#161c2d',
            'dark-footer': '#192132',
        },
      borderColor: {
        DEFAULT: 'rgb(229 231 235)',
      },
      fontFamily: {
        sans: ['Cerebri Sans', ...defaultTheme.fontFamily.sans],
      },
      animation: {
        'fade-in': 'fadeIn 0.5s ease-in-out',
        'slide-up': 'slideUp 0.5s ease-out',
        'bounce-slow': 'bounce 2s infinite',
        'pulse-slow': 'pulse 3s infinite',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(20px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
      },
      backdropBlur: {
        xs: '2px',
      },
      boxShadow: {
        outline: '0 0 0 2px rgb(0 174 239)',
        sm: '0 2px 4px 0 rgb(60 72 88 / 0.15)',
        DEFAULT: '0 0 3px rgb(60 72 88 / 0.15)',
        md: '0 5px 13px rgb(60 72 88 / 0.20)',
        lg: '0 10px 25px -3px rgb(60 72 88 / 0.15)',
        xl: '0 20px 25px -5px rgb(60 72 88 / 0.1), 0 8px 10px -6px rgb(60 72 88 / 0.1)',
        '2xl': '0 25px 50px -12px rgb(60 72 88 / 0.25)',
        inner: 'inset 0 2px 4px 0 rgb(60 72 88 / 0.05)',
        testi: '2px 2px 2px -1px rgb(60 72 88 / 0.15)',
      },
      fill: {
        current: 'currentColor',
      },
        spacing: {
            0.75: '0.1875rem',
            3.25: '0.8125rem'
        },

        maxWidth: {
            '1200': '71.25rem',
            '992': '60rem',
            '768': '45rem',
        },

        zIndex: {
            1: '1',
            2: '2',
            3: '3',
            999: '999',
        },
    },
  },
  plugins: [
      require('@tailwindcss/typography'),
      require('@tailwindcss/forms'),
      require('@tailwindcss/aspect-ratio'),
  ],
}
