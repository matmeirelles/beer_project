import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubits/name_cubit.dart';

const String _nameInputLable = 'Insira um novo nome';
const String _changeButtonLable = 'Alterar nome';

class NameView extends StatelessWidget {
  NameView({Key? key}) : super(key: key);
  final TextEditingController _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bloc de nome',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _nameTextController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text(
                  _nameInputLable,
                ),
              ),
              style: textTheme.bodyMedium,
            ),
            ElevatedButton(
              onPressed: () {
                final String newName = _nameTextController.text;
                if (newName.isNotEmpty) {
                  context.read<NameCubit>().change(newName);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Insira um nome',
                    ),
                  ));
                }
              },
              child: const Text(
                _changeButtonLable,
              ),
            ),
            BlocBuilder<NameCubit, String>(
                builder: (context, state) => Card(
                      child: ListTile(
                        title: Text(
                          state,
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
