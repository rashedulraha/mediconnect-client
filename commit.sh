#!/usr/bin/env bash

set -e

echo "🚀 Starting Git repository initialization and step-by-step commits..."

# 1. Initialize Git repository if not already initialized
if [ ! -d ".git" ]; then
  echo "📦 Initializing git repository..."
  git init -b main
else
  echo "ℹ️  Git repository already initialized."
fi

# Ensure on current branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
echo "🌿 Current branch: $CURRENT_BRANCH"

# Helper function to stage and commit
commit_step() {
  local step_num="$1"
  local title="$2"
  local message="$3"
  shift 3
  local files=("$@")

  echo ""
  echo "▶️  [Step $step_num] $title"

  git add "${files[@]}"

  # Check if there are staged changes
  if git diff --cached --quiet; then
    echo "⚠️  No changes staged for step $step_num, skipping."
  else
    git commit -m "$message"
    echo "✅ Committed: $message"
  fi
}

# Step 1: Initial project configuration & tooling
commit_step 1 \
  "Initialize project configurations & dependencies" \
  "chore: initialize Next.js 16 project structure and tooling configs" \
  ".gitignore" \
  "package.json" \
  "bun.lock" \
  "tsconfig.json" \
  "next.config.ts" \
  "postcss.config.mjs" \
  "biome.json" \
  "components.json" \
  "README.md" \
  "AGENTS.md" \
  "CLAUDE.md" \
  "public/"

# Step 2: Global styling, root layout & brand assets
commit_step 2 \
  "Setup global styling and core app layout" \
  "feat(core): setup global styles, root layout, and brand assets" \
  "src/app/globals.css" \
  "src/app/layout.tsx" \
  "src/app/favicon.ico" \
  "src/assets/"

# Step 3: Shared types, utilities, and validation schemas
commit_step 3 \
  "Add core types, validation schemas, and utilities" \
  "feat(shared): add TypeScript definitions, utilities, and validation schemas" \
  "src/types/" \
  "src/utils/" \
  "src/lib/" \
  "src/validation/"

# Step 4: UI component primitives
commit_step 4 \
  "Add reusable UI component library" \
  "feat(ui): add Base UI and Shadcn reusable component library" \
  "src/components/ui/"

# Step 5: Routes and Providers
commit_step 5 \
  "Setup route definitions and application providers" \
  "feat(routes-providers): setup route configurations and application providers" \
  "src/routes/" \
  "src/providers/"

# Step 6: API client and React Query hooks
commit_step 6 \
  "Implement API services and custom query hooks" \
  "feat(api): implement api client services and React Query hooks" \
  "src/api/" \
  "src/hooks/"

# Step 7: Auth guards and dashboard shell
commit_step 7 \
  "Add auth guards and dashboard navigation shell" \
  "feat(auth-guard): add authentication guards and dashboard layout shell" \
  "src/components/auth/" \
  "src/components/dashboard/"

# Step 8: Marketing & landing page
commit_step 8 \
  "Implement public marketing layout and landing page" \
  "feat(marketing): implement public landing page and marketing layout" \
  "src/components/layout/public/" \
  "src/components/modules/homepage/" \
  "src/app/(public)/(marketing)/"

# Step 9: Authentication & onboarding forms and pages
commit_step 9 \
  "Implement authentication and doctor onboarding flows" \
  "feat(auth): add login, registration, and doctor application pages and forms" \
  "src/components/form/" \
  "src/components/modules/google-login/" \
  "src/app/(public)/(authentication)/"

# Step 10: Role-based dashboard views and doctor approval module
commit_step 10 \
  "Implement dashboard views and doctor approval workflow" \
  "feat(dashboard): implement role-based dashboard pages and doctor approval module" \
  "src/components/modules/doctor-approval/" \
  "src/app/(dashboard)/"

# Step 11: Commit script itself
commit_step 11 \
  "Add automated step-by-step commit script" \
  "chore: add step-by-step git commit script" \
  "commit.sh"

echo ""
echo "🎉 All step-by-step commits completed successfully!"
echo ""
git log --oneline --graph -n 12
