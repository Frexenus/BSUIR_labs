﻿﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication01
{
    class Program
    {
        static void Main(string[] args)
        {
            int a = Convert.ToInt32(Console.ReadLine());
            int b = 0;
            try
            {
                int[,] exclude = new int[a, a];



                for (int i = 0; i < a; i++)
                {
                    for (int j = 0; j < a; j++)
                    {
                        exclude[i, j] = 0;
                    }
                }
                List<int> left_graph = new List<int>();
                List<int> right_graph = new List<int>();
                for (int i = 1; i < a; i++)
                {
                    string[] t = Console.ReadLine().Split(' ');
                    exclude[Convert.ToInt32(t[0]) - 1, Convert.ToInt32(t[1]) - 1] = 1;
                    exclude[Convert.ToInt32(t[1]) - 1, Convert.ToInt32(t[0]) - 1] = -1;

                    //left_graph.Add(Convert.ToInt32(t[0]));
                    //right_graph.Add(Convert.ToInt32(t[1]));

                }
                Console.WriteLine(rank(exclude, a) / 2);
            }
            catch (Exception)
            {
                for (int i = 0; i < a; i++)
                {
                    for (int j = 0; j < a; j++)
                    {
                        b = 0;
                    }
                }
                Console.WriteLine(2);
                return;
            }
        }

        private static int rank(int[,] exclude, int a)
        {
            const double EPS = 1E-9;

            int rank = a;
            bool[] line_used = new bool[a];
            for (int i = 0; i < a; ++i)
            {
                int j;
                for (j = 0; j < a; ++j)
                    if (!line_used[j] && Math.Abs(exclude[j, i]) > EPS)
                        break;
                if (j == a)
                    --rank;
                else
                {
                    line_used[j] = true;
                    for (int p = i + 1; p < a; ++p)
                        exclude[j, p] /= exclude[j, i];
                    for (int k = 0; k < a; ++k)
                        if (k != j && Math.Abs(exclude[k, i]) > EPS)
                            for (int p = i + 1; p < a; ++p)
                                exclude[k, p] -= exclude[j, p] * exclude[k, i];
                }
            }

            return rank;
        }







        //public static int rank(int[,] matrix, int a)
        //{
        //    int rank = a;
        //    for (int j = 0; j < a; j++)
        //    {
        //        for (int i = 0; i < a; i++)
        //        {
        //            if (i > j)
        //            {
        //                int c = 0;
        //                if (matrix[j, i] == 0)
        //                {
        //                    --rank;
        //                }
        //                else
        //                {
        //                    c = matrix[i, j] / matrix[j, i];
        //                }
        //                for (int k = 0; k <= a; k++)
        //                {
        //                    matrix[i, k] -= c * matrix[j, k];
        //                }
        //            }
        //        }
        //    }
        //    for (int i = 0; i < a; i++)
        //    {
        //        for (int j = 0; j < a; j++)
        //            Console.Write(matrix[i, j] + "\t");
        //        Console.WriteLine();
        //    }
        //    return 0;
        //}
    }
}