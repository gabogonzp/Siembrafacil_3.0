import type React from "react"
import { cn } from "@/lib/utils"
import { textStyles } from "@/lib/typography"
import type { JSX } from "react/jsx-runtime" // Declare JSX variable

interface TypographyProps {
  children: React.ReactNode
  className?: string
  as?: keyof JSX.IntrinsicElements
}

// Page Title Component
export function PageTitle({ children, className, as: Component = "h1" }: TypographyProps) {
  return <Component className={cn(textStyles.pageTitle, className)}>{children}</Component>
}

// Section Title Component
export function SectionTitle({ children, className, as: Component = "h2" }: TypographyProps) {
  return <Component className={cn(textStyles.sectionTitle, className)}>{children}</Component>
}

// Card Title Component
export function CardTitle({ children, className, as: Component = "h3" }: TypographyProps) {
  return <Component className={cn(textStyles.cardTitle, className)}>{children}</Component>
}

// Body Text Components
export function BodyLarge({ children, className, as: Component = "p" }: TypographyProps) {
  return <Component className={cn(textStyles.bodyLarge, className)}>{children}</Component>
}

export function BodyText({ children, className, as: Component = "p" }: TypographyProps) {
  return <Component className={cn(textStyles.bodyDefault, className)}>{children}</Component>
}

export function BodySmall({ children, className, as: Component = "p" }: TypographyProps) {
  return <Component className={cn(textStyles.bodySmall, className)}>{children}</Component>
}

// Helper Text Component
export function HelperText({ children, className, as: Component = "span" }: TypographyProps) {
  return <Component className={cn(textStyles.helperText, className)}>{children}</Component>
}

// Metric Components
export function MetricLarge({ children, className, as: Component = "div" }: TypographyProps) {
  return <Component className={cn(textStyles.metricLarge, className)}>{children}</Component>
}

export function MetricMedium({ children, className, as: Component = "div" }: TypographyProps) {
  return <Component className={cn(textStyles.metricMedium, className)}>{children}</Component>
}

// Label Components
export function Label({ children, className, as: Component = "label" }: TypographyProps) {
  return <Component className={cn(textStyles.labelDefault, className)}>{children}</Component>
}

export function LabelLarge({ children, className, as: Component = "label" }: TypographyProps) {
  return <Component className={cn(textStyles.labelLarge, className)}>{children}</Component>
}
