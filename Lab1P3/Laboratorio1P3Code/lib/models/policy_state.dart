class PolicyState {
  final String ownerName;
  final double insuranceValue;
  final String selectedModel;
  final String ageRange;
  final bool hasAccidents;
  final double calculatedCost;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final Map<String, dynamic>? searchResult;

  const PolicyState({
    this.ownerName = '',
    this.insuranceValue = 0.0,
    this.selectedModel = 'Modelo A',
    this.ageRange = '18-23',
    this.hasAccidents = false,
    this.calculatedCost = 0.0,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.searchResult,
  });

  PolicyState copyWith({
    String? ownerName,
    double? insuranceValue,
    String? selectedModel,
    String? ageRange,
    bool? hasAccidents,
    double? calculatedCost,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    Map<String, dynamic>? searchResult,
  }) {
    return PolicyState(
      ownerName: ownerName ?? this.ownerName,
      insuranceValue: insuranceValue ?? this.insuranceValue,
      selectedModel: selectedModel ?? this.selectedModel,
      ageRange: ageRange ?? this.ageRange,
      hasAccidents: hasAccidents ?? this.hasAccidents,
      calculatedCost: calculatedCost ?? this.calculatedCost,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      searchResult: searchResult,
    );
  }

  PolicyState clearMessages() {
    return copyWith(errorMessage: null, successMessage: null);
  }
}
