import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/helpers.dart';

class AutoCompleteField extends StatelessWidget {
  final List? suggestions;
  final String? hint;
  final String? icon;
  final double? height;
  final TextEditingController? selectedSuggestion;
  final ValueChanged<String>? onChanged;
  final FutureOr<Iterable<Object?>> Function(String)? suggestionsCallback;
  final Function(dynamic)? onSuggestionSelected;
  final bool? isRequired;

  const AutoCompleteField(
      {Key? key,
      this.suggestions,
      this.selectedSuggestion,
      this.onChanged,
      this.hint,
      this.icon,
      this.height,
      this.suggestionsCallback,
      this.onSuggestionSelected,
      this.isRequired})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final required = isRequired ?? false;

    return SizedBox(
      height: height ?? 45,
      child: TypeAheadFormField(
        validator: (value) {
          return required ? Helpers.validateField(value!) : null;
        },
        itemBuilder: (context, item) => ListTile(
            title: Text(
          item.toString(),
          style: textTheme.headline4!.copyWith(color: textInputTitleColor),
        )),
        suggestionsCallback: suggestionsCallback ??
            (pattern) async {
              return suggestions!
                  .where((suggestion) => suggestion
                      .toString()
                      .toLowerCase()
                      .contains(pattern.toLowerCase()))
                  .toList();
            },
        onSuggestionSelected: onSuggestionSelected ??
            (value) {
              selectedSuggestion!.text = value.toString();
              onChanged!(value.toString());
            },
        getImmediateSuggestions: true,
        hideSuggestionsOnKeyboardHide: false,
        hideOnEmpty: false,
       // keepSuggestionsOnSuggestionSelected: true,
        noItemsFoundBuilder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'No Item Found',
            style: textTheme.headline4!.copyWith(color: textInputTitleColor),
          ),
        ),
        textFieldConfiguration: TextFieldConfiguration(
          style: textTheme.headline4!.copyWith(color: textWhiteColor),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0),
            hintText: hint,
            // label: Text(hint),
            hintStyle:
            textTheme.headline4?.copyWith(color: textWhiteColor),
            labelStyle: textTheme.headline4!.copyWith(color: textWhiteColor),
            border: InputBorder.none,
            /* suffixIcon: IconButton(
              icon: SvgPicture.asset(icon!),
              onPressed: () {},
            ),*/
            /*focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4))),*/
          ),
          controller: selectedSuggestion,
        ),
      ),
    );
  }
}
