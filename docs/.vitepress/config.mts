import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "UltraViolet",
  description: "A light-weight ROBLOX UI State and UI Library",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Documentation', link: '/setup' }
    ],

    sidebar: [
      {
        text: 'Basic Setup',
        items: [
          { text: 'Setup', link: '/setup' },
          { text: 'Elements', link: '/elements' }
        ]
      },

      {
        text: 'Elements',
        items: [
          { text: 'Events', link: '/events' },
          { text: 'Animations', link: '/animations' }
        ]
      },

      {
        text: 'Components',
        items: [
          { text: 'Components', link: '/components' },
          { text: 'States', link: '/states' },
        ]
      },

      {
        text: 'Advanced',
        items: [
          { text: 'Warning', link: '/advanced/advanced'},
          { text: 'Setup Configuration', link: '/advanced/setupConfig' },
          { text: 'Fragments', link: '/advanced/fragments' },
          { text: 'API', link: '/advanced/api' },
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/ShadowsIndeedWhisper/UltraViolet-UI' }
    ]
  }
})
