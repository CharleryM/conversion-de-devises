# Currency Converter - Starter Kit

Welcome to the Currency Converter technical test! This starter kit provides a solid foundation with pre-configured architecture, models, and repositories, allowing you to focus on implementing the core functionality using Flutter's MVVM pattern with Provider.

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)

### Setup

1. **Get an API key** from [exchangerate-api.com](https://www.exchangerate-api.com/)

2. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env and add your API key
   ```

3. **Install and run**
   ```bash
   flutter pub get
   flutter run
   ```

## 📦 What's Provided

### ✅ Complete Files (Do Not Modify)
- [lib/config/](lib/config/) - App configuration (routing, theme, colors)
- [lib/models/](lib/models/) - Data models (Currency, ExchangeRateResponse)
- [lib/repositories/](lib/repositories/) - Data layer (API calls, persistence, caching)
- [lib/widgets/currency_selector.dart](lib/widgets/currency_selector.dart) - **Reference example** showing Provider patterns

### ⚠️ To Complete
- [lib/main.dart](lib/main.dart) - Setup ChangeNotifierProvider
- [lib/view_models/currency_converter_view_model.dart](lib/view_models/currency_converter_view_model.dart) - Implement business logic
- [lib/pages/currency_converter_page.dart](lib/pages/currency_converter_page.dart) - Build the UI

## 🎯 Implementation Tasks

### 1. Provider Setup ([main.dart](lib/main.dart))
- Uncomment and setup `ChangeNotifierProvider`
- Initialize `CurrencyConverterViewModel`
- Call `loadSavedCurrencies()` and `fetchExchangeRates()` on startup

### 2. ViewModel ([currency_converter_view_model.dart](lib/view_models/currency_converter_view_model.dart))
Implement the following:
- Private properties for state (input value, currencies, rates, loading, errors)
- Public getters to expose state
- Input management methods
- Currency selection and swap functionality
- API integration for fetching/refreshing rates

### 3. UI Implementation
Create:
- **Currency Selector Page** - List of currencies with search/selection
- **Main Converter Page** - Complete UI with:
  - Input field for amount
  - Currency selectors (from/to)
  - Swap button
  - Conversion result display
  - Exchange rate info
  - Refresh button
  - Loading/error states

**Study [currency_selector.dart](lib/widgets/currency_selector.dart)** to understand Provider patterns before building your UI.

## 💡 Key Concepts

### Provider Usage

**Use `context.watch<T>()` when displaying data (triggers rebuild):**
```dart
final viewModel = context.watch<CurrencyConverterViewModel>();
return Text('Rate: ${viewModel.exchangeRate}');
```

**Use `context.read<T>()` when calling methods (no rebuild):**
```dart
onPressed: () => context.read<CurrencyConverterViewModel>().swapCurrencies()
```

### MVVM Pattern
- **View**: Display data and capture input only
- **ViewModel**: Business logic, state management, calls repositories
- **Repository**: Data operations (API, storage)
- **Model**: Pure data classes

**Data Flow**: User action → ViewModel method → Update state → `notifyListeners()` → View rebuilds

## 🎨 Design

**Colors**: Use `AppColors.primary`, `AppColors.accent`, etc. (see [app_theme.dart](lib/config/app_theme.dart))
**Typography**: Access via `Theme.of(context).textTheme`
**Icons**: [Lucide Icons](https://pub.dev/packages/lucide_icons_flutter) - `LucideIcons.arrowLeftRight`, `LucideIcons.refreshCw`

## 💡 Tips

### Recommended: Native Keyboard
Use Flutter's `TextField` with `TextInputType.numberWithOptions(decimal: true)` - it's faster and professional.

### BONUS: Custom Keyboard (+10%)
Optional challenge if you finish early. Create a custom numeric keyboard widget. Not required for evaluation.

## 🔍 Common Issues

| Issue | Solution |
|-------|----------|
| "No ChangeNotifierProvider found" | Setup Provider in [main.dart](lib/main.dart) |
| UI doesn't update | Call `notifyListeners()` in ViewModel |
| API fails | Check `.env` file has valid API key |
| Too many rebuilds | Use `context.read<>()` for method calls |

**Debug commands**: `flutter clean`, `flutter pub get`, `flutter doctor`

## ✅ Checklist

**Functionality**
- [ ] Currency conversion works
- [ ] Currency selection (from/to)
- [ ] Swap currencies
- [ ] Fetch/refresh rates
- [ ] Persist selections
- [ ] Loading/error states

**Code Quality**
- [ ] Follows MVVM pattern
- [ ] Correct `watch` vs `read` usage
- [ ] Clean, organized code
- [ ] No errors/warnings

**UI/UX**
- [ ] Clean, intuitive layout
- [ ] Follows theme colors
- [ ] User-friendly errors

## 🎯 Evaluation

- **Architecture & Patterns (40%)** - MVVM, Provider, separation of concerns
- **Functionality (30%)** - Features work, error handling, persistence
- **Code Quality (20%)** - Clean, readable, best practices
- **UI/UX (10%)** - Intuitive, themed, good UX

**BONUS**: Custom keyboard (+10%), extra features (+5%), exceptional quality (+5%)

## 📚 Resources

- [Flutter Docs](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [GoRouter](https://pub.dev/packages/go_router)
- [Exchange Rate API](https://www.exchangerate-api.com/docs/overview)

---

**Estimated time: 8-10 hours** • Focus on MVVM/Provider understanding • Study the reference example • Test thoroughly • Good luck! 🚀
