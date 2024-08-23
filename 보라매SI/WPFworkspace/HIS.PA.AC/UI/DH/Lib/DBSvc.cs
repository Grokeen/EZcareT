using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using System.Collections;
using DH.Entity;
using IBatisNet.DataMapper;
using IBatisNet.DataMapper.Configuration;
using System.Windows;
using System.IO;
using System.Data;
using System.Data.OracleClient;
using System.Xml;
using System.Text.RegularExpressions;

namespace DH.Lib
{
    public class DBSvc
    {
        public bool IsBusy { get; set; }



        private List<BaseEntity> param = new List<BaseEntity>();
        public List<BaseEntity> Param
        {
            get { return param; }
            //set { param = value; }
        }

        private List<IList> result = new List<IList>();
        public List<IList> Result
        {
            get { return result; }
            //set { result = value; }
        }

        private List<int> updateResult = new List<int>();
        public List<int> UpdateResult
        {
            get { return updateResult; }
        }


        public DBSvc()
        {
        }

        #region DB Select
        public void Select()
        {
            if (this.IsBusy)
            {
                return;
            }
            this.IsBusy = true;

            try
            {
                List<IList> result = this.SelectMulti(this.param.ToArray());

                int entityCnt = 0;
                foreach (IList item in this.Result)
                {
                    DBSvc.ConvertObservableCollection(item, result, entityCnt);

                    entityCnt++;
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("DB 조회 오류 : " + ex.ToString());
            }

            
            this.IsBusy = false;

            this.Param.Clear();
            this.Result.Clear();

        }

        //public List<IList> Select(BaseEntity[] arrQuery)
        //{
        //    return SelectMulti(arrQuery);
        //}

        public List<IList> SelectMulti(BaseEntity[] arrEntity)
        {
            ISqlMapper mapper = null;
            DomSqlMapBuilder dom = new DomSqlMapBuilder();

            //ArrayList lstResultSet = new ArrayList();
            List<IList> lstResultSet = new List<IList>();
            IList lstResult = null;

            foreach (BaseEntity item in arrEntity)
            {
                if (item == null)
                {
                    continue;
                }
                //mapper = GetMapper(item.DBGbn, item.ServiceName);
                mapper = GetMapper();


                //Type type = item.GetType();

                //// 쿼리실행
                try
                {
                    lstResult = mapper.QueryForList(item.QueryId, item);
                }
                catch(Exception ex)
                {
                    lstResult = null;
                    this.IsBusy = false;
                    throw ex;
                }

                // Data 없을시 처리
                //if (lstResult.Count == 0)
                //{
                //    continue;
                //}

                lstResultSet.Add(lstResult);

                //쿼리로그
                //InsertQueryLog(item);
            }
            return lstResultSet;
        }



        //public void SelectAsync()
        //{
        //    if (this.IsBusy)
        //    {
        //        return;
        //    }
        //    this.IsBusy = true;
        //    WcfSvc.SelectAsync(this.param.ToArray());
        //}
        //private void SelectCompleted(object sender, SelectCompletedEventArgs e)
        //{
        //    int entityCnt = 0;
        //    foreach (IList item in this.Result)
        //    {
        //        DB.ConvertObservableCollection(item, e.Result, entityCnt);

        //        entityCnt++;
        //    }

        //    this.IsBusy = false;

        //    this.Param.Clear();
        //    this.Result.Clear();

        //    if (SelectCompleted != null)
        //    {
        //        // 연결된 이벤트 실행 후 제거
        //        SelectCompleted(sender, e);
        //        SelectCompleted = null;
        //    }
        //}

        public int SelectCnt(BaseEntity param)
        {
            if (this.IsBusy)
            {
                return -1;
            }
            this.IsBusy = true;
            
            ISqlMapper mapper = null;
            DomSqlMapBuilder dom = new DomSqlMapBuilder();

            if (param == null)
            {
                return -1;
            }
            mapper = GetMapper();

            //// 쿼리실행
            int result = mapper.QueryForObject<int>(param.QueryId, param);

            //쿼리로그
            //InsertQueryLog(item);

            this.IsBusy = false;

            return result;
        }


        #endregion

        #region DB Update
        //public void Update()
        //{
        //    this.UpdateResult.Clear();

        //    if (this.IsBusy)
        //    {
        //        return;
        //    }
        //    this.IsBusy = true;
        //    ISqlMapper mapper = GetMapper(this.Param.DBGbn, param.ServiceName);

        //    object[] result = WcfSvc.Update(this.param.ToArray());

        //    int entityCnt = 0;
        //    foreach (object item in result)
        //    {
        //        this.UpdateResult.Add((int)item);
        //        entityCnt++;
        //    }

        //    this.IsBusy = false;
        //    this.Param.Clear();
        //}

        public void Update()
        {
            if (this.IsBusy)
            {
                return;
            }
            this.IsBusy = true;

            try
            {
                this.updateResult = this.UpdateMulti(this.param.ToArray());

            }
            catch (Exception ex)
            {
                MessageBox.Show("DB Update 오류 : " + ex.ToString());
            }


            this.IsBusy = false;

            this.Param.Clear();
            //this.Result.Clear();

        }


        public List<int> UpdateMulti(BaseEntity[] arrEntity)
        {
            ISqlMapper mapper = null;
            DomSqlMapBuilder dom = new DomSqlMapBuilder();

            //ArrayList lstResultSet = new ArrayList();
            List<int> lstResultSet = new List<int>();
            int update_cnt = 0;

            foreach (BaseEntity item in arrEntity)
            {
                if (item == null)
                {
                    continue;
                }
                mapper = GetMapper();


                //// 쿼리실행
                try
                {
                    update_cnt = mapper.Update(item.QueryId, item);
                }
                catch (Exception ex)
                {
                    this.IsBusy = false;
                    throw ex;
                }


                lstResultSet.Add(update_cnt);

                //쿼리로그
                //InsertQueryLog(item);
            }
            return lstResultSet;
        }
        #endregion





        //public ArrayList Update(BaseEntity[] arrQuery)
        //{
        //    return UpdateMulti(arrQuery);
        //}

        //public ArrayList UpdateMulti(BaseEntity[] arrEntity)
        //{
        //    ISqlMapper mapper = null;
        //    DomSqlMapBuilder dom = new DomSqlMapBuilder();

        //    ArrayList lstResultSet = new ArrayList();
        //    //object iResult;

        //    foreach (BaseEntity item in arrEntity)
        //    {
        //        if (item == null)
        //        {
        //            continue;
        //        }

        //        mapper = GetMapper(item.ServiceName);


        //        try
        //        {
        //            //// 쿼리실행
        //            mapper.Update(item.QueryId, item);
        //            lstResultSet.Add(1);
        //        }
        //        catch
        //        {
        //            lstResultSet.Add(0);
        //        }

        //        //쿼리로그
        //        //InsertQueryLog(item);

        //    }
        //    return lstResultSet;
        //}


        //Dictionary<string, ISqlMapper> lstMapper = new Dictionary<string, ISqlMapper>();
        //private ISqlMapper GetMapper(string DBGbn, string ServiceName)
        //{
        //    ISqlMapper mapper = null;

        //    if (lstMapper.ContainsKey(ServiceName))
        //    {
        //        mapper = lstMapper[ServiceName];
        //    }
        //    else
        //    {
        //        DomSqlMapBuilder dom = new DomSqlMapBuilder();
        //        //string config_file = string.Format(@".\Config\DH.{0}.{1}.SqlMap.config", DBGbn.ToUpper(), ServiceName.ToUpper());
        //        string config_file = string.Format(@".\Config\DH.SqlMap.config", DBGbn.ToUpper(), ServiceName.ToUpper());

        //        #region 주석
        //        //if (ServiceName.ToUpper() == "ADM")
        //        //{
        //        //    config_file = "DH.Adm.SqlMap.config";
        //        //}
        //        //else if (ServiceName.ToUpper() == "MED")
        //        //{
        //        //    mapper = dom.Configure(@"DH.Med.SqlMap.config");
        //        //}
        //        //else if (ServiceName.ToUpper() == "SUP")
        //        //{
        //        //    mapper = dom.Configure(@"DH.Sup.SqlMap.config");
        //        //}
        //        //else if (ServiceName.ToUpper() == "COM")
        //        //{
        //        //    mapper = dom.Configure(@"DH.Com.SqlMap.config");
        //        //}
        //        //else if (ServiceName.ToUpper() == "GEN")
        //        //{
        //        //    mapper = dom.Configure(@"DH.Gen.SqlMap.config");
        //        //}
        //        //else
        //        //{
        //        //    mapper = dom.Configure(@"DH.SqlMap.config");
        //        //}
        //        #endregion

        //        if (File.Exists(config_file))
        //        {
        //            mapper = dom.Configure(config_file);
        //        }
        //        else
        //        {
        //            throw new Exception("config 파일 로드 실패!");
        //        }
        //    }
            

        //    return mapper;
        //}

        private ISqlMapper GetMapper()
        {
            ISqlMapper mapper = null;

            DomSqlMapBuilder dom = new DomSqlMapBuilder();
            string config_file = string.Format(@".\Config\DH.SqlMap.config");

            if (File.Exists(config_file))
            {
                mapper = dom.Configure(config_file);
            }
            else
            {
                throw new Exception("config 파일 로드 실패!");
            }


            return mapper;
        }



        public DataSet ExecuteQueryForMakeDTO(string query)
        {
            return this.ExecuteQueryForMakeDTO(this.GetConnectionString(), query);
        }

        public DataSet ExecuteQueryForMakeDTO(string connString, string query)
        {
            //코멘트 제거
            query = this.RemoveComment(query);

            if (string.IsNullOrEmpty(query)) return null;

            DataSet ds = new DataSet();
            string connectionString = connString;
            if (string.IsNullOrEmpty(connectionString)) return null;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                OracleCommand cmd = new OracleCommand(query, conn);
                cmd.CommandType = CommandType.Text;

                MatchCollection matches = Regex.Matches(query, @":\w+");
                foreach (Match match in matches)
                {
                    foreach (Capture capture in match.Captures)
                    {
                        //if (capture.Value.ToUpper() == ":MI" || capture.Value.ToUpper() == ":SS")
                        if (capture.Value.Length < 4)
                        {
                            continue;
                        }

                        string str = capture.Value.Substring(1, 1); //첫자리만 잘라서 숫자인지 체크함.
                        int num; //숫자이면 skip.
                        if (Int32.TryParse(str, out num))
                        {
                            continue;
                        }

                        cmd.Parameters.Add(new OracleParameter(capture.Value, ""));
                        //Console.WriteLine("Index={0}, Value={1}", capture.Index, capture.Value);
                    }
                }

                OracleDataAdapter adapter = new OracleDataAdapter(cmd);
                
                adapter.Fill(ds);
            }

            return ds;
        }



        public DataSet ExecuteQuery(string query)
        {
            return this.ExecuteQuery(this.GetConnectionString(), query);
        }


        public DataSet ExecuteQuery(string connString, string query)
        {
            //코멘트 제거
            query = this.RemoveComment(query);

            if (string.IsNullOrEmpty(query)) return null;

            DataSet ds = new DataSet();
            string connectionString = connString;
            if (string.IsNullOrEmpty(connectionString)) return null;

            //using (OracleConnection conn = new OracleConnection(connectionString))
            //{
        
            //    OracleCommand cmd = new OracleCommand(query, conn);
            //    cmd.CommandType = CommandType.Text;

            //    OracleDataAdapter adapter = new OracleDataAdapter(cmd);
            //    adapter.Fill(ds);
            //}

            return ds;
        }

        private string GetConnectionString()
        {
            string config_file = string.Format(@".\Config\DH.SqlMap.config");
            XmlDocument xml = new XmlDocument();
            xml.Load(config_file);

            string connectionString = "";
            try
            {
                connectionString = xml.ChildNodes[1]["database"]["dataSource"].Attributes["connectionString"].Value;
            } catch { }

            return connectionString;


        }

        public string RemoveComment(string sql)
        {
            string blockComments = @"/\*(.*?)\*/";
            string lineComments = @"--(.*?)\r?\n";
            string strings = @"""((\\[^\n]|[^""\n])*)""";
            string verbatimStrings = @"@(""[^""]*"")+";

            string noComments = Regex.Replace(sql, blockComments + "|" + lineComments + "|" + strings + "|" + verbatimStrings, me =>
                                {
                                    if (me.Value.StartsWith("/*") || me.Value.StartsWith("--"))
                                        return me.Value.StartsWith("--") ? Environment.NewLine : "";
                                    // Keep the literal strings
                                    return me.Value;
                                }, RegexOptions.Singleline);

            return noComments;

        }


        #region Static Member
        //public static void ConvertObservableCollection<T>(ObservableCollection<T> oc, object[] dataSet, int tableIdx)
        //{
        //    if (oc == null)
        //    {
        //        return;
        //    }
        //    if (dataSet.Length <= tableIdx)
        //    {
        //        return;
        //    }
        //    object[] arrTables = (object[])dataSet[tableIdx];

        //    //oc.Clear();
        //    foreach (T item in arrTables)
        //    {
        //        oc.Add(item);
        //    }
        //}


        //public static void ConvertObservableCollection(IList il, object[] dataSet, int tableIdx)
        //{
        //    if (il == null)
        //    {
        //        return;
        //    }
        //    if (dataSet.Length <= tableIdx)
        //    {
        //        return;
        //    }
        //    object[] arrTables = (object[])dataSet[tableIdx];

        //    //oc.Clear();
        //    foreach (var item in arrTables)
        //    {
        //        il.Add(item);
        //    }
        //}
        public static void ConvertObservableCollection(IList il, IList dataSet, int tableIdx)
        {
            if (il == null)
            {
                return;
            }
            if (dataSet.Count <= tableIdx)
            {
                return;
            }
            //object[] arrTables = (object[])dataSet[tableIdx];

            //oc.Clear();

            foreach (var item in (IList)dataSet[tableIdx])
            {
                il.Add(item);
            }
        }


        public static T CreateEntity<T>() where T : new()
        {
            T param = new T();

            BaseEntity baseParam = param as BaseEntity;
            if (baseParam != null)
            {
                baseParam.Mode = "S"; //Default : Select

                if (Application.Current.Properties["ServiceName"] == null)
                {
                    baseParam.ServiceName = "DH";
                }
                else
                {
                    baseParam.ServiceName = Application.Current.Properties["ServiceName"].ToString();
                }

                if (Application.Current.Properties["DBGbn"] == null)
                {
                    baseParam.DBGbn = "APP";
                }
                else
                {
                    baseParam.DBGbn = Application.Current.Properties["DBGbn"].ToString();
                }

                
                //baseParam.FromDate = "0000";
                //baseParam.ToDate = "9999";

                //if (System.Windows.Application.Current.Properties["wkpers"] != null)
                //{
                //    baseParam.RegId = System.Windows.Application.Current.Properties["wkpers"].ToString();
                //    baseParam.EditId = System.Windows.Application.Current.Properties["wkpers"].ToString();
                //}
            }

            return param;
        }
        #endregion


    }
}
