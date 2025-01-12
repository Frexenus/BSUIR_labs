﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using System.Threading;
using System.Collections.ObjectModel;
using Microsoft.Win32;
using System.Collections.Specialized;
using System.ComponentModel;
using System.IO.Compression;
using System.Collections;
using System.Reflection;

namespace WpfApplication1
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Test One = CreateCollection();
        int indexforoutput = 0;
        float resultmark = 0;
        string resultscore;
        string filepath = "C:\\Users\\Данила Бодров\\Desktop\\lab4sav";

        public MainWindow()
        {
            InitializeComponent();
            // TreeView.Items.Clear();
           // MessageBox.Show("Kolya pidr))))");

            Available.Content = "0";
            Average.Content = "0";
            TreeView.Items.Clear();

            TreeView.ItemsSource = One; //<--------------thats it


        }

        public void Button_Click(object sender, RoutedEventArgs e)
        {
            /*
             add own elenemt
             */
            if (EditQuestion.Text == "")
            {
                return;
            }

            One.Addown(EditQuestion.Text, EditVar1.Text, (bool)ch1.IsChecked, EditVar2.Text, (bool)ch2.IsChecked, EditVar3.Text, (bool)ch3.IsChecked, EditVar4.Text, (bool)ch4.IsChecked, EditVar5.Text, (bool)ch5.IsChecked, Convert.ToInt32(DiffCombo.SelectedIndex + 1));

            Average.Content = (string)One.GetAverage();
            Available.Content = One.GetCount();
            //TreeView.Items.Add(new TreeViewItem().Header = EditQuestion.Text);

            /*var questionItem = new TreeViewItem { Header = EditQuestion.Text, Foreground = Central.Foreground };
             foreach (var variant in One.GetQuestion(One.GetCount()-1))
             {
                 questionItem.Items.Add(new TreeViewItem { Header = variant.Name, Foreground = Central.Foreground });
             }
             TreeView.Items.Add(questionItem);*/
            //TreeView.ItemsSource = One;

            EditQuestion.Clear();
            EditVar1.Clear(); ch1.IsChecked = false;
            EditVar2.Clear(); ch2.IsChecked = false;
            EditVar3.Clear(); ch3.IsChecked = false;
            EditVar4.Clear(); ch4.IsChecked = false;
            EditVar5.Clear(); ch5.IsChecked = false;
            // TreeView.Items.Add(new TreeViewItem().Header = "Hi");
        }

        public static Test CreateCollection()
        {
            Test One = new Test();


            return One;
        }


        public void Autoadd()
        {

            bool c = true;
            bool i = false;
            string q1 = "What's included in a typical software ";
            string q1v1 = "distribution media";
            string q1v2 = "information about its system ";
            string q1v3 = "validation code";
            string q1v4 = "software copyrights";
            string q1v5 = "programm code";
            int q1d = 4;
            One.Addown(q1, q1v1, c, q1v2, i, q1v3, i, q1v4, i, q1v5, i, q1d);
            //TreeView.Items.Add(new TreeViewItem().Header = q1);
            string q2 = "Military must";
            string q2v1 = "be healthy";
            string q2v2 = "be accurate";
            string q2v3 = "be safe";
            string q2v4 = "be strong";
            string q2v5 = "be frighten";
            int q2d = 4;
            One.Addown(q2, q2v1, i, q2v2, i, q2v3, i, q2v4, c, q2v5, i, q2d);
            //TreeView.Items.Add(new TreeViewItem().Header = q2);
            string q3 = "Never gonna...";
            string q3v1 = "make you cry";
            string q3v2 = "give you up";
            string q3v3 = "let you down";
            string q3v4 = "say goodbye";
            string q3v5 = "tell a lie and hurt you";
            int q3d = 1;

            One.Addown(q3, q3v1, i, q3v2, i, q3v3, i, q3v4, c, q3v5, i, q3d);
            //TreeView.Items.Add(new TreeViewItem().Header = q3);

            string q4 = "Putins birthday";
            string q4v1 = "25/8/1968";
            string q4v2 = "4/8/1967";
            string q4v3 = "7/9/1956";
            string q4v4 = "5/8/7892";
            string q4v5 = "1/7/1968";
            int q4d = 6;

            One.Addown(q4, q4v1, i, q4v2, i, q4v3, i, q4v4, i, q4v5, c, q4d);
            //TreeView.Items.Add(new TreeViewItem().Header = q4);

            string q5 = "When is elections day";
            string q5v1 = "monday";
            string q5v2 = "tuesday";
            string q5v3 = "wendsday";
            string q5v4 = "thuesday";
            string q5v5 = "friday";
            int q5d = 4;

            One.Addown(q5, q5v1, i, q5v2, i, q5v3, i, q5v4, i, q5v5, c, q5d);
            //TreeView.Items.Add(new TreeViewItem().Header = q5);

            string q6 = "The most strongest marvel superhero";
            string q6v1 = "wolwerine";
            string q6v2 = "spider-man";
            string q6v3 = "aquaman";
            string q6v4 = "Hulk";
            string q6v5 = "Ironman";
            int q6d = 9;

            One.Addown(q6, q6v1, c, q6v2, i, q6v3, i, q6v4, i, q6v5, i, q6d);
            //TreeView.Items.Add(new TreeViewItem().Header = q6);

            string q7 = "Who lives in the deep of the ocean";
            string q7v1 = "spongebob";
            string q7v2 = "patric";
            string q7v3 = "Squidward";
            string q7v4 = "plankton";
            string q7v5 = "Mr. Crubs";
            int q7d = 9;

            One.Addown(q7, q7v1, c, q7v2, i, q7v3, i, q7v4, i, q7v5, i, q7d);

            //TreeView.Items.Add(new TreeViewItem().Header = q7);

            //    TreeViewUpdate();
            //TreeView.ItemsSource = One;
        }

        /*private void TreeViewUpdate()
        {
            TreeView.Items.Clear();                 //make it databinding
            var item = new TreeViewItem();
            foreach (var question in One)
            {
                var questionItem = new TreeViewItem { Header = question.Name, Foreground = Central.Foreground };
                foreach (var variant in question)
                {
                    questionItem.Items.Add(new TreeViewItem { Header = variant.Name, Foreground = Central.Foreground });
                }
                TreeView.Items.Add(questionItem);
            }
        }*/

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Autoadd();
            Average.Content = (string)One.GetAverage();
            Available.Content = One.GetCount();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Available.Content = "0";
            Average.Content = "0";
            One.Clear();

            //TreeView.Items.Clear();
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            //start test
            resultscore = "";
            resultmark = 0;
            //TC.Items.Add()
            if (Convert.ToString(Available.Content) == "0")
            {
                return;
            }
            MakeButtonsIsEnabled(false);
            window.Height = 570d;
            AchClear();
            QuestionShow(indexforoutput);


        }

        private void QuestionShow(int index)
        {
            Ach1.IsEnabled = true;
            Ach2.IsEnabled = true;
            Ach3.IsEnabled = true;
            Ach4.IsEnabled = true;
            Ach5.IsEnabled = true;
            QuestionTitle.Content = One.GetQuestion(index).Name;
            foreach (Variant v in One.GetQuestion(index))
            {
                if (Convert.ToString(Ach1.Content) == "")
                {
                    Ach1.Content = v.Name;
                    continue;
                }
                if (Convert.ToString(Ach2.Content) == "")
                {
                    Ach2.Content = v.Name;
                    continue;
                }
                if (Convert.ToString(Ach3.Content) == "")
                {
                    Ach3.Content = v.Name;
                    continue;
                }
                if (Convert.ToString(Ach4.Content) == "")
                {
                    Ach4.Content = v.Name;
                    continue;
                }
                if (Convert.ToString(Ach5.Content) == "")
                {
                    Ach5.Content = v.Name;
                    continue;
                }
            }
            if (Convert.ToString(Ach5.Content) == "")
            {
                Ach5.IsEnabled = false;
            }
            else
            {
                return;
            }
            if (Convert.ToString(Ach4.Content) == "")
            {
                Ach4.IsEnabled = false;
            }
            else
            {
                return;
            }
            if (Convert.ToString(Ach3.Content) == "")
            {
                Ach3.IsEnabled = false;
            }
            else
            {
                return;
            }
            if (Convert.ToString(Ach2.Content) == "")
            {
                Ach2.IsEnabled = false;
            }
            else
            {
                return;
            }
        }

        private void MakeButtonsIsEnabled(bool YN)
        {
            Start.IsEnabled = YN;
            AutoaddButton.IsEnabled = YN;
            ClearButton.IsEnabled = YN;
            AddButton.IsEnabled = YN;
            DiffCombo.IsEnabled = YN;
            EditQuestion.IsEnabled = YN;
            EditVar1.IsEnabled = YN;
            EditVar2.IsEnabled = YN;
            EditVar3.IsEnabled = YN;
            EditVar4.IsEnabled = YN;
            EditVar5.IsEnabled = YN;
            ch1.IsEnabled = YN;
            ch2.IsEnabled = YN;
            ch3.IsEnabled = YN;
            ch4.IsEnabled = YN;
            ch5.IsEnabled = YN;
        }

        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            InitTest();

        }
        private bool IsLastCorrect()
        {
            if (!Ach1.IsEnabled || Ach1.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(0).Ans && (bool)Ach1.IsChecked
                || Ach1.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(0).Ans && !(bool)Ach1.IsChecked)
            {
                if (!Ach2.IsEnabled || Ach2.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(1).Ans && (bool)Ach2.IsChecked
                    || Ach2.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(1).Ans && !(bool)Ach2.IsChecked)
                {
                    if (!Ach3.IsEnabled || Ach3.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(2).Ans && (bool)Ach3.IsChecked
                        || Ach3.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(2).Ans && !(bool)Ach3.IsChecked)
                    {
                        if (!Ach4.IsEnabled || Ach4.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(3).Ans && (bool)Ach4.IsChecked
                            || Ach4.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(3).Ans && !(bool)Ach4.IsChecked)
                        {
                            if (!Ach5.IsEnabled || Ach5.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(4).Ans && (bool)Ach5.IsChecked
                                || Ach5.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(4).Ans && !(bool)Ach5.IsChecked)
                            {
                                return true;
                            }
                        }
                    }
                }
            }

            return false;
        }
        private void InitTest()
        {
            if (Convert.ToString(QuestionTitle.Content) != "")
            {
                //проверка на правильность
                if (IsLastCorrect())
                {

                    resultmark += (100 / One.GetCount());
                }
                else
                {
                    resultscore += " #" + (indexforoutput + 1);
                }
            }

            if (Convert.ToString(NextButton.Content) == "Finish")
            {
                window.Height = 345d;
                NextButton.Content = "Next";
                MakeButtonsIsEnabled(true);
                indexforoutput = 0;
                Result.Content = "Your result is " + (resultmark + 1) + "% \nMistakes:" + resultscore;
                return;
            }
            AchClear();
            ++indexforoutput;
            QuestionShow(indexforoutput);
            if (indexforoutput == One.GetCount() - 1)
            {
                //вывести результат теста
                //поднять форму
                NextButton.Content = "Finish";
                //return;
            }

        }

        private void AchClear()
        {
            Ach1.Content = "";
            Ach2.Content = "";
            Ach3.Content = "";
            Ach4.Content = "";
            Ach5.Content = "";
            Ach1.IsChecked = false;
            Ach2.IsChecked = false;
            Ach3.IsChecked = false;
            Ach4.IsChecked = false;
            Ach5.IsChecked = false;

        }




        /// <summary>
        /// //////////////////////////////////////////////////////////////////////////////////
        /// </summary>

        private void binary_save(object sender, RoutedEventArgs e)
        {
            SaveFileDialog dlg = new SaveFileDialog();
            dlg.DefaultExt = ".bin";
            dlg.Filter = "Binary documents (.bin)|*.bin";
            if (dlg.ShowDialog() == true)
            {
                filepath = dlg.FileName;
            }

            BinaryWriter writer = null;
            try
            {
                writer = new BinaryWriter(new FileStream(filepath, FileMode.Create));
                One.SaveToBinary(writer);
            }
            catch (IOException exc)
            {
                MessageBox.Show(exc.Message);
            }
            finally
            {
                if (writer != null)
                    writer.Close();
            }
        }

        private void text_save(object sender, RoutedEventArgs e)
        {
            SaveFileDialog dlg = new SaveFileDialog();
            dlg.DefaultExt = ".txt";
            dlg.Filter = "Text documents (txt)|*.txt";
            if (dlg.ShowDialog() == true)
            {
                filepath = dlg.FileName;
            }

            StreamWriter writer = null;
            try
            {
                writer = new StreamWriter(new FileStream(filepath, FileMode.Create));
                One.SaveToText(writer);
            }
            catch (IOException exc)
            {
                MessageBox.Show(exc.Message);
            }
            finally
            {
                if (writer != null)
                    writer.Close();
            }
        }

        private void archivefile(object sender, RoutedEventArgs e)
        {
            SaveFileDialog dlg = new SaveFileDialog();
            //dlg.DefaultExt = ".zip";
            //dlg.Filter = "Archived file (.zip)|*.zip";
            dlg.CheckFileExists = true;
            if (dlg.ShowDialog() == true)
            {
                filepath = dlg.FileName;
            }

            string outFilename = filepath + ".zip";

            One.CompressFile(filepath, outFilename);
        }

        private void disarchive(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.DefaultExt = ".zip";
            dlg.Filter = "Archived file (.zip)|*.zip";
            dlg.CheckFileExists = true;
            if (dlg.ShowDialog() == true)
            {
                filepath = dlg.FileName;
            }

            string outFilename = filepath + ".bin";

            One.DecompressFile(filepath, outFilename);
        }

        private void binary_open(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.DefaultExt = ".bin";
            dlg.Filter = "Binary documents (.bin)|*.bin";
            dlg.CheckFileExists = true;
            if (dlg.ShowDialog() == true)
            {
                filepath = dlg.FileName;
            }

            BinaryReader reader = null;
            try
            {
                reader = new BinaryReader(new FileStream(filepath, FileMode.Open));
                One.OpenBinary(reader);
            }
            catch (IOException exc)
            {
                MessageBox.Show(exc.Message);
            }
            finally
            {
                if (reader != null)
                    reader.Close();
            }
        }

        private void text_open(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.DefaultExt = ".txt";
            dlg.Filter = "Text documents (.haha)|*.txt";
            dlg.CheckFileExists = true;
            if (dlg.ShowDialog() == true)
            {
                filepath = dlg.FileName;
            }

            StreamReader reader = null;
            try
            {
                reader = new StreamReader(new FileStream(filepath, FileMode.Open));
                One.OpenText(reader);
            }
            catch (IOException exc)
            {
                MessageBox.Show(exc.Message);
            }
            finally
            {
                if (reader != null)
                    reader.Close();
            }

        }

        private void startSerialize(object sender, RoutedEventArgs e)
        {
            SerializableObject obj = new SerializableObject();
            obj.Each = One;


            MySerializer serializer = new MySerializer();
            serializer.SerializeObject("output.srz", obj);

        }

        private void startDeserialize(object sender, RoutedEventArgs e)
        {
            Available.Content = "0";
            Average.Content = "0";
            One.Clear();
            SerializableObject obj = new SerializableObject();
            obj.Each = One;
            MySerializer serializer = new MySerializer();


            obj = serializer.DeserializeObject("output.srz");
            One = obj.Each;
            TreeView.ItemsSource = One;


        }




        private void startLINQ(object sender, RoutedEventArgs e)
        {
            window.Width = 920d;
        }

        private void XSerialize(object sender, RoutedEventArgs e)
        {
            SerializableObject obj = new SerializableObject();
            obj.Each = One;


            MySerializer serializer = new MySerializer();
            serializer.XSerializeObject("output.xsr", obj);
        }



        private void XDESerialize(object sender, RoutedEventArgs e)
        {
            Available.Content = "0";
            Average.Content = "0";
            One.Clear();
            SerializableObject obj = new SerializableObject();
            obj.Each = One;
            MySerializer serializer = new MySerializer();


            obj = serializer.XDeserializeObject("output.xsr");
            One = obj.Each;
            TreeView.ItemsSource = One;
        }

        private void CloseLinq(object sender, RoutedEventArgs e)
        {
            window.Width = 710d;
        }

        private void Button_Click_5(object sender, RoutedEventArgs e)//search
        {


            
            var selectedTeams = from t in One // определяем каждый объект из teams как t
                                where t.Name.StartsWith(textLINQ.Text) //фильтрация по критерию
                                select t; // выбираем объект

            //listLINQ.ItemsSource = selectedTeams;
            foreach (var s in selectedTeams)
            {
                listLINQ.Items.Add(s.Name);
            }
            

        }

        private void Button_Click_6(object sender, RoutedEventArgs e)//min
        
        {
            listLINQ.Items.Clear();
            listLINQ.Items.Refresh();

            int minim = One.Min(a => a.Difficulty);
            textLINQ.Text = minim.ToString();
        }

       

        private void Button_Click_8(object sender, RoutedEventArgs e)//group
        {
            

            var selectedTeams = from s in One
                                group s by s.Difficulty;

            var unGroup = from b in selectedTeams
                          from c in b
                          select c;

            foreach (var s in unGroup)
            {
                listLINQ.Items.Add(s.Difficulty + " "+s.Name);
            }                    
        }

        private void Button_Click_9(object sender, RoutedEventArgs e)//sortbyname
        {
            listLINQ.Items.Clear();
            listLINQ.Items.Refresh();

            var selectedTeams = from lan in One

                                orderby lan.Name
                                select lan;
            foreach (var s in selectedTeams)
            {
                listLINQ.Items.Add(s.Name + " "+ s.Difficulty);
            }
        }

        private void Button_Click_10(object sender, RoutedEventArgs e)
        {
            
            listLINQ.Items.Clear();
            listLINQ.Items.Refresh();

        }
    }
    /// <summary>
    /// ///////////////////////////////////////////////////////////////////////////////////
    /// </summary>
    /// FORMATTER↓↓↓↓↓↓
    /// FORMATTER↓↓↓↓↓↓
    public class XFormatter
    {

        public XFormatter() { }

        public void Serialize(StreamWriter serializationStream, object graph)
        {
            Type _type = graph.GetType();
            if (!_type.BaseType.Equals(typeof(MulticastDelegate)) && !_type.BaseType.Equals(typeof(System.Collections.Specialized.INotifyCollectionChanged)))
            {
                if (_type.Equals(typeof(string)))
                {
                    serializationStream.WriteLine("System.String");
                    //serializationStream.WriteLine(_type.ToString());
                    serializationStream.WriteLine(graph.ToString());
                    return;
                }else
                if (_type.IsArray)
                
                {
                    
                    serializationStream.WriteLine(_type.FullName);
                    serializationStream.WriteLine(((Array)graph).Length);
                    foreach (object innerobj in (Array)graph)
                    {
                        if (innerobj != null)
                        {
                            Serialize(serializationStream, innerobj);
                        }
                    }
                    return;
                }
                else 
                
                if (!_type.IsPrimitive)
                {
                    FieldInfo[] fi = _type.GetFields(BindingFlags.GetField | BindingFlags.SetField | BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);
                    serializationStream.WriteLine(_type.FullName);

                    foreach (FieldInfo finfo in fi)
                    {
                       /* if (!finfo.IsLiteral && !finfo.IsInitOnly && !finfo.IsNotSerialized && finfo.FieldType.BaseType != null && !finfo.FieldType.BaseType.Equals(typeof(System.MulticastDelegate)))
                        {
                            serializationStream.WriteLine(finfo.Name);
                            serializationStream.WriteLine(finfo.GetValue(graph));
                        }*/
                        if (finfo.GetValue(graph) != null && !finfo.IsLiteral && !finfo.IsInitOnly && !finfo.IsNotSerialized && finfo.FieldType.BaseType != null && !finfo.FieldType.BaseType.Equals(typeof(System.MulticastDelegate)))
                        {
                            serializationStream.WriteLine("{");
                            Serialize(serializationStream, finfo.GetValue(graph));
                            serializationStream.WriteLine("}");
                        }
                    }
                }
                else
                {
                    serializationStream.WriteLine(_type.ToString());
                    serializationStream.WriteLine(graph.ToString());
                }
            }
            // serializationStream.WriteLine("One name");
            // string s = graph.GetType().FullName;
            // if (graph.GetType().IsPrimitive)
            // {
            //     serializationStream.WriteLine(s);
            //s = p
        }
        public object Deserialize(StreamReader serializationStream)
        {
            //string close = "<";
            object recursionObj = null;
            string line = serializationStream.ReadLine();
            //if (line == "<"|| line == ">") { line = serializationStream.ReadLine(); }
            Type type = Type.GetType(line);
            if (type.BaseType.Equals(typeof(MulticastDelegate)))
            {
                
            }
            if (type.Equals(typeof(string)))// если это строка
            {
                string value = serializationStream.ReadLine();
                recursionObj = value;
                return recursionObj;
            }
            else /*if (type.Equals(typeof(Boolean)))
            {
                string value = serializationStream.ReadLine();
                recursionObj = value;
                return recursionObj;
            }
            else*/
                if (type.IsPrimitive)  //если объект примитивный
            {
                recursionObj = (object)type.InvokeMember("Parse",
              BindingFlags.InvokeMethod | BindingFlags.Static | BindingFlags.Public,
              null, null, new object[] { serializationStream.ReadLine() });
                line = serializationStream.ReadLine();
                return recursionObj;
            }
            else if (type.IsArray || type.IsEnum)//если массив
            {
                line = serializationStream.ReadLine();
                int co = Convert.ToInt32(line);
                recursionObj = Activator.CreateInstance(type, co); //создаем сам объект
                line =  serializationStream.ReadLine();
                for (int counter = 0; counter < co; counter++)
                {
                    ((Array)recursionObj).SetValue(Deserialize(serializationStream), counter);
                    serializationStream.ReadLine();
                }
            }
            else if (type.IsGenericType)
            {
                recursionObj = Activator.CreateInstance(type);

                FieldInfo[] finfo = type.GetFields(BindingFlags.GetField | BindingFlags.SetField |
                                 BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);
                
                // if (line == ">"|| line == "<") { line = serializationStream.ReadLine(); }
                foreach (FieldInfo field in finfo)
                
                {
                    line = serializationStream.ReadLine();
                    if (line == "}") { return recursionObj; }
                    field.SetValue(recursionObj, Deserialize(serializationStream));
                    
                }
               
            }
            else if (!type.IsPrimitive)
            {//если объект не примитивный

                recursionObj = Activator.CreateInstance(type);

                FieldInfo[] finfo = type.GetFields(BindingFlags.GetField | BindingFlags.SetField |
                                 BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);
                line = serializationStream.ReadLine();
                // if (line == ">"|| line == "<") { line = serializationStream.ReadLine(); }
                foreach (FieldInfo field in finfo)
                {
                    var t = field.GetType();
                    if (field.FieldType.BaseType.Equals(typeof(MulticastDelegate)))
                        continue;
                    field.SetValue(recursionObj, Deserialize(serializationStream));
                    line = serializationStream.ReadLine();
                }
            }


            return recursionObj;
        }
    }
    //serialization of object to file and from file
    public class MySerializer
    {
        public MySerializer() { }

        public void SerializeObject(string fileName, SerializableObject objToSerialize)
        {
            FileStream fstream = File.Open(fileName, FileMode.Create);
            BinaryFormatter binaryFormatter = new BinaryFormatter();
            binaryFormatter.Serialize(fstream, objToSerialize);
            fstream.Close();
        }

        public SerializableObject DeserializeObject(string fileName)
        {
            SerializableObject objToSerialize = null;
            FileStream fstream = File.Open(fileName, FileMode.Open);
            BinaryFormatter binaryFormatter = new BinaryFormatter();
            objToSerialize = (SerializableObject)binaryFormatter.Deserialize(fstream);
            fstream.Close();
            return objToSerialize;
        }
        ///XSERIALIZATION↓↓↓↓
        ///XSERIALIZATION↓↓↓↓
        ///XSERIALIZATION↓↓↓↓
        ///XSERIALIZATION↓↓↓↓
        ///XSERIALIZATION↓↓↓↓
        public void XSerializeObject(string fileName, SerializableObject objToSerialize)
        {
            FileStream fstream = File.Open(fileName, FileMode.Create);
            StreamWriter write = new StreamWriter(fstream);

            XFormatter xformat = new XFormatter();
            xformat.Serialize(write, objToSerialize);
            write.Close();
            fstream.Close();

        }

        public SerializableObject XDeserializeObject(string fileName)
        {
            SerializableObject objToSerialize = null;
            FileStream fstream = File.Open(fileName, FileMode.Open);
            StreamReader read = new StreamReader(fstream);

            XFormatter xformat = new XFormatter();
            objToSerialize = (SerializableObject)xformat.Deserialize(read);
            fstream.Close();
            return objToSerialize;
        }

    }
    //объект сущностей, для которых нужна сериализация
    [Serializable]
    public class SerializableObject : ISerializable
    {
        private Test each;

        public Test Each
        {
            get { return this.each; }
            set { this.each = value; }
        }

        public SerializableObject() { }




        public SerializableObject(SerializationInfo sInfo, StreamingContext contextArg)
        {
            this.each = (Test)sInfo.GetValue("Students", typeof(Test));
        }

        public void GetObjectData(SerializationInfo sInfo, StreamingContext contextArg)
        {
            sInfo.AddValue("Students", this.each);
        }

    }
    //end of serialization
    [Serializable]
    public class Test : IEnumerable<Question>, INotifyCollectionChanged, ISerializable
    {
        public List<Question> current;
        public bool IsReadOnly { get; set; }
        public event NotifyCollectionChangedEventHandler CollectionChanged;



        public Test()
        {
            current = new List<Question>();
        }

        //serialization
        public Test(SerializationInfo sInfo, StreamingContext contextArg)
        {
            this.current = (List<Question>)sInfo.GetValue("Test", typeof(List<Question>));
        }

        public void GetObjectData(SerializationInfo sInfo, StreamingContext contextArg)
        {

            sInfo.AddValue("Test", this.current);
        }

        //serialization
        public bool CompressFile(string pathToInitialFile, string pathToCompressedFile)
        {
            if (File.Exists(pathToInitialFile))
            {
                using (FileStream originalFileStream = File.Open(pathToInitialFile, FileMode.Open))
                {
                    using (FileStream compressedFileStream = File.Create(pathToCompressedFile))
                    {
                        using (GZipStream compressionStream = new GZipStream(compressedFileStream,
                           CompressionMode.Compress))
                        {
                            originalFileStream.CopyTo(compressionStream);
                        }
                    }
                }
            }
            else
            {
                return false;
            }
            return true;
        }

        public bool DecompressFile(string pathToCompressedFile, string pathToDecompressedFile)
        {
            if (File.Exists(pathToCompressedFile))
            {
                using (FileStream inFile = File.Open(pathToCompressedFile, FileMode.Open))
                {
                    using (FileStream outFile = File.Create(pathToDecompressedFile))
                    {
                        using (GZipStream Decompress = new GZipStream(inFile,
                                CompressionMode.Decompress))
                        {
                            Decompress.CopyTo(outFile);
                        }
                    }
                }
            }
            else
            {
                return false;
            }
            return true;
        }

        public void SaveToBinary(BinaryWriter outStream)
        {

            outStream.Write(current.Count);
            foreach (var question in current)
            {
                outStream.Write(question.Name);
                outStream.Write(question.Difficulty);
                foreach (var variant in question)
                {
                    outStream.Write(variant.Name);
                    outStream.Write(variant.Ans);
                }
            }

        }

        public void OpenBinary(BinaryReader instream)
        {
            int count = instream.ReadInt32();
            for (int i = 0; i < count; i++)
            {
                string _name = instream.ReadString();
                int _diff = instream.ReadInt32();
                string v1 = instream.ReadString();
                bool cor1 = instream.ReadBoolean();
                string v2 = instream.ReadString();
                bool cor2 = instream.ReadBoolean();
                string v3 = instream.ReadString();
                bool cor3 = instream.ReadBoolean();
                string v4 = instream.ReadString();
                bool cor4 = instream.ReadBoolean();
                string v5 = instream.ReadString();
                bool cor5 = instream.ReadBoolean();
                Addown(_name, v1, cor1, v2, cor2, v3, cor3, v4, cor4, v5, cor5, _diff);
            }
            if (CollectionChanged != null)
                CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
        }

        public void OpenText(StreamReader instream)
        {
            int count = Int32.Parse(instream.ReadLine());

            for (int i = 0; i < count; i++)
            {
                string _name = instream.ReadLine(); //instream.ReadString();
                int _diff = Int32.Parse(instream.ReadLine());
                string v1 = instream.ReadLine();
                bool cor1 = Boolean.Parse(instream.ReadLine());
                string v2 = instream.ReadLine();
                bool cor2 = Boolean.Parse(instream.ReadLine());
                string v3 = instream.ReadLine();
                bool cor3 = Boolean.Parse(instream.ReadLine());
                string v4 = instream.ReadLine();
                bool cor4 = Boolean.Parse(instream.ReadLine());
                string v5 = instream.ReadLine();
                bool cor5 = Boolean.Parse(instream.ReadLine());
                Addown(_name, v1, cor1, v2, cor2, v3, cor3, v4, cor4, v5, cor5, _diff);
            }

            if (CollectionChanged != null)
                CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
        }


        public void SaveToText(StreamWriter outStream)
        {
            outStream.WriteLine(current.Count);
            foreach (var question in current)
            {
                outStream.WriteLine(question.Name);
                outStream.WriteLine(question.Difficulty);
                foreach (var variant in question)
                {
                    outStream.WriteLine(variant.Name);
                    outStream.WriteLine(variant.Ans);
                }
            }
        }
        // public void Autoadd();

        public string GetAverage()
        {

            int s = 0;
            string outs;
            foreach (Question i in current)
            {
                s += i.Difficulty;
            }
            s = s / current.Count;
            outs = Convert.ToString(s);
            return outs;
        }

        public int GetCount()
        {
            int s = 0;
            s = current.Count;
            return s;

        }
        public Question GetQuestion(int c)
        {
            return current[c];
        }

        public void Addown(string q, string v1, bool c1, string v2, bool c2, string v3, bool c3, string v4, bool c4, string v5, bool c5, int diff)
        {

            Question oq = new Question(q, diff);
            current.Add(oq);
            if (v1 != null)
            {
                Variant NV1 = new Variant(v1, c1);
                oq.Add(NV1);

                if (v2 != null)
                {
                    Variant NV2 = new Variant(v2, c2);
                    oq.Add(NV2);

                    if (v3 != null)
                    {
                        Variant NV3 = new Variant(v3, c3);
                        oq.Add(NV3);

                        if (v4 != null)
                        {
                            Variant NV4 = new Variant(v4, c4);
                            oq.Add(NV4);

                            if (v5 != null)
                            {
                                Variant NV5 = new Variant(v5, c5);
                                oq.Add(NV5);
                            }
                        }
                    }
                }
            }
            if (CollectionChanged != null)
                CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
        }


        public void Clear()
        {
            current.Clear();
            if (CollectionChanged != null)
                CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
        }


        public bool Contains(Question q)
        {
            return current.Contains(q);
        }


        public bool Remove(Question q)
        {

            return current.Remove(q);
        }

        public void CopyTo(Question[] q, int index)
        {
            current.CopyTo(q, index);
        }


        public IEnumerator<Question> GetEnumerator()
        {
            foreach (Question i in current)
            {
                yield return i;
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }






    }
    [Serializable]
    public class Question : IEnumerable<Variant>, ISerializable
    {
        public int Count { get; set; }
        public bool IsReadOnly { get; set; }
        public string Name { get; set; }
        public int Difficulty { get; set; }
        public List<Variant> current { get; set; }

        //serialization
        public Question(SerializationInfo sInfo, StreamingContext contextArg)
        {
            this.Name = (string)sInfo.GetValue("Name", typeof(string));
            this.Difficulty = (int)sInfo.GetValue("Difficulty", typeof(int));
            this.current = (List<Variant>)sInfo.GetValue("Variants", typeof(List<Variant>));

        }

        public void GetObjectData(SerializationInfo sInfo, StreamingContext contextArg)
        {
            sInfo.AddValue("Name", this.Name);
            sInfo.AddValue("Difficulty", this.Difficulty);
            sInfo.AddValue("Variants", this.current);
        }

        //serialization

        public Variant GetVariant(int c)
        {
            return current[c];
        }

        public Question(string name, int difficulty)
        {
            current = new List<Variant>();
            Name = name;
            Difficulty = difficulty;
        }


        public void Add(Variant q)
        {

            current.Add(q);
        }



        public void Clear()
        {
            current.Clear();
        }


        public bool Contains(Variant q)
        {
            return current.Contains(q);
        }


        public bool Remove(Variant q)
        {
            --Count;
            return current.Remove(q);
        }

        public void CopyTo(Variant[] q, int index)
        {
            current.CopyTo(q, index);
        }

        public IEnumerator<Variant> GetEnumerator()
        {
            foreach (Variant i in current)
            {
                yield return i;
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }


    }
    [Serializable]
    public class Variant
    {


        //serialization
        public Variant(SerializationInfo sInfo, StreamingContext contextArg)
        {
            this.Ans = (bool)sInfo.GetValue("Answer", typeof(bool));
            this.Name = (string)sInfo.GetValue("Name", typeof(string));

        }

        public void GetObjectData(SerializationInfo sInfo, StreamingContext contextArg)
        {
            sInfo.AddValue("Answer", this.Ans);
            sInfo.AddValue("Name", this.Name);
        }

        //serialization


        public bool Ans;

        public string Name { get; set; }
        /*
         * 
         * 0 - incorrect;
         * 1 - correct;
         * 
         */

        public Variant(string name, bool ans)
        {
            Ans = ans;
            Name = name;
        }

    }
}