import 'package:flutter/material.dart';
import 'package:notes_app_cetoribio/models/note.dart';
import 'package:notes_app_cetoribio/widgets/note_element.dart';
import 'package:provider/provider.dart';

import '../provider/note_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addNote(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Añadir Nota'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: "Introduce el contenido de la nota"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Añadir'),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false)
                    .insert(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editNote(BuildContext context, Note note) async {
    final TextEditingController controller =
        TextEditingController(text: note.content);
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Editar Nota'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: "Edita el contenido de la nota"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false)
                    .update(note.id, controller.text);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(BuildContext context, Note note) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar Nota'),
          content:
              const Text("¿Estás seguro de que quieres eliminar esta nota?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false)
                    .delete(note.id);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notas',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.normal),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          // list empty
          if (noteProvider.notes.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Crea tu primera nota'),
                  SizedBox(height: 20.0),
                  Icon(Icons.note_alt_outlined, size: 50.0, color: Colors.grey),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: noteProvider.notes.length,
                  itemBuilder: (context, index) {
                    final note = noteProvider.notes[index];
                    return NoteElement(
                        note: note,
                        onDelete: () => _deleteNote(context, note),
                        onEdit: () => _editNote(context, note));
                  },
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNote(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
