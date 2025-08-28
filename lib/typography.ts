// Typography system constants
export const typography = {
  // Font families
  fonts: {
    primary: "Inter, system-ui, sans-serif",
    mono: "ui-monospace, monospace",
  },

  // Font sizes (Tailwind classes)
  sizes: {
    // Display sizes
    "display-lg": "text-5xl", // 48px
    "display-md": "text-4xl", // 36px
    "display-sm": "text-3xl", // 30px

    // Heading sizes
    "heading-xl": "text-2xl", // 24px
    "heading-lg": "text-xl", // 20px
    "heading-md": "text-lg", // 18px
    "heading-sm": "text-base", // 16px

    // Body sizes
    "body-lg": "text-lg", // 18px
    "body-md": "text-base", // 16px
    "body-sm": "text-sm", // 14px
    "body-xs": "text-xs", // 12px

    // Special sizes
    "metric-xl": "text-4xl", // 36px for large metrics
    "metric-lg": "text-3xl", // 30px for metrics
    "metric-md": "text-2xl", // 24px for smaller metrics
  },

  // Font weights
  weights: {
    light: "font-light", // 300
    normal: "font-normal", // 400
    medium: "font-medium", // 500
    semibold: "font-semibold", // 600
    bold: "font-bold", // 700
    extrabold: "font-extrabold", // 800
  },

  // Line heights
  leading: {
    tight: "leading-tight", // 1.25
    normal: "leading-normal", // 1.5
    relaxed: "leading-relaxed", // 1.625
    loose: "leading-loose", // 2
  },

  // Letter spacing
  tracking: {
    tight: "tracking-tight", // -0.025em
    normal: "tracking-normal", // 0em
    wide: "tracking-wide", // 0.025em
  },
} as const

// Predefined text styles
export const textStyles = {
  // Page titles
  pageTitle: `${typography.sizes["display-sm"]} ${typography.weights.bold} text-green-800 ${typography.leading.tight}`,

  // Section headers
  sectionTitle: `${typography.sizes["heading-xl"]} ${typography.weights.bold} text-green-800 ${typography.leading.tight}`,

  // Card titles
  cardTitle: `${typography.sizes["heading-lg"]} ${typography.weights.semibold} text-green-800 ${typography.leading.normal}`,

  // Subsection titles
  subsectionTitle: `${typography.sizes["heading-md"]} ${typography.weights.semibold} text-green-800 ${typography.leading.normal}`,

  // Body text
  bodyLarge: `${typography.sizes["body-lg"]} ${typography.weights.normal} text-green-700 ${typography.leading.relaxed}`,
  bodyDefault: `${typography.sizes["body-md"]} ${typography.weights.normal} text-green-700 ${typography.leading.normal}`,
  bodySmall: `${typography.sizes["body-sm"]} ${typography.weights.normal} text-green-600 ${typography.leading.normal}`,

  // Helper text
  helperText: `${typography.sizes["body-xs"]} ${typography.weights.normal} text-green-500 ${typography.leading.normal}`,

  // Metrics
  metricLarge: `${typography.sizes["metric-xl"]} ${typography.weights.bold} text-green-600 ${typography.leading.tight}`,
  metricMedium: `${typography.sizes["metric-lg"]} ${typography.weights.bold} text-green-600 ${typography.leading.tight}`,
  metricSmall: `${typography.sizes["metric-md"]} ${typography.weights.bold} text-green-600 ${typography.leading.tight}`,

  // Labels
  labelLarge: `${typography.sizes["body-md"]} ${typography.weights.medium} text-green-700 ${typography.leading.normal}`,
  labelDefault: `${typography.sizes["body-sm"]} ${typography.weights.medium} text-green-700 ${typography.leading.normal}`,
  labelSmall: `${typography.sizes["body-xs"]} ${typography.weights.medium} text-green-600 ${typography.leading.normal}`,

  // Interactive elements
  buttonLarge: `${typography.sizes["body-lg"]} ${typography.weights.semibold} ${typography.leading.normal}`,
  buttonDefault: `${typography.sizes["body-md"]} ${typography.weights.semibold} ${typography.leading.normal}`,
  buttonSmall: `${typography.sizes["body-sm"]} ${typography.weights.medium} ${typography.leading.normal}`,

  // Navigation
  navItem: `${typography.sizes["body-sm"]} ${typography.weights.medium} ${typography.leading.normal}`,

  // Status indicators
  statusText: `${typography.sizes["body-sm"]} ${typography.weights.semibold} ${typography.leading.normal}`,
} as const
