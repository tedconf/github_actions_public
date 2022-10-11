# 1.0.2 (2022-10-11)
- Fixes ruby gem CI by adding conditionals for:
  - db creation
  - brakeman

# 1.0.1 (2022-10-11)
- Adds `main` branch to CD workflows

# 1.0.0 (2022-10-10)
- Separates CI and CD by moving workflows into separate (nested) ymls
- Within CI workflows, splits static analyses (audit, rubocop) from unit tests
- Fixes installation of system dependencies by bumping `setup-ruby` to 1.0.2
