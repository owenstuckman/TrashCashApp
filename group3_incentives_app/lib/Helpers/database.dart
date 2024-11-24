/*
Database helpers is just used to store various functions used throughout the app
- just a helper class to prevent having to remake code for basic database functionality
- also centralizes all interactions with the database
 */

// create variable for database which will be accessed later
import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabase = Supabase.instance.client;
class DataBase {

  // lists and maps to pass data to, currently just samples
  static List<Map<String, dynamic>> ideas = [];

  // initialization of db
  static Future<void> init() async {
    await _tryInitialize();
  }

  // try to init, try catch for erros
  static Future<bool> _tryInitialize() async {
    try {
      await Supabase.initialize(
        // url and anonkey of supabase db
        url: 'https://zmqjskgfggxxmpfhygni.supabase.co',
        anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InptcWpza2dmZ2d4eG1wZmh5Z25pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAzODM1NTcsImV4cCI6MjA0NTk1OTU1N30.So0-6hvuRcrW89GkzIOdaQhkA0k22QlFc4ev3zKSgqY',
      );
      return false;
    } catch(e){
      return true;
    }
  }
  
}