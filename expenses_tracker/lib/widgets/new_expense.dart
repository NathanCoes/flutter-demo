import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense ( { super.key , required this.onAddExpense } );

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {

  final _titleController = TextEditingController();
  final _amounController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month - 1, now.day);
    final lastDate = now;

    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate, 
      lastDate: lastDate
    );

    setState(() {
      _selectedDate = pickedDate;
    });
    
  }
  
  void _showDialog(){
    if (Platform.isIOS){
      showCupertinoDialog(context: context, builder: (ctx) => 
        CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure that you fill correctly all the inputs'),
          actions: [
            TextButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Ok')
            )
          ],
        )
      );
    }else{
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure that you fill correctly all the inputs'),
          actions: [
            TextButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Ok')
            )
          ],
        ),
      ); 
    }
  }

  void _submitExpenseData() {
    final enterAmount = double.tryParse(_amounController.text); 
    final amountIsInvalid = enterAmount == null || enterAmount <= 0;
    //remove extra space
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text, 
        amount: enterAmount, 
        date: _selectedDate!, 
        category: _selectedCategory
      )
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amounController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      print(width);

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600 )  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Writte a title!')
                          ),
                        ),
                      ),
                      const SizedBox(width: 24,),
                      Expanded(  
                        child: TextField(
                          controller: _amounController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount')
                          ),
                        ),
                      ),
                    ],
                  )
                else

                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Writte a title!')
                  ),
                ),
                if ( width >= 600)
                  Row(children: [
                    Expanded(
                      child: DropdownButton(
                        value: _selectedCategory,
                        items: Category.values.map(
                          (category)=> DropdownMenuItem(
                            value: category,
                            child: Text( category.name.toUpperCase()),
                          )
                        ).toList(),
                        onChanged: (value){
                          if (value == null){
                              return;
                            }
                          setState((){
                            _selectedCategory = value;
                          });
                        }
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null 
                            ? 'No date selected' 
                            : formatter.format(_selectedDate!)
                          ),
                          IconButton(
                            onPressed: _presentDatePicker, 
                            icon: const Icon(
                              Icons.calendar_month
                            )
                          )
                        ],
                      ),
                    ),
                  ],)
                else
                Row(
                  children: [
                    Expanded(  
                      child: TextField(
                        controller: _amounController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount')
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null 
                            ? 'No date selected' 
                            : formatter.format(_selectedDate!)
                          ),
                          IconButton(
                            onPressed: _presentDatePicker, 
                            icon: const Icon(
                              Icons.calendar_month
                            )
                          )
                        ],
                      ),
                    )
                  ],
                ),
                if (width >= 600)
                  Row(
                    children: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: _submitExpenseData, 
                        child: const Text("Save expense")
                      )
                    ],
                  )
                else

                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map(
                        (category)=> DropdownMenuItem(
                          value: category,
                          child: Text( category.name.toUpperCase()),
                        )
                      ).toList(),
                      onChanged: (value){
                        if (value == null){
                            return;
                          }
                        setState((){
                          _selectedCategory = value;
                        });
                      }
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text('Cancel')),
                    ElevatedButton(
                      onPressed: _submitExpenseData, 
                      child: const Text("Save expense")
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}