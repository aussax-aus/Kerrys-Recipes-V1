# Contributing to My Kitchen Book

Thank you for your interest in contributing to My Kitchen Book! This is primarily a personal project, but contributions are welcome.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Device/platform information

### Suggesting Features

Feature requests are welcome! Please:
- Check existing issues first
- Describe the feature clearly
- Explain the use case
- Consider the scope and complexity

### Code Contributions

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
   - Follow the existing code style
   - Add tests for new features
   - Update documentation
4. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   flutter format lib/
   ```
5. **Commit your changes**
   ```bash
   git commit -m "Add: Brief description of changes"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Open a Pull Request**
   - Describe what you changed and why
   - Reference any related issues
   - Include screenshots for UI changes

## Development Setup

See [DEVELOPMENT.md](DEVELOPMENT.md) for detailed setup instructions.

Quick start:
```bash
git clone https://github.com/aussax-aus/Kerrys-Recipes-V1.git
cd Kerrys-Recipes-V1
flutter pub get
flutter run
```

## Code Style

### Dart/Flutter Guidelines
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter format` before committing
- Fix all `flutter analyze` warnings
- Add comments for complex logic
- Use meaningful variable names

### File Organization
```
lib/
├── models/      # Data models only
├── services/    # Business logic, no UI
├── providers/   # State management
├── screens/     # Full-screen widgets
├── widgets/     # Reusable components
└── utils/       # Helpers and utilities
```

### Commit Messages
- Use clear, descriptive messages
- Start with a verb: Add, Fix, Update, Remove
- Keep first line under 50 characters
- Add details in the body if needed

Examples:
```
Add: Recipe export to PDF feature
Fix: Timer not stopping in cooking mode
Update: Dark mode color scheme
Remove: Deprecated Firebase methods
```

## Testing

### Required Tests
- Unit tests for models
- Unit tests for services
- Widget tests for new UI components

### Running Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/recipe_test.dart
```

## Documentation

### Required Updates
- Update README.md if adding major features
- Update FEATURES.md for new capabilities
- Add inline code comments for complex logic
- Update CHANGELOG.md

### Documentation Style
- Clear and concise
- Include code examples
- Add screenshots for UI changes
- Keep formatting consistent

## Pull Request Process

1. **Before Submitting:**
   - Ensure all tests pass
   - Run `flutter analyze` with no errors
   - Format code with `flutter format`
   - Update documentation
   - Add changelog entry

2. **PR Description:**
   - What: What changes were made
   - Why: Why these changes were needed
   - How: How the changes work
   - Testing: How you tested the changes
   - Screenshots: For UI changes

3. **Review Process:**
   - Maintainer will review your PR
   - Address any feedback or questions
   - Make requested changes
   - PR will be merged when approved

## Areas Looking for Contributions

### High Priority
- [ ] OCR implementation for recipe scanning
- [ ] Voice dictation integration
- [ ] PDF export functionality
- [ ] Photo picker implementation
- [ ] Import recipes from files

### Medium Priority
- [ ] Recipe sharing features
- [ ] Nutrition information calculator
- [ ] Meal planning features
- [ ] Shopping list generation
- [ ] Recipe scaling calculator

### Enhancement Ideas
- [ ] Improved search algorithms
- [ ] Recipe recommendations
- [ ] Ingredient substitutions database
- [ ] Unit conversion helper
- [ ] Multiple language support
- [ ] Accessibility improvements
- [ ] Tablet layouts
- [ ] Watch app integration

## Community Guidelines

### Be Respectful
- Be kind and courteous
- Respect differing opinions
- Accept constructive criticism
- Help others learn

### Be Constructive
- Provide helpful feedback
- Suggest improvements
- Share knowledge
- Celebrate successes

## Questions?

- Check existing documentation
- Search closed issues
- Open a discussion issue
- Ask in pull request

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be acknowledged in:
- CHANGELOG.md
- README.md (for significant contributions)
- Git commit history

Thank you for contributing to My Kitchen Book! 🎉
