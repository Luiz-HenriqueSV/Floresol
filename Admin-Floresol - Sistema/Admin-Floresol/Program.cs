using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using MySql.Data;

namespace Admin_Floresol
{
    internal class Program
    {
        static string connection = "server=localhost;database=banco_Hospital;user=root;password=root";
        static void Main(string[] args)
        {
            string op = "";
            Console.WriteLine("Bem vindo(a)!");
            while (op != "Q")
            {
                Console.WriteLine("            MENU DE FUNCIONÁRIOS             ");
                Console.WriteLine("O que deseja administrar? \n\n 1 - Clientes \n\n 2 - Funcionários \n\n 3 - Estoque \n\nQ - Sair \n");
                op = Console.ReadLine().ToUpper();
                switch (op)
                {
                    case "1":
                        Console.WriteLine("Usuário: ");
                        Console.ReadLine();
                        Console.WriteLine("Senha: ");
                        Console.
                        break;
                    case "2":
                        break;
                    case "Q":
                        break;
                    default:
                        Console.WriteLine("Opção inválida (ou inexistente)!!");
                        break;
                }
            }
        }
    }
}
