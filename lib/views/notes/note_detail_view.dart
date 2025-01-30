import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dsw_52804/db/notes_database.dart';
import 'package:dsw_52804/model/note.dart';

import '../../utils/base_colors.dart';
import 'edit_note_view.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  final int index;

  const NoteDetailPage({
    super.key,
    required this.noteId,
    required this.index,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  late Color color;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    color = NoteColors.getColorForIndex(widget.index);
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: NoteColors.getColorForIndex(widget.index),
          actions: [editButton(), deleteButton()],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: CustomColors.purpleColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: NoteColors.getColorForIndex(widget.index),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat.yMMMd().format(note.createdTime),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(
        Icons.edit_outlined,
        color: CustomColors.purpleColor,
      ),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(
          Icons.delete,
          color: CustomColors.purpleColor,
        ),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
