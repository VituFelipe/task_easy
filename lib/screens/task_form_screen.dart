import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;
  const TaskFormScreen({super.key, this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _assignee = '';
  DateTime _dueDate = DateTime.now();
  String _status = 'Pendente';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _assignee = widget.task!.assignee;
      _dueDate = widget.task!.dueDate;
      _status = widget.task!.status;
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Nova Tarefa' : 'Editar Tarefa')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _assignee,
                decoration: InputDecoration(
                  labelText: 'Responsável',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),  
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _assignee = value!,
              ),
              ListTile(
                title: Text('Data de Vencimento: ${DateFormat('dd/MM/yyyy').format(_dueDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
              DropdownButtonFormField<String>(
                value: _status,
                items: ['Pendente', 'Concluída'].map((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
                onChanged: (value) => setState(() => _status = value!),
                decoration: InputDecoration(labelText: 'Status'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final task = Task(
                      id: widget.task?.id,
                      title: _title,
                      description: _description,
                      assignee: _assignee,
                      dueDate: _dueDate,
                      status: _status,
                    );
                    final provider = Provider.of<TaskProvider>(context, listen: false);
                    if (widget.task == null) {
                      provider.addTask(task);
                    } else {
                      provider.updateTask(task);
                    }
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, selecione uma data')));                    
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                ),
                child: Text(widget.task == null ? 'Salvar' : 'Atualizar', style: TextStyle(fontSize: 14),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}