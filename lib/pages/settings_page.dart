import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title:const Text("S E T T I N G S"),
      ),
      body:Container(
        decoration: BoxDecoration(
          color:Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(25),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark mode
           const Text("Dark Mode",
           style: TextStyle(fontWeight:FontWeight.bold ),
           ),

            //switch
            CupertinoSwitch(
              value:
                Provider.of<ThemeProvider>(context,listen:false).isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme()
            )
          ],
        ) ,
      ) ,
    );
  }
}