import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();
  bool aceitouTermos = false;

  void cadastrar() {
    if (nomeController.text.isEmpty ||
        emailController.text.isEmpty ||
        celularController.text.isEmpty ||
        dataNascimentoController.text.isEmpty ||
        senhaController.text.isEmpty ||
        confirmarSenhaController.text.isEmpty) {
      mostrarSnackBar('Por favor, preencha todos os campos');
      return;
    }

    if (senhaController.text != confirmarSenhaController.text) {
      mostrarSnackBar('As senhas não coincidem');
      return;
    }

    if (!aceitouTermos) {
      mostrarSnackBar('Você precisa aceitar os termos e condições');
      return;
    }

    mostrarSnackBar('Cadastro realizado com sucesso!');
  }

  void mostrarSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Voltar',
          style:
              TextStyle(color: Colors.white, fontSize: 14), 
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40), 

            
            const Center(
              child: Text(
                'CRIE SUA CONTA',
                style: TextStyle(
                  fontSize: 30, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

    
            _buildTextField(nomeController, 'Nome de usuario'),
            const SizedBox(height: 10), 

            _buildTextField(emailController, 'Email'),
            const SizedBox(height: 10),

            _buildTextField(celularController, 'Celular',
                keyboardType: TextInputType.phone),
            const SizedBox(height: 10),

            _buildTextField(dataNascimentoController, 'Data de nascimento'),
            const SizedBox(height: 10),

            _buildTextField(senhaController, 'Senha', obscureText: true),
            const SizedBox(height: 10),

            _buildTextField(confirmarSenhaController, 'Confirme sua senha',
                obscureText: true),
            const SizedBox(height: 14),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Para concluir o cadastro você precisa concordar com os ',
                      style: TextStyle(
                        fontSize: 12, 
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Termos e Condições de uso.',
                      style: TextStyle(
                        fontSize: 12, 
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10), 

            
            Row(
              children: [
                Container(
                  width: 18, 
                  height: 18, 
                  decoration: BoxDecoration(
                    color: aceitouTermos
                        ? const Color(0xFF1717B4)
                        : Colors.grey[800],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Checkbox(
                    value: aceitouTermos,
                    onChanged: (value) {
                      setState(() {
                        aceitouTermos = value ?? false;
                      });
                    },
                    activeColor: Colors.transparent,
                    checkColor: Colors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const SizedBox(width: 6), 
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Concordo com os ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Termos e condições de uso.',
                        style: TextStyle(
                          fontSize: 12, 
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), 

            
            SizedBox(
              width: double.infinity,
              height: 44, 
              child: ElevatedButton(
                onPressed: cadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1717B4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), 
                  ),
                ),
                child: const Text(
                  'Cadastrar-se',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Já possui uma conta? Entrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 46, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14, 
            vertical: 10,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13, 
        ),
      ),
    );
  }
}
