Always read the `.ai-context.md` file first to understand the current project state, completed features, TODO items, and project requirements.

**Git Workflow**: Before working on any new feature, always create a new branch from main (or dev when available) using descriptive names like `feature/api-service-layer` or `fix/navbar-transparency`. Use the run_in_terminal tool to execute git commands like `git checkout -b feature/feature-name`.

After every significant change, update the `.ai-context.md` file by moving items from TODO to completed features, updating feature descriptions, and adding implementation details.

Follow Flutter best practices and maintain the terminal/coding aesthetic theme with responsive design for desktop and mobile.

Use withValues(alpha: x) instead of the deprecated withOpacity(x) method for color transparency in Flutter.

Ensure theme toggle functionality works with any new components and test changes on both dark and light themes.

The navbar uses dynamic transparency and blur effects, is completely invisible at page top, appears gradually on scroll, uses glassmorphism design with gradient fade transitions, and provides smooth scroll navigation between sections.

Use the fixed navbar approach - no floating navigation button.

This is a Flutter Web frontend with planned PHP + MariaDB backend on OCI, currently hosted on GitHub Pages with CI/CD via GitHub Actions.

When updating documentation, use completion status format: `- [x] Feature description` and include technical specifications like opacity values and transition distances.

Always explain what changes were made and why, reference context file updates in responses, and maintain professional yet creative tone matching the project aesthetic.

This is a personal portfolio project showcasing Netanel's skills as an Electrical Engineering student and DevOps/full-stack developer - keep implementation quality high and design cohesive with the established terminal/coding theme.
