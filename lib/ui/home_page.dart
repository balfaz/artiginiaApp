import 'package:artigian_app/repositories/auth_services.dart';
import 'package:artigian_app/ui/lista_cantieri.dart';
import 'package:artigian_app/ui/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? email;
  const HomePage({Key? key, this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _NavPages = [ListaCantieriPage(), LoginPage()];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '${this.widget.email}',
          style: TextStyle(color: Colors.blue),
        ),
        leading: Icon(
          Icons.account_circle,
          size: 38,
          color: Colors.blue,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.blue,
              size: 28,
            ),
            onPressed: () => _auth.signOut().then(
                (value) => Navigator.pushReplacementNamed(context, 'login')),
          ),
        ],
      ),
      body: _NavPages[_selectedIndex],
      //_corpo(),
      bottomNavigationBar: bottomBar(),
    );
  }

  _corpo() {
    Center(
      child: _NavPages[_selectedIndex],
    );
    /* return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff9c9c9c), Color(0xffF2F2F2)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      child: Center(
        child: Text('Loggato con ${this.widget.email}'),
      ),
    ); */
  }

  Widget bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: _selectedIndex == 0 ? '⬤' : 'HOME'),
        BottomNavigationBarItem(
            icon: const Icon(Icons.contacts),
            label: _selectedIndex == 1 ? '⬤' : 'Contatti'),
        BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: _selectedIndex == 2 ? '⬤' : 'Calendario'),
        BottomNavigationBarItem(
            icon: const Icon(Icons.email),
            label: _selectedIndex == 3 ? '⬤' : 'Email'),
        BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: _selectedIndex == 4 ? '⬤' : 'Impostazioni'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
