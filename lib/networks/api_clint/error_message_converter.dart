import 'dart:convert';

String convertValidationErrorsToReadable(dynamic errors) {
  // Step 1: Parse JSON string if necessary
  Map<String, dynamic> errorMap;
  if (errors is String) {
    try {
      errorMap = json.decode(errors) as Map<String, dynamic>;
    } catch (_) {
      return '';
    }
  } else if (errors is Map<String, dynamic>) {
    errorMap = errors;
  } else {
    return '';
  }

  // Step 2: Build readable lines
  final lines = <String>[];
  errorMap.forEach((field, messages) {
    // Normalize to list of strings
    final msgList = (messages is List)
        ? messages.map((e) => e.toString()).toSet().toList()
        : [messages.toString()];

    // Format field name (snake_case or camelCase → Human readable)
    final formattedField = field
        .replaceAllMapped(RegExp(r'(_)|([A-Z])'), (m) {
          if (m[1] != null) return ' '; // underscore
          return ' ${m[2]}'; // camelCase capital
        })
        .trim()
        .replaceFirstMapped(RegExp(r'^\w'), (m) => m.group(0)!.toUpperCase());

    // Join messages
    lines.add('$formattedField: ${msgList.join("; ")}');
  });

  // Step 3: Join with newline
  return lines.join('\n');
}
