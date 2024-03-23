import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ToDo(),
    );
  }
}

class ToDo extends StatefulWidget {
  const ToDo({
    super.key,
  });

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<String> agendas = [];

  void tambahAgenda(String agenda) {
    setState(() {
      agendas.add(agenda);
    });
  }

  void doneAgenda(int index) {
    setState(() {
      agendas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda',
        ),
      ),
      body: ListView.builder(
          itemCount: agendas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(agendas[index]),
              trailing: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () => doneAgenda(index),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final agenda = await showDialog(
              context: context,
              builder: (BuildContext context) {
                String newAgenda = '';
                return AlertDialog(
                    title: const Text('Agenda Baru'),
                    content: TextField(
                      onChanged: (value) {
                        newAgenda = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(newAgenda);
                        },
                        child: const Text(
                          'Tambah',
                        ),
                      )
                    ]);
              });

          if (agenda != null) {
            tambahAgenda(agenda);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
