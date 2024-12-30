import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
  });

  final ValueChanged onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;
  late String _query;

  void _onChanged(String query) {
    setState(() => _query = query);
    widget.onChanged(query);
  }

  void _clear() {
    setState(() {
      _query = '';
      _controller.clear();
    });
    widget.onChanged('');
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _query = '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      decoration: InputDecoration(
        filled: true,
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _query != ''
            ? IconButton(
                highlightColor: Colors.black.withOpacity(0),
                icon: const Icon(
                  Icons.close,
                  size: Sizes.iconMd,
                ),
                onPressed: _clear,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.s8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
