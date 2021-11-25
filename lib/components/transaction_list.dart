import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  final Function(String) onDelete;

  TransactionList({required this.transactions, required this.onDelete});

  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(child: Text('R\$${tr.value}')),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('D MMM y').format(tr.date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? IconButton(
                            color: Colors.red,
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () => onDelete(tr.id),
                          )
                        : TextButton(
                            onPressed: () {
                              onDelete(tr.id);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete,color: Colors.red,),
                                Text('Excluir',style: TextStyle(
                                  color: Colors.red
                                ),),
                              ],
                            ))),
              );
            });
  }
}
