﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace formLogin
{
    public partial class thongKe : Form
    {
        public thongKe()
        {
            InitializeComponent();
        }

        private void thongKe_Load(object sender, EventArgs e)
        {
            DataTable dt = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("TKDT_NAM");
            chart1.DataSource = dt;
            chart1.Series["DoanhThu"].XValueMember = "THANG";
            chart1.Series["DoanhThu"].YValueMembers = "DOANHTHU";
            DataTable dtb = ClassProvider.dataProvider.Instance.GetDataTableByProcedure("TKSLHD");
            chart2.DataSource = dtb;
            chart2.Series["SoHoaDon"].XValueMember = "THANG";
            chart2.Series["SoHoaDon"].YValueMembers = "SOLUONGHD";



        }
    }
}