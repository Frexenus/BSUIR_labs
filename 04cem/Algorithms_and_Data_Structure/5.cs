﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication5
{
    class Program
    {
        static void Main(string[] args)
        {
            string i = Console.ReadLine();
            int a = Convert.ToInt32(i);
            if ((a % 4 == 0 && a % 100 != 0)|(a % 400 == 0))
            {
                Console.WriteLine("YES");
            }
            else
            {
                Console.WriteLine("NO");
            }

        }
    }
}