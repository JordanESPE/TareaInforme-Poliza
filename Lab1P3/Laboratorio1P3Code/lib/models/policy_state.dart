class PolicyState {
  final String ownerName;
  final String ownerLastName;
  final double insuranceValue;
  final String selectedModel;
  final String ageRange;
  final int accidents;
  final double calculatedCost;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final Map<String, dynamic>? searchResult;

  const PolicyState({
    this.ownerName = '',
    this.ownerLastName = '',
    this.insuranceValue = 0.0,
    this.selectedModel = 'Modelo A',
    this.ageRange = '18-23',
    this.accidents = 0,
    this.calculatedCost = 0.0,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.searchResult,
  });

  PolicyState copyWith({
    String? ownerName,
    String? ownerLastName,
    double? insuranceValue,
    String? selectedModel,
    String? ageRange,
    int? accidents,
    double? calculatedCost,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    Map<String, dynamic>? searchResult,
    bool clearSearch = false, // Flag to explicitly clear search result
    bool clearError = false, // Flag to explicitly clear error message
    bool clearSuccess = false, // Flag to explicitly clear success message
  }) {
    return PolicyState(
      ownerName: ownerName ?? this.ownerName,
      ownerLastName: ownerLastName ?? this.ownerLastName,
      insuranceValue: insuranceValue ?? this.insuranceValue,
      selectedModel: selectedModel ?? this.selectedModel,
      ageRange: ageRange ?? this.ageRange,
      accidents: accidents ?? this.accidents,
      calculatedCost: calculatedCost ?? this.calculatedCost,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
      searchResult: clearSearch ? null : (searchResult ?? this.searchResult),
    );
  }

  PolicyState clearMessages() {
    return copyWith(clearError: true, clearSuccess: true);
  }
}
