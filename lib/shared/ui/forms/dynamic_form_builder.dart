import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class DynamicFormBuilder extends StatefulWidget {
  final List<AttributeField> fields;
  final Map<String, dynamic> initialValues;
  final ValueChanged<Map<String, dynamic>>? onChanged;

  const DynamicFormBuilder({
    super.key,
    required this.fields,
    this.initialValues = const {},
    this.onChanged,
  });

  @override
  State<DynamicFormBuilder> createState() => DynamicFormBuilderState();
}

class DynamicFormBuilderState extends State<DynamicFormBuilder> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _values = {};
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, XFile> _files = {};
  final Map<String, String?> _validationErrors = {};

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  void _initValues() {
    for (final field in widget.fields) {
      final initial = widget.initialValues[field.key];
      _values[field.key] = initial ?? _defaultForType(field.type);
      if (field.type == 'text' || field.type == 'number') {
        _controllers[field.key] = TextEditingController(
          text: initial?.toString() ?? '',
        );
      }
    }
  }

  dynamic _defaultForType(String type) {
    switch (type) {
      case 'boolean':
        return false;
      case 'number':
        return null;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DynamicFormBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fields != widget.fields) {
      for (final controller in _controllers.values) {
        controller.dispose();
      }
      _controllers.clear();
      _files.clear();
      _initValues();
    }
  }

  Map<String, dynamic> get values => Map.unmodifiable(_values);
  Map<String, XFile> get files => Map.unmodifiable(_files);

  bool validate() {
    final errors = <String, String?>{};
    bool valid = true;

    for (final field in widget.fields) {
      final value = _values[field.key];
      final hasFile = _files.containsKey(field.key);
      String? error;

      if (field.required) {
        if (field.type == 'file') {
          if (!hasFile) {
            error = '${field.label} is required';
          }
        } else if (value == null || (value is String && value.isEmpty)) {
          error = '${field.label} is required';
        } else if (field.type == 'boolean' && value != true) {
          error = '${field.label} must be confirmed';
        }
      }

      if (error == null && value != null && field.type == 'number') {
        final numVal = num.tryParse(value.toString());
        if (numVal == null && value.toString().isNotEmpty) {
          error = '${field.label} must be a valid number';
        } else if (numVal != null) {
          if (field.min != null && numVal < field.min!) {
            error = '${field.label} must be at least ${field.min}';
          }
          if (field.max != null && numVal > field.max!) {
            error = '${field.label} must be at most ${field.max}';
          }
        }
      }

      if (error == null && value != null && field.type == 'select') {
        if (field.options != null &&
            !field.options!.contains(value.toString())) {
          error = 'Invalid option for ${field.label}';
        }
      }

      if (error != null) {
        errors[field.key] = error;
        valid = false;
      }
    }

    setState(() => _validationErrors
      ..clear()
      ..addAll(errors));
    return valid;
  }

  void _updateValue(String key, dynamic value) {
    setState(() {
      _values[key] = value;
      _validationErrors.remove(key);
    });
    widget.onChanged?.call(Map.unmodifiable(_values));
  }

  Future<void> _pickFile(AttributeField field) async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;

    setState(() {
      _files[field.key] = xFile;
      _values[field.key] = xFile.name;
      _validationErrors.remove(field.key);
    });
    widget.onChanged?.call(Map.unmodifiable(_values));
  }

  void _removeFile(AttributeField field) {
    setState(() {
      _files.remove(field.key);
      _values[field.key] = null;
      _validationErrors.remove(field.key);
    });
    widget.onChanged?.call(Map.unmodifiable(_values));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fields.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < widget.fields.length; i++) ...[
            _buildField(widget.fields[i], theme),
            if (i < widget.fields.length - 1) const Gap(AppSpacing.md),
          ],
        ],
      ),
    );
  }

  Widget _buildField(AttributeField field, ColorScheme theme) {
    switch (field.type) {
      case 'select':
        return _buildSelectField(field, theme);
      case 'boolean':
        return _buildBooleanField(field, theme);
      case 'number':
        return _buildNumberField(field, theme);
      case 'file':
        return _buildFileField(field, theme);
      default:
        return _buildTextField(field, theme);
    }
  }

  Widget _buildTextField(AttributeField field, ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(field, theme),
        const Gap(AppSpacing.xs),
        TextFormField(
          controller: _controllers[field.key],
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: theme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: 'Enter ${field.label.toLowerCase()}',
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: theme.primaryContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          onChanged: (v) => _updateValue(field.key, v),
        ),
        if (_validationErrors[field.key] != null)
          _buildErrorText(_validationErrors[field.key]!),
      ],
    );
  }

  Widget _buildNumberField(AttributeField field, ColorScheme theme) {
    final hint = field.min != null && field.max != null
        ? 'Enter ${field.label.toLowerCase()} (${field.min}-${field.max})'
        : 'Enter ${field.label.toLowerCase()}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(field, theme),
        const Gap(AppSpacing.xs),
        TextFormField(
          controller: _controllers[field.key],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: theme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: theme.primaryContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          onChanged: (v) {
            final parsed = num.tryParse(v);
            _updateValue(field.key, parsed);
          },
        ),
        if (_validationErrors[field.key] != null)
          _buildErrorText(_validationErrors[field.key]!),
      ],
    );
  }

  Widget _buildSelectField(AttributeField field, ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(field, theme),
        const Gap(AppSpacing.xs),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: _validationErrors[field.key] != null
                ? Border.all(color: AppColors.red)
                : null,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _values[field.key] as String?,
              isExpanded: true,
              hint: Text(
                'Select ${field.label.toLowerCase()}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              icon: Icon(Icons.arrow_drop_down, color: theme.onSurface),
              dropdownColor: theme.primaryContainer,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: theme.onSurface,
              ),
              items: (field.options ?? []).map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    _formatOption(option),
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) _updateValue(field.key, v);
              },
            ),
          ),
        ),
        if (_validationErrors[field.key] != null)
          _buildErrorText(_validationErrors[field.key]!),
      ],
    );
  }

  Widget _buildBooleanField(AttributeField field, ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text(
            field.label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: theme.onSurface,
            ),
          ),
          value: _values[field.key] as bool? ?? false,
          activeTrackColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
          onChanged: (v) => _updateValue(field.key, v),
        ),
        if (_validationErrors[field.key] != null)
          _buildErrorText(_validationErrors[field.key]!),
      ],
    );
  }

  Widget _buildFileField(AttributeField field, ColorScheme theme) {
    final hasFile = _files.containsKey(field.key);
    final fileName = hasFile ? _files[field.key]!.name : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(field, theme),
        const Gap(AppSpacing.xs),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: _validationErrors[field.key] != null
                ? Border.all(color: AppColors.red)
                : null,
          ),
          child: Row(
            children: [
              Icon(
                hasFile ? Icons.check_circle : Icons.upload_file,
                color: hasFile ? AppColors.green : AppColors.primary,
                size: 20,
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: hasFile
                    ? Text(
                        fileName,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        'No file selected',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
              ),
              const Gap(AppSpacing.sm),
              if (hasFile)
                SizedBox(
                  height: 36,
                  child: TextButton(
                    onPressed: () => _removeFile(field),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: Text(
                      'Remove',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: () => _pickFile(field),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    hasFile ? 'Change' : 'Choose File',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_validationErrors[field.key] != null)
          _buildErrorText(_validationErrors[field.key]!),
      ],
    );
  }

  Widget _buildLabel(AttributeField field, ColorScheme theme) {
    return Row(
      children: [
        Text(
          field.label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: theme.onSurface,
          ),
        ),
        if (field.required)
          Text(
            ' *',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.red,
            ),
          ),
      ],
    );
  }

  Widget _buildErrorText(String error) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        error,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.red,
        ),
      ),
    );
  }

  String _formatOption(String option) {
    return option
        .split('_')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}