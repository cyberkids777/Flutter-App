import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../db/notes_database.dart';
import '../../model/note.dart';
import '../../utils/auth_service.dart';
import '../../utils/base_colors.dart';
import '../login/login_view.dart';
import '../widgets/basic_note_card_widget.dart';
import 'edit_note_view.dart';
import 'note_detail_view.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.logout),
            color: CustomColors.purpleColor,
            onPressed: () async {
              await AuthService.logout();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              }
            },
          ),
          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 24, color: CustomColors.purpleColor),
          ),
          actions: [
             GestureDetector(
              child: const Icon(Icons.search, color: CustomColors.purpleColor),
              onTap: () {
                const snackBar = SnackBar(content: Text("Doesn't work"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(
                          color: CustomColors.purpleColor, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.purpleColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(17),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 2,
      children: List.generate(
        notes.length,
        (index) {
          final note = notes[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(
                    noteId: note.id!,
                    index: index,
                  ),
                ));

                refreshNotes();
              },
              child: NoteCardWidget(note: note, index: index),
            ),
          );
        },
      ));
}
